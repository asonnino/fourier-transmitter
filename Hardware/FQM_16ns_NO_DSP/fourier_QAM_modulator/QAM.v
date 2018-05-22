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
// QAM mapping operation
//
// Dependencies: 
// -
// 
// Revision:
// Revision 0.01 - File Created
//
// Additional Comments:
//////////////////////////////////////////////////////////////////////////////////
module QAM #(
	 /* Parameters */
	 parameter N      = 16,           // Number of parallel inputs
	 parameter W      = 16,           // Bus width
	 parameter FORMAT = 3'b100        // QAM order 
 )(
    /* Input and output ports */
    input  wire [FORMAT*N-1:0] in,   // Clustered input stream
	 input  wire [W-1:0]        last, // Last constellation point
    output wire [W*N-1:0]      I,    // In-phase component
	 output wire [W*N-1:0]      Q     // Quadrature component
 );


	 /***************************************************************************
	 * QAM Mapping
	 ***************************************************************************/
	 generate // generate only the required module
		 case(FORMAT)
			 3'b011:    // 8-QAM
				 QAM8 #(
					.N(N),       // Number of parallel inputs
					.W(W)        // Bus Witdh
				 ) QAM8_isnt(
					.in(in),     // Clustered input stream
					.last(last), // Last constellation point
					.I(I),		 // In-phase component  
					.Q(Q)        // Quadrature component
				 );
			 3'b100:    // 16-QAM
				 QAM16 #(
					.N(N),       // Number of parallel inputs
					.W(W)        // Bus Witdh
				 ) QAM16_isnt(
					.in(in),     // Clustered input stream
					.last(last), // Last constellation point
					.I(I),		 // In-phase component  
					.Q(Q)        // Quadrature component
				 );
			 3'b101:    // 32-QAM
				 QAM32 #(
					.N(N),       // Number of parallel inputs
					.W(W)        // Bus Witdh
				 ) QAM32_isnt(
					.in(in),     // Clustered input stream
					.last(last), // Last constellation point
					.I(I),		 // In-phase component  
					.Q(Q)        // Quadrature component
				 );
			 3'b110:    // 64-QAM
				 QAM64 #(
					.N(N),       // Number of parallel inputs
					.W(W)        // Bus Witdh
				 ) QAM64_isnt(
					.in(in),     // Clustered input stream
					.last(last), // Last constellation point
					.I(I),		 // In-phase component  
					.Q(Q)        // Quadrature component
				 );
			 default:   // unsupported or undefined QAM format
				 begin assign I = 'bx; assign Q = 'bx; end
		 endcase
	 endgenerate
	 
	 /***************************************************************************/


endmodule		

		
		           

