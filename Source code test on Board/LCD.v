module LCD(
	clk,rst,output_display,PC,LCD_DATA,LCD_RW,LCD_EN,LCD_RS
);
	//Input
	input			clk; 					//clock 50MHz
	input 		rst;					//reset LCD
	input [31:0]	output_display;
	input [31:0]	PC;

	//	LCD Side
	output reg [7:0] 	LCD_DATA;
	output reg 			LCD_EN,LCD_RS;
	output 				LCD_RW;

	// LCD control
	reg	[5:0]		cursor;
	reg	[3:0]		stateLCD;
	reg	[5:0]		count_250ns;
	reg	[14:0]	count_600us;
	reg	[11:0]	count_50us;

	reg 	[8:0]		enDATA;

	wire 	[8:0]		d0,d1,d2,d3,d4,d5,d6,d7;
	wire 	[8:0]		p0,p1,p2,p3,p4,p5,p6,p7;

	parameter 	t_250ns 			= 	16;
	parameter 	t_600us 			= 	30000;
	parameter 	t_50us 			= 	2500;
	parameter	initial_ins		=	0;
	parameter	line1_ins		=	5;
	parameter	changeline_ins	=	21;
	parameter	line2_ins		=	22;
	parameter	maxsize			=	38;

	assign 		LCD_RW	= 	1'b0;

	LCDencoder en0	(output_display[3:0],	d0);
	LCDencoder en1	(output_display[7:4],	d1);
	LCDencoder en2	(output_display[11:8],	d2);
	LCDencoder en3	(output_display[15:12],	d3);
	LCDencoder en4	(output_display[19:16],	d4);
	LCDencoder en5	(output_display[23:20],	d5);
	LCDencoder en6	(output_display[27:24],	d6);
	LCDencoder en7	(output_display[31:28],	d7);

	LCDencoder en8	(PC[3:0],	p0);
	LCDencoder en9	(PC[7:4],	p1);
	LCDencoder en10(PC[11:8],	p2);
	LCDencoder en11(PC[15:12],	p3);
	LCDencoder en12(PC[19:16],	p4);
	LCDencoder en13(PC[23:20],	p5);
	LCDencoder en14(PC[27:24],	p6);
	LCDencoder en15(PC[31:28],	p7);

	always@(posedge clk or negedge rst)
	begin
		if(~rst)
			begin
				cursor		<=	0;
				stateLCD		<=	0;
				count_600us	<=	0;
				count_50us	<=	0;
				count_250ns	<= 0;
			end
		else begin
			if(cursor<maxsize)
			begin
				case(stateLCD)
				0:	begin
						LCD_DATA				<=	enDATA[7:0];
						LCD_RS				<=	enDATA[8];
						stateLCD				<=	4'd1;
					end
				1: begin
						stateLCD				<=	4'd2;
					end	
				2: begin
						LCD_EN				<=	1'b1;
						stateLCD				<=	4'd3;
					end
				3:	begin
						if(count_250ns<t_250ns)
							count_250ns	<=	count_250ns + 1'b1;
						else begin
							count_250ns		<= 6'd0;
							LCD_EN			<=	1'b0;
							stateLCD			<=	4'd4;					
						end
					end
				4:	begin
						if(cursor<5) begin
							if(count_600us < t_600us)
								count_600us	<=	count_600us + 1'b1;
							else begin
								count_600us	<=	0;
								stateLCD		<=	4'd5;
							end
						end
						else begin
							if(count_50us < t_50us)
								count_50us	<=	count_50us + 1'b1;
							else begin
								count_50us	<=	0;
								stateLCD		<=	4'd5;							
							end
						end
					end
				5:	begin
						cursor				<= cursor + 1'b1;
						stateLCD				<=	4'd0;
					end
				endcase
			end
		end
	end

	always@(*)
	begin
		case(cursor)
			//	Initial
			initial_ins+0:	enDATA	<=	9'h038; 	//function set: data length 8 bits, 2 lines display, character font 5x8 dots
			initial_ins+1:	enDATA	<=	9'h00C; 	//entire display on, cursor off, blinking off 
			initial_ins+2:	enDATA	<=	9'h001;	//clear display
			initial_ins+3:	enDATA	<=	9'h006; 	//increase cursor by 1 after writing and keep screen (not shift)
			initial_ins+4:	enDATA	<=	9'h080;
			
			//	Line 1		//"Output: XXXXXXXX"
			line1_ins+0:	enDATA	<=	9'h14F;	
			line1_ins+1:	enDATA	<=	9'h175;
			line1_ins+2:	enDATA	<=	9'h174;
			line1_ins+3:	enDATA	<=	9'h170;
			line1_ins+4:	enDATA	<=	9'h175;
			line1_ins+5:	enDATA	<=	9'h174;
			line1_ins+6:	enDATA	<=	9'h13A;
			line1_ins+7:	enDATA	<=	9'h120;
			line1_ins+8:	enDATA	<=	d7;
			line1_ins+9:	enDATA	<=	d6;
			line1_ins+10:	enDATA	<=	d5;
			line1_ins+11:	enDATA	<=	d4;
			line1_ins+12:	enDATA	<=	d3;
			line1_ins+13:	enDATA	<=	d2;
			line1_ins+14:	enDATA	<=	d1;
			line1_ins+15:	enDATA	<=	d0;
			
			//	Change Line
			changeline_ins:enDATA	<=	9'h0C0;
			
			//	Line 2		//"PC:     XXXXXXXX"
			line2_ins+0:	enDATA	<=	9'h150;
			line2_ins+1:	enDATA	<=	9'h143;
			line2_ins+2:	enDATA	<=	9'h13A;
			line2_ins+3:	enDATA	<=	9'h120;
			line2_ins+4:	enDATA	<=	9'h120;
			line2_ins+5:	enDATA	<=	9'h120;
			line2_ins+6:	enDATA	<=	9'h120;
			line2_ins+7:	enDATA	<=	9'h120; 
			line2_ins+8:	enDATA	<=	p7;
			line2_ins+9:	enDATA	<=	p6;
			line2_ins+10:	enDATA	<=	p5;
			line2_ins+11:	enDATA	<=	p4;
			line2_ins+12:	enDATA	<=	p3;
			line2_ins+13:	enDATA	<=	p2;
			line2_ins+14:	enDATA	<=	p1;
			line2_ins+15:	enDATA	<=	p0;
			default:			enDATA	<=	9'h120;
		endcase
	end

endmodule
