`timescale 1ns / 1ps

/***************************************************************************
* TEST THE TRANSMITTER MODULE 
***************************************************************************/
module testbench;
    
    /***************************************************************************
	 * Test Signals
	 ***************************************************************************/
	 /* parameters */
	 parameter N      = 16;
	 parameter FORMAT = 3'b100;
	 /* test signals */
	 // Input and output ports (NOTE: create inputs as reg and outputs as wire)
    reg             clk; 
	 reg             reset;
    reg  [4*N-1:0]  in;
	 wire	           tvalid;
	 wire [16*N-1:0] out;
	 // tb signals
	 wire [16*N-1:0] I;
    wire [16*N-1:0] Q;
	 wire [16*N-1:0] xk_re, xk_im;
	 wire [16*N-1:0] Y_re, Y_im;
	 wire [16*N-1:0] sn_re, sn_im;
	 
	 
	 /***************************************************************************
	 * DUT
	 ***************************************************************************/
    transmitter #(
		.N(N),
		.FORMAT(FORMAT)
	 ) dut(
		// intput and output ports
	   .clk(clk),
	   .reset(reset),
	   .in(in),
	   .tvalid(tvalid),
	   .out(out),
	   // tb signals
	   .I(I), .Q(Q),
	   .xk_re(xk_re), 
	   .xk_im(xk_im),
	   .Y_re(Y_re),   
	   .Y_im(Y_im),
	   .sn_re(sn_re), 
	   .sn_im(sn_im)
    );
        
		  
    /***************************************************************************
	 * Generate CLK
	 ***************************************************************************/
	 parameter CLK_PERIOD = 4;
    always #(CLK_PERIOD/2)  clk =! clk; 
	 
	 
	 /***************************************************************************
	 * Run test and print out result
	 ***************************************************************************/
    initial begin
		  // initialize
        clk=1; reset=1; 
        #(CLK_PERIOD*2);
        reset=0; 
		  
        // test loop
		  forever begin
		     in = 64'hC5F8725D9E5D29F7;
			  #CLK_PERIOD;
			  $fwrite(
					file_I, 
					"%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b\n", 
					I[15:0],    I[31:16],   I[47:32],  I[63:48],   I[79:64],   I[95:80],  I[111:96],
					I[127:112], I[143:128], I[159:144],I[175:160], I[191:176], I[207:192],
					I[223:208], I[239:224], I[255:240]
			  );
			  $fwrite(
					file_Q, 
					"%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b\n", 
					Q[15:0],    Q[31:16],   Q[47:32],  Q[63:48],   Q[79:64],   Q[95:80],  Q[111:96],
					Q[127:112], Q[143:128], Q[159:144],Q[175:160], Q[191:176], Q[207:192],
					Q[223:208], Q[239:224], Q[255:240]
			  );
			  $fwrite(
					file_xk_re, 
					"%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b\n", 
					xk_re[15:0],    xk_re[31:16],   xk_re[47:32],  xk_re[63:48],   xk_re[79:64],   xk_re[95:80], xk_re[111:96],
					xk_re[127:112], xk_re[143:128], xk_re[159:144],xk_re[175:160], xk_re[191:176], xk_re[207:192],
					xk_re[223:208], xk_re[239:224], xk_re[255:240]
			  );
			  $fwrite(
					file_xk_im, 
					"%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b\n", 
					xk_im[15:0],    xk_im[31:16],   xk_im[47:32],  xk_im[63:48],   xk_im[79:64],   xk_im[95:80],  xk_im[111:96],
					xk_im[127:112], xk_im[143:128], xk_im[159:144],xk_im[175:160], xk_im[191:176], xk_im[207:192],
					xk_im[223:208], xk_im[239:224], xk_im[255:240]
			  );
			  $fwrite(
					file_Y_re, 
					"%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b\n", 
					Y_re[15:0],    Y_re[31:16],   Y_re[47:32],  Y_re[63:48],   Y_re[79:64],   Y_re[95:80],  Y_re[111:96],
					Y_re[127:112], Y_re[143:128], Y_re[159:144],Y_re[175:160], Y_re[191:176], Y_re[207:192],
					Y_re[223:208], Y_re[239:224], Y_re[255:240]
			  );
			  $fwrite(
					file_Y_im, 
					"%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b\n", 
					Y_im[15:0],    Y_im[31:16],   Y_im[47:32],  Y_im[63:48],   Y_im[79:64],   Y_im[95:80],  Y_im[111:96],
					Y_im[127:112], Y_im[143:128], Y_im[159:144],Y_im[175:160], Y_im[191:176], Y_im[207:192],
					Y_im[223:208], Y_im[239:224], Y_im[255:240]
			  );
			  $fwrite(
					file_sn_re, 
					"%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b\n", 
					sn_re[15:0],    sn_re[31:16],   sn_re[47:32],  sn_re[63:48],   sn_re[79:64],   sn_re[95:80], sn_re[111:96],
					sn_re[127:112], sn_re[143:128], sn_re[159:144],sn_re[175:160], sn_re[191:176], sn_re[207:192],
					sn_re[223:208], sn_re[239:224], sn_re[255:240]
			  );
			  $fwrite(
					file_sn_im, 
					"%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b\n", 
					sn_im[15:0],    sn_im[31:16],   sn_im[47:32],  sn_im[63:48],   sn_im[79:64],   sn_im[95:80],  sn_im[111:96],
					sn_im[127:112], sn_im[143:128], sn_im[159:144],sn_im[175:160], sn_im[191:176], sn_im[207:192],
					sn_im[223:208], sn_im[239:224], sn_im[255:240]
			  );
			  $fwrite(
					file_out, 
					"%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b\n", 
					out[15:0],    out[31:16],   out[47:32],  out[63:48],   out[79:64],   out[95:80],  out[111:96],
					out[127:112], out[143:128], out[159:144],out[175:160], out[191:176], out[207:192],
					out[223:208], out[239:224], out[255:240]
			  );

			  
			  in = 64'h0000000000000000;
			  #CLK_PERIOD;
			  $fwrite(
					file_I, 
					"%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b\n", 
					I[15:0],    I[31:16],   I[47:32],  I[63:48],   I[79:64],   I[95:80],  I[111:96],
					I[127:112], I[143:128], I[159:144],I[175:160], I[191:176], I[207:192],
					I[223:208], I[239:224], I[255:240]
			  );
			  $fwrite(
					file_Q, 
					"%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b\n", 
					Q[15:0],    Q[31:16],   Q[47:32],  Q[63:48],   Q[79:64],   Q[95:80],  Q[111:96],
					Q[127:112], Q[143:128], Q[159:144],Q[175:160], Q[191:176], Q[207:192],
					Q[223:208], Q[239:224], Q[255:240]
			  );
			  $fwrite(
					file_xk_re, 
					"%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b\n", 
					xk_re[15:0],    xk_re[31:16],   xk_re[47:32],  xk_re[63:48],   xk_re[79:64],   xk_re[95:80], xk_re[111:96],
					xk_re[127:112], xk_re[143:128], xk_re[159:144],xk_re[175:160], xk_re[191:176], xk_re[207:192],
					xk_re[223:208], xk_re[239:224], xk_re[255:240]
			  );
			  $fwrite(
					file_xk_im, 
					"%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b\n", 
					xk_im[15:0],    xk_im[31:16],   xk_im[47:32],  xk_im[63:48],   xk_im[79:64],   xk_im[95:80],  xk_im[111:96],
					xk_im[127:112], xk_im[143:128], xk_im[159:144],xk_im[175:160], xk_im[191:176], xk_im[207:192],
					xk_im[223:208], xk_im[239:224], xk_im[255:240]
			  );
			  $fwrite(
					file_Y_re, 
					"%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b\n", 
					Y_re[15:0],    Y_re[31:16],   Y_re[47:32],  Y_re[63:48],   Y_re[79:64],   Y_re[95:80],  Y_re[111:96],
					Y_re[127:112], Y_re[143:128], Y_re[159:144],Y_re[175:160], Y_re[191:176], Y_re[207:192],
					Y_re[223:208], Y_re[239:224], Y_re[255:240]
			  );
			  $fwrite(
					file_Y_im, 
					"%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b\n", 
					Y_im[15:0],    Y_im[31:16],   Y_im[47:32],  Y_im[63:48],   Y_im[79:64],   Y_im[95:80],  Y_im[111:96],
					Y_im[127:112], Y_im[143:128], Y_im[159:144],Y_im[175:160], Y_im[191:176], Y_im[207:192],
					Y_im[223:208], Y_im[239:224], Y_im[255:240]
			  );
			  $fwrite(
					file_sn_re, 
					"%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b\n", 
					sn_re[15:0],    sn_re[31:16],   sn_re[47:32],  sn_re[63:48],   sn_re[79:64],   sn_re[95:80], sn_re[111:96],
					sn_re[127:112], sn_re[143:128], sn_re[159:144],sn_re[175:160], sn_re[191:176], sn_re[207:192],
					sn_re[223:208], sn_re[239:224], sn_re[255:240]
			  );
			  $fwrite(
					file_sn_im, 
					"%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b\n", 
					sn_im[15:0],    sn_im[31:16],   sn_im[47:32],  sn_im[63:48],   sn_im[79:64],   sn_im[95:80],  sn_im[111:96],
					sn_im[127:112], sn_im[143:128], sn_im[159:144],sn_im[175:160], sn_im[191:176], sn_im[207:192],
					sn_im[223:208], sn_im[239:224], sn_im[255:240]
			  );
			  $fwrite(
					file_out, 
					"%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b\n", 
					out[15:0],    out[31:16],   out[47:32],  out[63:48],   out[79:64],   out[95:80],  out[111:96],
					out[127:112], out[143:128], out[159:144],out[175:160], out[191:176], out[207:192],
					out[223:208], out[239:224], out[255:240]
			  );
			  
			  in = 64'h1234567890BCDEF0;
			  #CLK_PERIOD;
			  $fwrite(
					file_I, 
					"%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b\n", 
					I[15:0],    I[31:16],   I[47:32],  I[63:48],   I[79:64],   I[95:80],  I[111:96],
					I[127:112], I[143:128], I[159:144],I[175:160], I[191:176], I[207:192],
					I[223:208], I[239:224], I[255:240]
			  );
			  $fwrite(
					file_Q, 
					"%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b\n", 
					Q[15:0],    Q[31:16],   Q[47:32],  Q[63:48],   Q[79:64],   Q[95:80],  Q[111:96],
					Q[127:112], Q[143:128], Q[159:144],Q[175:160], Q[191:176], Q[207:192],
					Q[223:208], Q[239:224], Q[255:240]
			  );
			  $fwrite(
					file_xk_re, 
					"%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b\n", 
					xk_re[15:0],    xk_re[31:16],   xk_re[47:32],  xk_re[63:48],   xk_re[79:64],   xk_re[95:80], xk_re[111:96],
					xk_re[127:112], xk_re[143:128], xk_re[159:144],xk_re[175:160], xk_re[191:176], xk_re[207:192],
					xk_re[223:208], xk_re[239:224], xk_re[255:240]
			  );
			  $fwrite(
					file_xk_im, 
					"%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b\n", 
					xk_im[15:0],    xk_im[31:16],   xk_im[47:32],  xk_im[63:48],   xk_im[79:64],   xk_im[95:80],  xk_im[111:96],
					xk_im[127:112], xk_im[143:128], xk_im[159:144],xk_im[175:160], xk_im[191:176], xk_im[207:192],
					xk_im[223:208], xk_im[239:224], xk_im[255:240]
			  );
			  $fwrite(
					file_Y_re, 
					"%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b\n", 
					Y_re[15:0],    Y_re[31:16],   Y_re[47:32],  Y_re[63:48],   Y_re[79:64],   Y_re[95:80],  Y_re[111:96],
					Y_re[127:112], Y_re[143:128], Y_re[159:144],Y_re[175:160], Y_re[191:176], Y_re[207:192],
					Y_re[223:208], Y_re[239:224], Y_re[255:240]
			  );
			  $fwrite(
					file_Y_im, 
					"%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b\n", 
					Y_im[15:0],    Y_im[31:16],   Y_im[47:32],  Y_im[63:48],   Y_im[79:64],   Y_im[95:80],  Y_im[111:96],
					Y_im[127:112], Y_im[143:128], Y_im[159:144],Y_im[175:160], Y_im[191:176], Y_im[207:192],
					Y_im[223:208], Y_im[239:224], Y_im[255:240]
			  );
			  $fwrite(
					file_sn_re, 
					"%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b\n", 
					sn_re[15:0],    sn_re[31:16],   sn_re[47:32],  sn_re[63:48],   sn_re[79:64],   sn_re[95:80], sn_re[111:96],
					sn_re[127:112], sn_re[143:128], sn_re[159:144],sn_re[175:160], sn_re[191:176], sn_re[207:192],
					sn_re[223:208], sn_re[239:224], sn_re[255:240]
			  );
			  $fwrite(
					file_sn_im, 
					"%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b\n", 
					sn_im[15:0],    sn_im[31:16],   sn_im[47:32],  sn_im[63:48],   sn_im[79:64],   sn_im[95:80],  sn_im[111:96],
					sn_im[127:112], sn_im[143:128], sn_im[159:144],sn_im[175:160], sn_im[191:176], sn_im[207:192],
					sn_im[223:208], sn_im[239:224], sn_im[255:240]
			  );
			  $fwrite(
					file_out, 
					"%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b\n", 
					out[15:0],    out[31:16],   out[47:32],  out[63:48],   out[79:64],   out[95:80],  out[111:96],
					out[127:112], out[143:128], out[159:144],out[175:160], out[191:176], out[207:192],
					out[223:208], out[239:224], out[255:240]
			  );
			  
			  in = 64'hFEDCBA9876543210;
			  #CLK_PERIOD;
			  $fwrite(
					file_I, 
					"%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b\n", 
					I[15:0],    I[31:16],   I[47:32],  I[63:48],   I[79:64],   I[95:80],  I[111:96],
					I[127:112], I[143:128], I[159:144],I[175:160], I[191:176], I[207:192],
					I[223:208], I[239:224], I[255:240]
			  );
			  $fwrite(
					file_Q, 
					"%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b\n", 
					Q[15:0],    Q[31:16],   Q[47:32],  Q[63:48],   Q[79:64],   Q[95:80],  Q[111:96],
					Q[127:112], Q[143:128], Q[159:144],Q[175:160], Q[191:176], Q[207:192],
					Q[223:208], Q[239:224], Q[255:240]
			  );
			  $fwrite(
					file_xk_re, 
					"%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b\n", 
					xk_re[15:0],    xk_re[31:16],   xk_re[47:32],  xk_re[63:48],   xk_re[79:64],   xk_re[95:80], xk_re[111:96],
					xk_re[127:112], xk_re[143:128], xk_re[159:144],xk_re[175:160], xk_re[191:176], xk_re[207:192],
					xk_re[223:208], xk_re[239:224], xk_re[255:240]
			  );
			  $fwrite(
					file_xk_im, 
					"%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b\n", 
					xk_im[15:0],    xk_im[31:16],   xk_im[47:32],  xk_im[63:48],   xk_im[79:64],   xk_im[95:80],  xk_im[111:96],
					xk_im[127:112], xk_im[143:128], xk_im[159:144],xk_im[175:160], xk_im[191:176], xk_im[207:192],
					xk_im[223:208], xk_im[239:224], xk_im[255:240]
			  );
			  $fwrite(
					file_Y_re, 
					"%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b\n", 
					Y_re[15:0],    Y_re[31:16],   Y_re[47:32],  Y_re[63:48],   Y_re[79:64],   Y_re[95:80],  Y_re[111:96],
					Y_re[127:112], Y_re[143:128], Y_re[159:144],Y_re[175:160], Y_re[191:176], Y_re[207:192],
					Y_re[223:208], Y_re[239:224], Y_re[255:240]
			  );
			  $fwrite(
					file_Y_im, 
					"%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b\n", 
					Y_im[15:0],    Y_im[31:16],   Y_im[47:32],  Y_im[63:48],   Y_im[79:64],   Y_im[95:80],  Y_im[111:96],
					Y_im[127:112], Y_im[143:128], Y_im[159:144],Y_im[175:160], Y_im[191:176], Y_im[207:192],
					Y_im[223:208], Y_im[239:224], Y_im[255:240]
			  );
			  $fwrite(
					file_sn_re, 
					"%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b\n", 
					sn_re[15:0],    sn_re[31:16],   sn_re[47:32],  sn_re[63:48],   sn_re[79:64],   sn_re[95:80], sn_re[111:96],
					sn_re[127:112], sn_re[143:128], sn_re[159:144],sn_re[175:160], sn_re[191:176], sn_re[207:192],
					sn_re[223:208], sn_re[239:224], sn_re[255:240]
			  );
			  $fwrite(
					file_sn_im, 
					"%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b\n", 
					sn_im[15:0],    sn_im[31:16],   sn_im[47:32],  sn_im[63:48],   sn_im[79:64],   sn_im[95:80],  sn_im[111:96],
					sn_im[127:112], sn_im[143:128], sn_im[159:144],sn_im[175:160], sn_im[191:176], sn_im[207:192],
					sn_im[223:208], sn_im[239:224], sn_im[255:240]
			  );
			  $fwrite(
					file_out, 
					"%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b\n", 
					out[15:0],    out[31:16],   out[47:32],  out[63:48],   out[79:64],   out[95:80],  out[111:96],
					out[127:112], out[143:128], out[159:144],out[175:160], out[191:176], out[207:192],
					out[223:208], out[239:224], out[255:240]
			  );
			  
			  in = 64'hB112FE49610FAB39;
			  #CLK_PERIOD;
			  $fwrite(
					file_I, 
					"%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b\n", 
					I[15:0],    I[31:16],   I[47:32],  I[63:48],   I[79:64],   I[95:80],  I[111:96],
					I[127:112], I[143:128], I[159:144],I[175:160], I[191:176], I[207:192],
					I[223:208], I[239:224], I[255:240]
			  );
			  $fwrite(
					file_Q, 
					"%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b\n", 
					Q[15:0],    Q[31:16],   Q[47:32],  Q[63:48],   Q[79:64],   Q[95:80],  Q[111:96],
					Q[127:112], Q[143:128], Q[159:144],Q[175:160], Q[191:176], Q[207:192],
					Q[223:208], Q[239:224], Q[255:240]
			  );
			  $fwrite(
					file_xk_re, 
					"%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b\n", 
					xk_re[15:0],    xk_re[31:16],   xk_re[47:32],  xk_re[63:48],   xk_re[79:64],   xk_re[95:80], xk_re[111:96],
					xk_re[127:112], xk_re[143:128], xk_re[159:144],xk_re[175:160], xk_re[191:176], xk_re[207:192],
					xk_re[223:208], xk_re[239:224], xk_re[255:240]
			  );
			  $fwrite(
					file_xk_im, 
					"%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b\n", 
					xk_im[15:0],    xk_im[31:16],   xk_im[47:32],  xk_im[63:48],   xk_im[79:64],   xk_im[95:80],  xk_im[111:96],
					xk_im[127:112], xk_im[143:128], xk_im[159:144],xk_im[175:160], xk_im[191:176], xk_im[207:192],
					xk_im[223:208], xk_im[239:224], xk_im[255:240]
			  );
			  $fwrite(
					file_Y_re, 
					"%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b\n", 
					Y_re[15:0],    Y_re[31:16],   Y_re[47:32],  Y_re[63:48],   Y_re[79:64],   Y_re[95:80],  Y_re[111:96],
					Y_re[127:112], Y_re[143:128], Y_re[159:144],Y_re[175:160], Y_re[191:176], Y_re[207:192],
					Y_re[223:208], Y_re[239:224], Y_re[255:240]
			  );
			  $fwrite(
					file_Y_im, 
					"%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b\n", 
					Y_im[15:0],    Y_im[31:16],   Y_im[47:32],  Y_im[63:48],   Y_im[79:64],   Y_im[95:80],  Y_im[111:96],
					Y_im[127:112], Y_im[143:128], Y_im[159:144],Y_im[175:160], Y_im[191:176], Y_im[207:192],
					Y_im[223:208], Y_im[239:224], Y_im[255:240]
			  );
			  $fwrite(
					file_sn_re, 
					"%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b\n", 
					sn_re[15:0],    sn_re[31:16],   sn_re[47:32],  sn_re[63:48],   sn_re[79:64],   sn_re[95:80], sn_re[111:96],
					sn_re[127:112], sn_re[143:128], sn_re[159:144],sn_re[175:160], sn_re[191:176], sn_re[207:192],
					sn_re[223:208], sn_re[239:224], sn_re[255:240]
			  );
			  $fwrite(
					file_sn_im, 
					"%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b\n", 
					sn_im[15:0],    sn_im[31:16],   sn_im[47:32],  sn_im[63:48],   sn_im[79:64],   sn_im[95:80],  sn_im[111:96],
					sn_im[127:112], sn_im[143:128], sn_im[159:144],sn_im[175:160], sn_im[191:176], sn_im[207:192],
					sn_im[223:208], sn_im[239:224], sn_im[255:240]
			  );
			  $fwrite(
					file_out, 
					"%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b,%b\n", 
					out[15:0],    out[31:16],   out[47:32],  out[63:48],   out[79:64],   out[95:80],  out[111:96],
					out[127:112], out[143:128], out[159:144],out[175:160], out[191:176], out[207:192],
					out[223:208], out[239:224], out[255:240]
			  );
		  end 
    end
	 
	 
	 /***************************************************************************
	 * Open and close data file
	 ***************************************************************************/
	 integer file_I,file_Q,file_xk_re,file_xk_im,file_Y_re,file_Y_im,file_sn_re,file_sn_im,file_out;
	 initial begin
		  file_I     = $fopen("FQM_parallel_data_I.txt");
		  file_Q     = $fopen("FQM_parallel_data_Q.txt");
		  file_xk_re = $fopen("FQM_parallel_data_xk_re.txt");
		  file_xk_im = $fopen("FQM_parallel_data_xk_im.txt");
		  file_Y_re  = $fopen("FQM_parallel_data_Y_re.txt");
		  file_Y_im  = $fopen("FQM_parallel_data_Y_im.txt");
		  file_sn_re = $fopen("FQM_parallel_data_sn_re.txt");
		  file_sn_im = $fopen("FQM_parallel_data_sn_im.txt");
		  file_out   = $fopen("FQM_parallel_data_out.txt");
		  
		  #600; // Simulation time
		  
	     $fclose(file_I);
		  $fclose(file_Q);
		  $fclose(file_xk_re);
		  $fclose(file_xk_im);
		  $fclose(file_Y_re);
		  $fclose(file_Y_im);
		  $fclose(file_sn_re);
		  $fclose(file_sn_im);
		  $fclose(file_out);
		  
		  $finish;
	 end
	 
	 /***************************************************************************/
		
  
endmodule
