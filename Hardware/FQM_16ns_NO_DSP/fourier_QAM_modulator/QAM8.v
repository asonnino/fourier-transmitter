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
//////////////////////////////////////////////////////////////////////////////////
module QAM8 #(
	 /* Parameters */
	 parameter N  = 16,        // Number of parallel inputs
	 parameter W  = 16         // Bus width
)(
    /* Input and output ports */
    input  wire [3*N-1:0] in,   // Clustered input stream
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
			case({in[3*i+2],in[3*i+1],in[3*i]}) // assign I value
				3'b000:   begin I[W*i+(W-1):W*i] =  p1;   Q[W*i+(W-1):W*i] =  last; end
				3'b001:   begin I[W*i+(W-1):W*i] = -last; Q[W*i+(W-1):W*i] = -p1;   end
				3'b010:   begin I[W*i+(W-1):W*i] =  last; Q[W*i+(W-1):W*i] =  p1;   end
				3'b011:   begin I[W*i+(W-1):W*i] =  last; Q[W*i+(W-1):W*i] = -p1;   end
				3'b100:   begin I[W*i+(W-1):W*i] = -p1;   Q[W*i+(W-1):W*i] =  last; end
				3'b101:   begin I[W*i+(W-1):W*i] = -p1;   Q[W*i+(W-1):W*i] = -last; end
				3'b110:   begin I[W*i+(W-1):W*i] = -last; Q[W*i+(W-1):W*i] =  p1;   end
				3'b111:   begin I[W*i+(W-1):W*i] = -p1;   Q[W*i+(W-1):W*i] = -last; end
				default:  begin I[W*i+(W-1):W*i] = 'dx;   Q[W*i+(W-1):W*i] = 'dx;   end
			endcase
		end
	 endgenerate
	 
	 /***************************************************************************/


endmodule		

		
		           

