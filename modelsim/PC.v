module PC(PC_in,PC_out,clk,Enable,rst);
	input [31:0]PC_in;
	input clk,rst,Enable;
	output reg [31:0]PC_out;

	always@(posedge clk  or negedge rst)
		begin
		if(!rst)
			PC_out<=32'b11111111111111111111111111111100;
		else if (!Enable || PC_in==0)
			PC_out<=PC_in;
		end
endmodule
