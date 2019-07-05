module JumpAddressing(PC_in,instruction,PC_out);

	input [3:0]PC_in;
	input [25:0]instruction;
	output [31:0]PC_out;
	wire [27:0]temp;

	assign PC_out={PC_in,instruction,2'b00};
endmodule

