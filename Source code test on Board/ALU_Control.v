module ALU_Control (ALUControl , function_code , ALUOp);

	output [3:0]ALUControl;
	input [5:0]function_code;
	input [1:0]ALUOp;

	assign ALUControl = 	(ALUOp == 2'b01) ? (4'b0110) : //beq: sub
				(ALUOp == 2'b00) ? (4'b0010) : //lw,sw: add
				(ALUOp	== 2'b11) ? (4'b0010) : //addi: add
			     	(function_code == 6'b100000) ? (4'b0010) : //add
				(function_code == 6'b100010) ? (4'b0110) : //sub
				(function_code == 6'b011010) ? (4'b1111) : //div
				(function_code == 6'b010010) ? (4'b1000) : //mul
				(function_code == 6'b100100) ? (4'b0000) : //and
				(function_code == 6'b100101) ? (4'b0001) : //or  
				(function_code == 6'b101010) ? (4'b0111) : //slt
				4'b0010; //addi

endmodule						