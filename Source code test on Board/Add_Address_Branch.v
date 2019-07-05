module Add_Address_Branch(PC_in,offset,PC_out);

	output [31:0]PC_out;
	input [31:0]PC_in, offset;
	
	assign PC_out = PC_in + (offset << 2);
	
endmodule