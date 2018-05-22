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
module QAM32 #(
	 /* Parameters */
	 parameter N  = 16,        // Number of parallel inputs
	 parameter W  = 16         // Bus width
)(
    /* Input and output ports */
    input  wire [5*N-1:0] in, // Clustered input stream
	 input  wire [W-1:0]   last, // Last constellation point
    output reg  [W*N-1:0] I,  // In-phase component
	 output reg  [W*N-1:0] Q   // Quadrature component
);


	 /***************************************************************************
	 * Internal Signals
	 ***************************************************************************/
	 wire [W-1:0] p1, p3; // First constellation point
	  
	 /***************************************************************************
	 * Config.
	 ***************************************************************************/
	 // Compute other constellation point
	 assign p1 = last / 5;   // *(1/5)
	 assign p3 = p1   * 3;   // *(3/5)


	 /***************************************************************************
	 * QAM Mapping
	 ***************************************************************************/
	 genvar i;
	 generate for(i=0; i < N; i=i+1)
		always@(*) begin
			case({in[5*i+4],in[5*i+3],in[5*i+2],in[5*i+1],in[5*i]})
				5'b00000:   begin I[W*i+(W-1):W*i] = -p3;   Q[W*i+(W-1):W*i] =  last; end
				5'b00001:   begin I[W*i+(W-1):W*i] = -last; Q[W*i+(W-1):W*i] = -p1;   end
				5'b00010:   begin I[W*i+(W-1):W*i] =  p3;   Q[W*i+(W-1):W*i] =  p3;   end
				5'b00011:   begin I[W*i+(W-1):W*i] = -p1;   Q[W*i+(W-1):W*i] = -p3;   end
				5'b00100:   begin I[W*i+(W-1):W*i] = -last; Q[W*i+(W-1):W*i] =  p3;   end
				5'b00101:   begin I[W*i+(W-1):W*i] =  p3;   Q[W*i+(W-1):W*i] = -p1;   end
				5'b00110:   begin I[W*i+(W-1):W*i] = -p1;   Q[W*i+(W-1):W*i] =  p1;   end
				5'b00111:   begin I[W*i+(W-1):W*i] = -p3;   Q[W*i+(W-1):W*i] = -last; end
				
				5'b01000:   begin I[W*i+(W-1):W*i] =  p1;   Q[W*i+(W-1):W*i] =  last; end
				5'b01001:   begin I[W*i+(W-1):W*i] = -p1;   Q[W*i+(W-1):W*i] = -p1;   end
				5'b01010:   begin I[W*i+(W-1):W*i] = -last; Q[W*i+(W-1):W*i] =  p1;   end
				5'b01011:   begin I[W*i+(W-1):W*i] =  p3;   Q[W*i+(W-1):W*i] = -p3;   end
				5'b01100:   begin I[W*i+(W-1):W*i] = -p1;   Q[W*i+(W-1):W*i] =  p3;   end
				5'b01101:   begin I[W*i+(W-1):W*i] = -last; Q[W*i+(W-1):W*i] = -p3;   end
				5'b01110:   begin I[W*i+(W-1):W*i] =  p3;   Q[W*i+(W-1):W*i] =  p1;   end
				5'b01111:   begin I[W*i+(W-1):W*i] =  p1;   Q[W*i+(W-1):W*i] = -last; end
				
				5'b10000:   begin I[W*i+(W-1):W*i] = -p1;   Q[W*i+(W-1):W*i] =  last; end
				5'b10001:   begin I[W*i+(W-1):W*i] = -p3;   Q[W*i+(W-1):W*i] = -p1;   end
				5'b10010:   begin I[W*i+(W-1):W*i] =  last; Q[W*i+(W-1):W*i] =  p3;   end
				5'b10011:   begin I[W*i+(W-1):W*i] =  p1;   Q[W*i+(W-1):W*i] = -p3;   end
				5'b10100:   begin I[W*i+(W-1):W*i] = -p3;   Q[W*i+(W-1):W*i] =  p3;   end
				5'b10101:   begin I[W*i+(W-1):W*i] =  last; Q[W*i+(W-1):W*i] = -p1;   end
				5'b10110:   begin I[W*i+(W-1):W*i] =  p1;   Q[W*i+(W-1):W*i] =  p1;   end
				5'b10111:   begin I[W*i+(W-1):W*i] = -p1;   Q[W*i+(W-1):W*i] = -last; end
				
				5'b11000:   begin I[W*i+(W-1):W*i] =  p3;   Q[W*i+(W-1):W*i] =  last; end
				5'b11001:   begin I[W*i+(W-1):W*i] =  p1;   Q[W*i+(W-1):W*i] = -p1;   end
				5'b11010:   begin I[W*i+(W-1):W*i] =  -p3;  Q[W*i+(W-1):W*i] =  p1;   end
				5'b11011:   begin I[W*i+(W-1):W*i] =  last; Q[W*i+(W-1):W*i] = -p3;   end
				5'b11100:   begin I[W*i+(W-1):W*i] =  p1;   Q[W*i+(W-1):W*i] =  p3;   end
				5'b11101:   begin I[W*i+(W-1):W*i] = -p3;   Q[W*i+(W-1):W*i] = -p3;   end
				5'b11110:   begin I[W*i+(W-1):W*i] =  last; Q[W*i+(W-1):W*i] =  p1;   end
				5'b11111:   begin I[W*i+(W-1):W*i] =  p3;   Q[W*i+(W-1):W*i] = -last; end
				default:    begin I[W*i+(W-1):W*i] = 'dx;   Q[W*i+(W-1):W*i] = 'dx;   end
			endcase
		end
	 endgenerate
	 
	 /***************************************************************************/


endmodule		

		
		           

