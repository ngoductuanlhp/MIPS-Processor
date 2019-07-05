module Exception_Handle(OPCode,ALU_out, ALUOp,rst, ALUControl,  OverFlow,read_data2, Enable);
input [3:0]ALUControl;
input [5:0]OPCode;
input [31:0]read_data2;
input [31:0]ALU_out;
input [1:0]ALUOp;
input OverFlow,rst;
output Enable;
//Enable =1 -> exception 
assign Enable = (OPCode==6'b000010)? 0:
		(ALUOp==2'b00 & (ALU_out[0] | ALU_out[1])) ? 1:  
		(&ALUControl & ~|read_data2) ? 1:  //check divide 0 
              	(OverFlow)? 1: 0;  // invalid address
endmodule 