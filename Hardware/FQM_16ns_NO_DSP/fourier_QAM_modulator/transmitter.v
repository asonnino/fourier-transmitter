`timescale 1ns / 1ps
//`include "util/array_pack_unpack.v"
//////////////////////////////////////////////////////////////////////////////////
// Company:  Karlsruhe Institute of Technologies (KIT) - ITIV Departement
// Engineer: Sonnino Alberto
// 
// Create Date:    11:55:46 05/09/2015 
// Design Name: 	 Fourier QAM Modulator v4
// Module Name:    transmitter 
// Project Name:   Fourier QAM Modulator
// Target Devices: Xilinx Virtex 7
// Tool versions:  Xilinx ISE Design Suite 14.7
// Description: 
// This design aims to implement a parallel functional QAM modulator with filtering
// operation performed in frequency domain. 
//
// Dependencies: 
// - QAM
// - FFT
// - SRRC_FILTER
// - IFFT
// - MODULATOR
// - DFT_COEFF
// - CARRIERS
//
// Revision: 
// Revision 0.01 - File Created
//
// Additional Comments: 
//////////////////////////////////////////////////////////////////////////////////
 module transmitter #(
	/* Parameters */
	parameter N      = 16,             // Number of paralle inputs
	parameter FORMAT = 3'b100          // QAM order
)(
	/* Input and output ports */
	input  wire                clk,    // System clock
	input  wire                reset,  // Global reset
	input  wire [FORMAT*N-1:0] in,     // Clustered input stream  
	output wire                tvalid, // TVALID flag
	output wire [16*N-1:0]     out    // Transmiter's output
	/* Wires for testbench */

);
	 
	 
	 /***************************************************************************
	 * Internal Signals
	 ***************************************************************************/
	 wire [16*N*N-1:0] ccos, csin; // DFT coefficients
	 wire [16*N-1:0]   H;          // Filter coefficients
	 wire [15:0]       H_max;      // Highest filter coefficient
	 wire [16*N-1:0]   sin, cos;   // Carriers
	 wire [16*N-1:0] I, Q;  
	 wire [16*N-1:0] xk_re, xk_im;
	 wire [16*N-1:0] Y_re, Y_im;
	 wire [16*N-1:0] sn_re, sn_im;
	 // ----> other internal signals are exported to testbench
	  
	  
	 /***************************************************************************
	 * Config.
	 ***************************************************************************/	
	 // Load DFT Coefficients
	 dft_coeff dft_coeff_inst(
		.ccos(ccos),  							  // Cosine DFT coefficients
		.csin(csin)   							  // Sine DFT coefficients
	 );
	 // Load filter coefficients
	 filter_coeff filter_coeff_inst(
		.H(H),        							  // Filter coefficients
		.H_max(H_max) 							  // Highest filter coefficient
	 );
	 // Load carriers
	 carriers carriers_inst(
		.clk(clk),								  // Clock
		.reset(reset | (~|{sn_re,sn_im})), // Reset
		.cos(cos), 	   	                 // Cosine carrier
		.sin(sin)    		                 // Sine carrier
	 );
	 
	 // Assign tvalid signal
	 assign tvalid = 'b0;

	 /***************************************************************************/



	 /***************************************************************************
	 * QAM mapping
	 ***************************************************************************/
	 QAM #(
		.N(N),          // Number of parallel inputs
		.W(16),         // Bus Witdh
		.FORMAT(FORMAT) // QAM order  
	 ) QAM_isnt(
		.in(in),        // Clustered input stream
		.last(H_max),   // Last constellation point
		.I(I),		    // In-phase component  
	   .Q(Q)           // Quadrature component
	 );
	  
	  
	 /***************************************************************************
	 * DFT
	 ***************************************************************************/	 
	 dft #(
		.N(N)          // Transform length
	 ) dft_inst(
		.clk(clk),     // Clock
		.reset(reset), // Reset
		.xn_re(I),     // DFT real input
		.xn_im(Q),     // DFT imaginary input
		.ccos(ccos),   // Cosine DFT coefficients
		.csin(csin),   // Sine DFT coefficients
	   .xk_re(xk_re), // DFT real input
	   .xk_im(xk_im)  // DFT imaginary input
	 );
	 
	 
	 /***************************************************************************
	 * SRRC filter
	 ***************************************************************************/
	 SRRC_filter #(
		.N(N)          // Number of parallel inputs
	 ) SRRC_filter_inst (
		.clk(clk),     // Clock
		.reset(reset), // Reset
		.H(H),         // Filter coefficients
      .X_re(xk_re),  // Filter's real input
		.X_im(xk_im),  // Filter's imaginary input
		.Y_re(Y_re),   // Filter's real output
		.Y_im(Y_im)    // Filter's imaginary output
	 );
	  
	  
	 /***************************************************************************
	 * IDFT
	 ***************************************************************************/
	 idft #(
		.N(N)          // Transform length
	 ) idft_inst(
		.clk(clk),     // Clock
		.reset(reset), // Reset
		.xn_re(Y_re),  // DFT real input
		.xn_im(Y_im),  // DFT imaginary input
		.ccos(ccos),   // Cosine DFT coefficients
		.csin(csin),   // Sine DFT coefficients
	   .xk_re(sn_re), // DFT real input
	   .xk_im(sn_im)  // DFT imaginary input
	 );
		

	 /***************************************************************************
	 * Modulator
	 ***************************************************************************/
	 modulator #(
		.N(N)          // Number of parallel inputs
	 ) modulator_inst (
		.clk(clk),     // Clock
		.reset(reset), // Reset
		.I(sn_re),     // In-phase input
		.Q(sn_im),     // In-Quadrature input
		.sin(sin),     // In-phase carrier
		.cos(cos),     // Quadrature carrier
		.dout(out)     // Output
	 );
	 
	 /***************************************************************************/
	
	
endmodule
