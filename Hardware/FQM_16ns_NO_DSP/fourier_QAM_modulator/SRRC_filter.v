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
// Implement a parallel SRRC filter in frequency domain. 
//
// Dependencies: 
// - Multiplier 11.2
//
// Revision: 
// Revision 0.01 - File Created
//
// Additional Comments: 
//////////////////////////////////////////////////////////////////////////////////
module SRRC_filter #(
	 /* Parameters */
	 parameter N  = 16                 // Number of parallel inputs
)(
    /* Input and output ports */
    input  wire            clk,        // Clock
	 input  wire            reset,      // Reset
	 input  wire [16*N-1:0] H,          // Filter coefficients
    input  wire [16*N-1:0] X_re, X_im, // Inputs
	 output wire [16*N-1:0] Y_re, Y_im  // Outputs
);


	 /***************************************************************************
	 * Filter and Resize by 2*(-16)
	 ***************************************************************************/
	 genvar i;
	 generate 
		for(i=0; i < N; i=i+1) begin
			mult mult_filter_inst_re (
				.clk(clk),                           // input clk
				.a(X_re[16*i+(16-1):16*i]),          // input [15 : 0] a
				.b(H[16*(N-1-i)+(16-1):16*(N-1-i)]), // input [15 : 0] b
				.sclr(reset),                        // input sclr
				.p(Y_re[16*i+(16-1):16*i])           // output [15 : 0] p
			);
			mult mult_filter_inst_im (
				.clk(clk),                           // input clk
				.a(X_im[16*i+(16-1):16*i]),          // input [15 : 0] a
				.b(H[16*(N-1-i)+(16-1):16*(N-1-i)]), // input [15 : 0] b
				.sclr(reset),                        // input sclr
				.p(Y_im[16*i+(16-1):16*i])           // output [15 : 0] p
			);
		end
	 endgenerate
	 
	 /***************************************************************************/


endmodule
