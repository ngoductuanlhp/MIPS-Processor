module Sign_Extend (sign_extend_in , sign_extend_out);

	input [15:0]sign_extend_in;
	output [31:0]sign_extend_out;

	wire [15:0]temp0=16'b0;
	wire [15:0]temp1=~temp0;

	assign sign_extend_out = (sign_extend_in[15]==1'b1) ? {temp1 , sign_extend_in[15:0]} : {temp0  , sign_extend_in[15:0]};
 
endmodule



