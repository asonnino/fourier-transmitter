`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:  Karlsruhe Institute of Technologies (KIT) - ITIV Departement
// Engineer: Sonnino Alberto
// 
// Create Date:    11:55:46 05/09/2015 
// Design Name: 	 Fourier QAM Modulator v4
// Module Name:    SRRC_filter 
// Project Name:   Fourier QAM Modulator
// Target Devices: Xilinx Virtex 7
// Tool versions:  Xilinx ISE Design Suite 14.7
// Description: 
// Modulate the input signal by the intput carriers following the QAM scheme. 
//
// Dependencies: 
// - Multiplier 11.2
// - Adder Substracter 11.0
//
// Revision: 
// Revision 0.01 - File Created
//
// Additional Comments: 
//////////////////////////////////////////////////////////////////////////////////
module modulator #(
	 /* Parameters */
	 parameter N  = 16             // Number of parallel inputs
 )(
    input  wire            clk,   // Clock
    input  wire            reset, // Reset
    input  wire [16*N-1:0] I,     // In-phase input
	 input  wire [16*N-1:0] Q,     // Quadrature input
	 input  wire [16*N-1:0] cos,   // In-phase carrier
	 input  wire [16*N-1:0] sin,   // Quadrature carrier
    output wire [16*N-1:0] dout   // Output
);


	 /***************************************************************************
	 * Internal Signals
	 ***************************************************************************/
	 wire [16*N-1:0] p1, p2;
	
	
	 /***************************************************************************
	 * Multiplier and Substracter - Rescaling 2^(-16)
	 ***************************************************************************/
	 genvar i;
	 generate 
		for(i=0; i < N; i=i+1) begin
			// Multiplier
			mult mult_mod_inst_re (
				.clk(clk),                             // input clk
				.a(I[16*i+(16-1):16*i]),               // input [15 : 0] a
				.b(cos[16*(N-1-i)+(16-1):16*(N-1-i)]), // input [15 : 0] b
				.sclr(reset),                          // input sclr
				.p(p1[16*i+(16-1):16*i])               // output [15 : 0] p
			);
			mult mult_mod_inst_im (
				.clk(clk),                             // input clk
				.a(Q[16*i+(16-1):16*i]),               // input [15 : 0] a
				.b(sin[16*(N-1-i)+(16-1):16*(N-1-i)]), // input [15 : 0] b
				.sclr(reset),                          // input sclr
				.p(p2[16*i+(16-1):16*i])               // output [15 : 0] p
			);
			// Substracter
			substracter substracter_mod_inst (
				.a(p1[16*i+(16-1):16*i]),             // input [15 : 0] a
				.b(p2[16*i+(16-1):16*i]),             // input [15 : 0] b
				.clk(clk),                            // input clk
				.sclr(reset),                         // input sclr
				.s(dout[16*i+(16-1):16*i])            // output [15 : 0] s
			);
		end
	 endgenerate

	 /***************************************************************************/	
	
	
endmodule
