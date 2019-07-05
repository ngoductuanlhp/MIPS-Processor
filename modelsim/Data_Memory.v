	module Data_Memory (read_data , address , write_data , MemWrite , MemRead , clk, rst);

	output [31:0]read_data;
	input[31:0]address,write_data;
	input MemWrite, MemRead, clk, rst;
	
	reg [31:0]data_mem[0:19]; //32 32-bits words memory
	wire [4:0]address_temp = address[6:2];

	integer i;

	assign read_data=(MemRead==1'b1)?data_mem[address_temp]:32'b0;
		
	always @(posedge clk or negedge rst) begin
		if(!rst) begin
			data_mem[0] <= 32'd0;
			data_mem[1] <= 32'd1;
			data_mem[2] <= 32'd2;
			data_mem[3] <= 32'd3;
			data_mem[4] <= 32'd4;
			data_mem[5] <= 32'd5;
			data_mem[6] <= 32'd6;
			data_mem[7] <= 32'd7;
			data_mem[8] <= 32'd8;
			data_mem[9] <= 32'd9;
			for(i=10;i<15;i=i+1) begin
				data_mem[i]<=32'b0;
			end
		end
		else if(MemWrite)
			data_mem[address_temp] <= write_data;
	end

endmodule 