module Register_File(read_register1, read_register2 ,write_register, write_data, RegWrite, clk, rst, read_data1, read_data2);
	
	input [4:0]read_register1,read_register2,write_register;
	input [31:0]write_data;
	input RegWrite,clk,rst;
	
	output [31:0]read_data1,read_data2;
	integer i;
	reg [31:0]register[0:31];

	assign read_data1 = (!rst) ? 32'b0: register[read_register1];
	assign read_data2 = (!rst) ? 32'b0: register[read_register2];
 
	always @(posedge clk or negedge rst)
	begin
		if(!rst) begin
			register[16]<=32'd0;
			register[17]<=32'd1;
			register[18]<=32'd2;
			register[19]<=32'd3;
			register[20]<=32'd4;
			register[21]<=32'd5;
		end
		else if(RegWrite)
			register[write_register]<=write_data;
	end

endmodule 

