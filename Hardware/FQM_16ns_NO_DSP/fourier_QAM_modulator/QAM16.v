`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:  Karlsruhe Institute of Technologies (KIT) - ITIV Departement
// Engineer: Sonnino Alberto
// 
// Create Date:    11:55:46 05/09/2015 
// Design Name: 	 Fourier QAM Modulator v4
// Module Name:    QAM16 
// Project Name:   Fourier QAM Modulator
// Target Devices: Xilinx Virtex 7
// Tool versions:  Xilinx ISE Design Suite 14.7
// Description: 
// QAM 16 mapping operation
//
// Dependencies: 
// -
// 
// Revision:
// Revision 0.01 - File Created
//
// Additional Comments:
// Three times the constallation distance 3*D equals the higest filter value:
// 3*D = 0.54098593171027443 
// After rescaling (mult. by 2^15) we obtain 3*D = 17727.
// Assign to I and Q value is done using the following convention:
// [3] [2] [1] [0]          I = {I1, I2} = 10
// I1  Q1  I2  Q2      =>   Q = {Q1, Q2} = 10
// 1   1   0   0
// This will ensure Gray Coding
//////////////////////////////////////////////////////////////////////////////////
module QAM16 #(
	 /* Parameters */
	 parameter N  = 16,        // Number of parallel inputs
	 parameter W  = 16         // Bus width
 )(
    /* Input and output ports */
    input  wire [4*N-1:0] in,   // Clustered input stream
	 input  wire [W-1:0]   last, // Last constellation point
    output reg  [W*N-1:0] I,    // In-phase component
	 output reg  [W*N-1:0] Q     // Quadrature component
 );


	 /***************************************************************************
	 * Internal Signals
	 ***************************************************************************/
	 wire [W-1:0] p1; // First constellation point
	  
	 /***************************************************************************
	 * Config.
	 ***************************************************************************/
	 // Compute other constellation point
	 assign p1 = last / 3; // *(1/3) 


	 /***************************************************************************
	 * QAM Mapping
	 ***************************************************************************/
	 genvar i;
	 generate for(i=0; i < N; i=i+1)
		always@(*) begin
			case({in[4*i+3],in[4*i+1]}) // assign I value
				2'b00:   I[W*i+(W-1):W*i] =  p1;
				2'b01:   I[W*i+(W-1):W*i] =  last;
				2'b10:   I[W*i+(W-1):W*i] = -p1;
				2'b11:   I[W*i+(W-1):W*i] = -last;
				default: I[W*i+(W-1):W*i] = 'dx; 
			endcase
			case({in[4*i+2],in[4*i]})   // assign Q value
				2'b00:   Q[W*i+(W-1):W*i] =  p1;
				2'b01:   Q[W*i+(W-1):W*i] =  last;
				2'b10:   Q[W*i+(W-1):W*i] = -p1;
				2'b11:   Q[W*i+(W-1):W*i] = -last;
				default: Q[W*i+(W-1):W*i] = 'dx;
			endcase
		end
	 endgenerate
	 
	 /***************************************************************************/


endmodule		

		
		           

