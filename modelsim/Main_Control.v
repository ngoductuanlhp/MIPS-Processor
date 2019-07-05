// Submodule: Control Unit
// Version 1
module Main_Control(Opcode,rst,Enable,RegDst,Branch,,MemRead,MemtoReg,MemWrite,ALUSrc,RegWrite,Jump,ALUOp);
	
	input [5:0]Opcode;
	input rst;
	input Enable;	
	output reg RegDst,Branch,MemRead,MemtoReg,MemWrite,ALUSrc,RegWrite,Jump;
	output reg [1:0]ALUOp;
	
	always@(*)
	begin
		if(rst==1'b0 || Enable==1'b1)
			begin
			RegDst=1'b0;
			Branch=1'b0;
			MemRead=1'b0;
			MemtoReg=1'b0;
			MemWrite=1'b0;
			ALUSrc=1'b0;
			RegWrite=1'b0;
			ALUOp=2'b00;
			Jump=1'b0;
			end
		else begin
		case(Opcode)
		//R-format: add,sub,and,or,slt
		6'b000000:
					begin
					RegDst=1'b1;
					Branch=1'b0;
					MemRead=1'b0;
					MemtoReg=1'b0;
					MemWrite=1'b0;
					ALUSrc=1'b0;
					RegWrite=1'b1;
					ALUOp=2'b10;
					Jump=1'b0;
					end
		//I-format: lw
		6'b100011:
					begin
					RegDst=1'b0;
					Branch=1'b0;
					MemRead=1'b1;
					MemtoReg=1'b1;
					MemWrite=1'b0;
					ALUSrc=1'b1;
					RegWrite=1'b1;
					ALUOp=2'b00;
					Jump=1'b0;
					end
		//I-format: sw
		6'b101011:
					begin
					RegDst=1'bx;//dont care
					Branch=1'b0;
					MemRead=1'b0;
					MemtoReg=1'bx;//dont care
					MemWrite=1'b1;
					ALUSrc=1'b1;
					RegWrite=1'b0;
					ALUOp=2'b00;
					Jump=1'b0;
					end
		//I-format: beq
		6'b000100:
					begin
					RegDst=1'bx;//dont care
					Branch=1'b1;
					MemRead=1'b0;
					MemtoReg=1'bx;//dont care
					MemWrite=1'b0;
					ALUSrc=1'b0;
					RegWrite=1'b0;
					ALUOp=2'b01;
					Jump=1'b0;
					end
		//I-format: addi
		6'b001000:
					begin
					RegDst=1'b0;
					Branch=1'b0;
					MemRead=1'b0;
					MemtoReg=1'b0;
					MemWrite=1'b0;
					ALUSrc=1'b1;
					RegWrite=1'b1;
					ALUOp=2'b11;
					Jump=1'b0;
					end
		//J-format: jump
		6'b000010:
					begin
					RegDst=1'b0;
					Branch=1'b0;
					MemRead=1'b0;
					MemtoReg=1'b0;
					MemWrite=1'b0;
					ALUSrc=1'b0;
					RegWrite=1'b0;
					ALUOp=2'b00;
					Jump=1'b1;
					end
		default:
					begin
					RegDst=1'b0;
					Branch=1'b0;
					MemRead=1'b0;
					MemtoReg=1'b0;
					MemWrite=1'b0;
					ALUSrc=1'b0;
					RegWrite=1'b0;
					ALUOp=2'b00;
					Jump=1'b0;
					end
		endcase
		end
	end
endmodule
