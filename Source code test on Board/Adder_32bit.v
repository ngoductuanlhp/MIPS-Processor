module Adder_32bit (sum, overflow, data1, data2);
	output [31:0]sum;
	output overflow;
	input [31:0]data1,data2;
   
	wire  carry_out;
	wire [31:0] carry;
   
	genvar i;
   	generate 
		for(i=0; i<32; i=i+1)
			begin: Adder_32bit
				if(i==0) 
					half_adder f(sum[0], carry[0], data1[0], data2[0]);
				else
					full_adder f(sum[i], carry[i], data1[i], data2[i], carry[i-1]);
			end
   	endgenerate
	assign carry_out = carry[31];
	assign overflow=(data1[31]==1'b0 & data2[31]==1'b0 & sum[31]==1'b1)|(data1[31]==1'b1 & data2[31]==1'b1 & sum[31]==1'b0);
	
endmodule 
 
 
module half_adder(out, carry, in1, in2);
   output out, carry;
	input in1, in2;
	
   assign out = in1^in2;
   assign carry = in1&in2;

endmodule // half adder
 
 
module full_adder(out, carry_out, in1, in2, carry_in);
   output out, carry_out;
	input in1, in2, carry_in;
	
	assign out = (in1^in2) ^ carry_in;
	assign carry_out = (in1&carry_in) | (in1&in2) | (in2&carry_in);
	
endmodule // full_adder