module decoder(in, enable, out);
	input [3:0] in; //for 2to4:Q0, Q1, for 3to8: Q2, Q3, C=1
	input enable;
	output [15:0] out;
	wire [7:0] forout;
	reg [2:0] forin;
	always @(in)
	begin
		case({in[3],in[2]})
			2'b00: forin = 3'b001;
			2'b01: forin = 3'b011;
			2'b10: forin = 3'b101;
			2'b11: forin = 3'b111;
		endcase
	end
	
	decoder3to8(forin[2:0], enable, forout[7:0]);
	decoder2to4(in[1:0], forout[1], out[3:0]);
	decoder2to4(in[1:0], forout[3], out[7:4]);
	decoder2to4(in[1:0], forout[5], out[11:8]);
	decoder2to4(in[1:0], forout[7], out[15:12]);
endmodule

module decoder3to8(Q, enable, out);
	input [2:0] Q;
	input enable;
	output reg [7:0] out;
	always@(Q)
	if(enable)
		begin
			out = 8'b11111111;
		end
	else
		begin
			//in FDGA 
			if(Q == 3'b000) out = 8'b11111110;
			else if(Q == 3'b001) out = 8'b11111101;
			else if(Q == 3'b010) out = 8'b11111011;
			else if(Q == 3'b011) out = 8'b11110111;
			else if(Q == 3'b100) out = 8'b11101111;
			else if(Q == 3'b101) out = 8'b11011111;
			else if(Q == 3'b110) out = 8'b10111111;
			else if(Q == 3'b111) out = 8'b01111111;
		end
endmodule

module decoder2to4(Q, enable, out);
	input [1:0] Q;
	input enable;
	output reg [3:0] out;
	always@(Q)
	if(enable)
		begin
			out = 4'b1111;
		end
	else
		begin
			if(Q == 2'b00) out = 4'b1110;
			else if(Q == 2'b01) out = 4'b1101;
			else if(Q == 2'b10) out = 4'b1011;
			else if(Q == 2'b11) out = 4'b0111;
		end
endmodule
	

