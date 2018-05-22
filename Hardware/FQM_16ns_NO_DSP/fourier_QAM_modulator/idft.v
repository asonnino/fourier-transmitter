`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:  Karlsruhe Institute of Technologies (KIT) - ITIV Departement
// Engineer: Sonnino Alberto
// 
// Create Date:    11:55:46 05/09/2015 
// Design Name: 	 Fourier QAM Modulator v4
// Module Name:    fft 
// Project Name:   Fourier QAM Modulator
// Target Devices: Xilinx Virtex 7
// Tool versions:  Xilinx ISE Design Suite 14.7
// Description: 
// Compute the Inverse Discrete Fourier Transform
//
// Dependencies: 
// - Complex Multiplier 5.0
// - Adder Substracter 11.0
//
// Revision: 
// Revision 0.01 - File Created
//
// Additional Comments: 
//////////////////////////////////////////////////////////////////////////////////
module idft #(
	 /* Parameters */
	 parameter N = 16                // Transform length
)(
	 /* Input and output ports */
    input  wire              clk,   // Clock
    input  wire              reset, // Reset
	 input  wire [16*N-1:0]   xn_re, // DFT real input
	 input  wire [16*N-1:0]   xn_im, // DFT imaginary input
	 input  wire [16*N*N-1:0] ccos,  // Cosine IDFT coefficients
	 input  wire [16*N*N-1:0] csin,  // Sine IDFT coefficients
	 output wire [16*N-1:0]   xk_re, // IDFT real output
	 output wire [16*N-1:0]   xk_im  // IDFT imaginary output
);
	  
	  
	 /***************************************************************************
	 * Internal Signals
	 ***************************************************************************/
	 wire [16*N*N-1:0] t_re, t_im; // Temp signals to store complex products
	 wire [16*N*N-1:0] a_re, a_im; // Temp signals to store complex sums


	 /***************************************************************************
	 * Compute DFT and Resize by 2^(-17)
	 ***************************************************************************/
	 // NOTE: The complex multipliers resize by 2^(-17) and not by 2^(-16)
	 genvar k,n,i;
	 generate 
		for(k=0; k < N; k=k+1) begin
			// Compute complex products
			for(n=0; n < N; n=n+1) begin
				complex_mult complex_mult_fft_inst (
					.aclk(clk),                // input aclk
					.aresetn(~reset),          // input aresetn
					.s_axis_a_tvalid(1'b1),    // input s_axis_a_tvalid
					.s_axis_a_tdata({
						xn_im[16*n+(16-1):16*n],// IDFT imaginary input
						xn_re[16*n+(16-1):16*n] // IDFT real input
					}), 								
					.s_axis_b_tvalid(1'b1),    // input s_axis_b_tvalid
					.s_axis_b_tdata({
						csin[16*(N-1-n)+(16-1)+N*16*(N-1-k):16*(N-1-n)+N*16*(N-1-k)], // sine DFT coefficients
						ccos[16*(N-1-n)+(16-1)+N*16*(N-1-k):16*(N-1-n)+N*16*(N-1-k)]  // cosine DFT coefficients
					}), 																				
					.s_axis_ctrl_tvalid(1'b1), // input s_axis_ctrl_tvalid
					.s_axis_ctrl_tdata(8'b0),  // input [7 : 0] s_axis_ctrl_tdata
					.m_axis_dout_tvalid(),     // output m_axis_dout_tvalid
					.m_axis_dout_tdata({
						t_im[16*n+(16-1)+N*16*k:16*n+N*16*k], // DFT imaginary output
						t_re[16*n+(16-1)+N*16*k:16*n+N*16*k]  // DFT real output
					}) 
				);
			end
			
			// Sum up complex products
			adder_fft adder_fft_inst_re (
			.a(t_re[16*0+(16-1)+N*16*k:16*0+N*16*k]), // input [15 : 0] a
			.b(t_re[16*1+(16-1)+N*16*k:16*1+N*16*k]), // input [15 : 0] b
			.sclr(reset),                               // input sclr
			.s(a_re[16*0+(16-1)+N*16*k:16*0+N*16*k])  // output [15 : 0] s
			);			
			adder_fft adder_fft_inst_im (
			.a(t_im[16*0+(16-1)+N*16*k:16*0+N*16*k]), // input [15 : 0] a
			.b(t_im[16*1+(16-1)+N*16*k:16*1+N*16*k]), // input [15 : 0] b
			.sclr(reset),                               // input sclr
			.s(a_im[16*0+(16-1)+N*16*k:16*0+N*16*k])  // output [15 : 0] s
			);
			for(i=2; i < N; i=i+1) begin
				adder_fft adder_fft_inst_re_loop (
					.a(t_re[16*i+(16-1)+N*16*k:16*i+N*16*k]),         // input [15 : 0] a
					.b(a_re[16*(i-2)+(16-1)+N*16*k:16*(i-2)+N*16*k]), // input [15 : 0] b
					.sclr(reset),                                     // input sclr
					.s(a_re[16*(i-1)+(16-1)+N*16*k:16*(i-1)+N*16*k])  // output [15 : 0] s
				);				
				adder_fft adder_fft_inst_im_loop (
					.a(t_im[16*i+(16-1)+N*16*k:16*i+N*16*k]),         // input [15 : 0] a
					.b(a_im[16*(i-2)+(16-1)+N*16*k:16*(i-2)+N*16*k]), // input [15 : 0] b
					.sclr(reset),                                     // input sclr
					.s(a_im[16*(i-1)+(16-1)+N*16*k:16*(i-1)+N*16*k])  // output [15 : 0] s
				);
			end 
			
			// Assign output
			assign xk_re[16*k+(16-1):16*k] = a_re[16*(N-2)+(16-1)+N*16*k:16*(N-2)+N*16*k];
			assign xk_im[16*k+(16-1):16*k] = a_im[16*(N-2)+(16-1)+N*16*k:16*(N-2)+N*16*k];
			
		end 
	endgenerate

	/***************************************************************************/


endmodule
