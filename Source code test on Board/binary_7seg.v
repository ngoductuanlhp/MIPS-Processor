module binary_7seg(in_bin,out_7seg);

	input [3:0]in_bin;
	output reg [6:0]out_7seg;
	
	always@*
	
	begin
		case(in_bin)
			0:out_7seg=7'b1000000;
			1:out_7seg=7'b1111001;
			2:out_7seg=7'b0100100;
			3:out_7seg=7'b0110000;
			4:out_7seg=7'b0011001;
			5:out_7seg=7'b0010010;
			6:out_7seg=7'b0000010;
			7:out_7seg=7'b1111000;
			8:out_7seg=7'b0000000;
			9:out_7seg=7'b0010000;
			10:out_7seg=7'b0001000;
			11:out_7seg=7'b0000011;
			12:out_7seg=7'b1000110;
			13:out_7seg=7'b0100001;
			14:out_7seg=7'b0000110;
			15:out_7seg=7'b0001110;
		endcase
	 end
	  
endmodule
