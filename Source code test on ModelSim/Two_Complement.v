module Two_Complement(out, data);
	output [31:0]out;
	input [31:0]data;
	
	wire [31:0]one_complement;

	assign one_complement = ~data;
	
	Adder_32bit adder(out, overflow, one_complement, 32'd1);
	
endmodule 
