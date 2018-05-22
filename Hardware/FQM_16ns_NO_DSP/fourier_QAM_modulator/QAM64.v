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
//////////////////////////////////////////////////////////////////////////////////
module QAM64 #(
	 /* Parameters */
	 parameter N  = 16,        // Number of parallel inputs
	 parameter W  = 16         // Bus width
 )(
    /* Input and output ports */
    input  wire [6*N-1:0] in,   // Clustered input stream
	 input  wire [W-1:0]   last, // Last constellation point
    output reg  [W*N-1:0] I,    // In-phase component
	 output reg  [W*N-1:0] Q     // Quadrature component
 );


	 /***************************************************************************
	 * Internal Signals
	 ***************************************************************************/
	 wire [W-1:0] p1, p3, p5; // First constellation point
	  
	 /***************************************************************************
	 * Config.
	 ***************************************************************************/
	 // Compute other constellation point
	 assign p1 = last / 7; // *(1/7) 
	 assign p3 = p1   * 3; // *(3/7)
	 assign p5 = p1   * 5; // *(5/7)


	 /***************************************************************************
	 * QAM Mapping
	 ***************************************************************************/
	 genvar i;
	 generate for(i=0; i < N; i=i+1)
		always@(*) begin
			case({in[6*i+5],in[6*i+3],in[6*i+1]}) // assign I value
				3'b000:   I[W*i+(W-1):W*i] =  p1;
				3'b001:   I[W*i+(W-1):W*i] =  p3;
				3'b010:   I[W*i+(W-1):W*i] =  p5;
				3'b011:   I[W*i+(W-1):W*i] =  last;
				3'b100:   I[W*i+(W-1):W*i] = -p1;
				3'b101:   I[W*i+(W-1):W*i] = -p3;
				3'b110:   I[W*i+(W-1):W*i] = -p5;
				3'b111:   I[W*i+(W-1):W*i] = -last;
				default:  I[W*i+(W-1):W*i] = 'dx; 
			endcase
			case({in[6*i+4],in[6*i+2],in[6*i]})   // assign Q value
				3'b000:   Q[W*i+(W-1):W*i] =  p1;
				3'b001:   Q[W*i+(W-1):W*i] =  p3;
				3'b010:   Q[W*i+(W-1):W*i] =  p5;
				3'b011:   Q[W*i+(W-1):W*i] =  last;
				3'b100:   Q[W*i+(W-1):W*i] = -p1;
				3'b101:   Q[W*i+(W-1):W*i] = -p3;
				3'b110:   Q[W*i+(W-1):W*i] = -p5;
				3'b111:   Q[W*i+(W-1):W*i] = -last;
				default:  Q[W*i+(W-1):W*i] = 'dx;
			endcase
		end
	 endgenerate
	 
	 /***************************************************************************/


endmodule		

		
		           

