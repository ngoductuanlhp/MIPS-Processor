module ALU_Cal(ALU_out, Zero, overflow, ALUControl, read_data1, data2,data2_c,clk,rst);
	
	output [31:0] ALU_out;
	output Zero,overflow;
	input [31:0]read_data1;
	input [31:0]data2;
	input [3:0]ALUControl;
	input clk,rst;

	output [31:0]data2_c;
	wire [31:0]sum,diff,product;
	wire overflow1,overflow2,overflow3;
	
	Two_Complement m1(data2_c,data2);
	Adder_32bit 	m2(sum,overflow1,read_data1,data2);
	Adder_32bit 	m3(diff,overflow2,read_data1,data2_c);
	Multiply 		m4(read_data1,data2,clk,rst,product,overflow3);
	
	assign ALU_out = 	(ALUControl == 4'b0010) ? sum : //add, addi
				(ALUControl == 4'b0110) ? diff : //sub
				(ALUControl == 4'b1000) ? product : //multiply
				(ALUControl == 4'b0000) ? (read_data1 & data2) : //and
				(ALUControl == 4'b0001) ? (read_data1 | data2) : //or
				(read_data1 < data2); //slt
	
	assign Zero = (ALU_out == 0) ? 1 : 0;
	assign overflow = 	(ALUControl == 4'b0010) ? overflow1:
				(ALUControl == 4'b0110) ? overflow2:
				(ALUControl == 4'b1000) ? overflow3:
				1'b0;
	
endmodule	

