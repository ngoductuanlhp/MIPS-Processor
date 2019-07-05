module Board(KEY, SW, CLOCK_50, LEDR, LEDG, LCD_DATA, LCD_RW, LCD_EN, LCD_RS, HEX0, HEX1, HEX2 , HEX3, HEX4, HEX5, HEX6, HEX7);

	input 	[2:0]	KEY;		// for generate clocl, reset
	input 	[3:0]	SW;		// for select output
	input	 			CLOCK_50;// clock of LCD
	output 	[8:0]	LEDR;		// display ALU Opcode
	output 	[1:0]	LEDG;		// display control signals
	output	[7:0]	LCD_DATA;// for LCD
	output			LCD_RW,LCD_EN,LCD_RS;	// for LCD
	output 	[6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5 , HEX6 , HEX7;	// display output from modules

	wire 	[31:0] 	read_data1,read_data2,ALU_out,read_data_mem,sign_extend_out,instruction,PC_output,PC_input,reg_write_data,EPCOut;
	wire 	[1:0]		ALUOP;
	
	reg 	[31:0]	out;
	wire	clk_1MHz;
	
	divide_clock m(CLOCK_50,clk_1MHz);
	
	Interface module_interface(
										//inputs
										.clk					(~KEY[1]),
										.rst					(KEY[0]),
										.clk_small			(clk_1MHz),
										
										//outputs
										.instruction		(instruction),
										.read_data1			(read_data1),
										.read_data2			(read_data2),
										.ALU_out				(ALU_out),
										.read_data_mem		(read_data_mem),
										.sign_extend_out	(sign_extend_out),
										.PC_output			(PC_output),
										.PC_input			(PC_input),
										.reg_write_data	(reg_write_data),
										.EPCOut				(EPCOut),
										.RegDst				(LEDR[0]),
										.Branch				(LEDR[2]),
										.MemRead			(LEDR[3]),
										.MemtoReg			(LEDR[5]),
										.MemWrite			(LEDR[4]),
										.ALUSrc				(LEDR[6]),
										.RegWrite			(LEDR[1]),
										.Enable				(LEDR[7]),
										.Jump				(LEDR[8]),
										.ALUOp				(LEDG[1:0])
	);
	
	always @(*)
	begin
		case (SW)
			4'b0000: out=read_data1;  			//0: read_data1
			4'b0001: out=read_data2;  			//1: read_data2
			4'b0010: out=ALU_out;				//2: result of ALU
			4'b0011: out=read_data_mem;      //3: data read from memory
			4'b0100: out=sign_extend_out;    //4: sign_extend_out
			4'b0101: out=reg_write_data;		//5: data writen to register
			4'b0110: out=instruction;			//6: instruction
			4'b0111: out=PC_input;				//7: PC next
			4'b1000: out=PC_output;				//8: PC
			4'b1001: out=EPCOut;					//9: PC in exception
		endcase
	end
	
	binary_7seg hex_0(out[3:0], 	HEX0);
	binary_7seg hex_1(out[7:4], 	HEX1);
	binary_7seg hex_2(out[11:8], 	HEX2);
	binary_7seg hex_3(out[15:12], HEX3);
	binary_7seg hex_4(out[19:16], HEX4);
	binary_7seg hex_5(out[23:20], HEX5);
	binary_7seg hex_6(out[27:24], HEX6);
	binary_7seg hex_7(out[31:28], HEX7);
	
	LCD lcd(
				//inputs
				.clk					(CLOCK_50),
				.rst					(KEY[0]&KEY[1]&KEY[2]),
				.output_display	(out),
				.PC					(PC_output),
				
				//outputs
				.LCD_DATA			(LCD_DATA),
				.LCD_RW				(LCD_RW),
				.LCD_EN				(LCD_EN),
				.LCD_RS				(LCD_RS)
	);
	endmodule
