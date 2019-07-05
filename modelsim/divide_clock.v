module divide_clock(clk_in,clk_400ns);

	input clk_in;
	
	output reg clk_400ns;
	
	initial begin
		clk_400ns<=0;
	end
	
	reg [5:0]	count1=1;
	
	//divide clock 50MHz to 1Hz
	always@(posedge clk_in) begin
		count1<=count1+1'b1;
		if(count1==10) begin
			clk_400ns<=~clk_400ns;
			count1<=6'd1;
		end
	end

endmodule