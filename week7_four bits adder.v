//Gate-level description of 4-bit
//ripple-carry adder

module ripple(sw1,sw2, Cin, Cout, led);
	input[3:0] sw1, sw2;
	input Cin;
	output[6:0] led; 
	wire[3:0] display;
	four_bits_adder(display,Cout,sw1,sw2,Cin);
	show(display, led);
endmodule


module half_adder(sum, Cout, A, B);
	//Instantiate primitive gates
	input A, B;
	output sum, Cout;
	xor xorr(sum, A, B);
	and andd(Cout, A, B);
endmodule

module full_adder(sum, Cout, A, B, cin);
	input A, B, cin;
	output sum, Cout;
	wire summ, cout1, cout2;
	half_adder one(summ,cout1,A,B);
	half_adder two(sum,cout2,summ,cin);
	or ans(Cout, cout1, cout2);
endmodule

module four_bits_adder(sum, C4, A, B, C0);
	output[3:0] sum;
	output C4;
	input[3:0] A, B, C0;
	wire[2:0] cout;
	full_adder(sum[0],cout[0],A[0],B[0],C0);
	full_adder(sum[1],cout[1],A[1],B[1],cout[0]);
	full_adder(sum[2],cout[2],A[2],B[2],cout[1]);
	full_adder(sum[3],C4,A[3],B[3],cout[2]);
endmodule

module show(inputt, led);
	input[3:0] inputt;
	output reg[6:0] led;
	always @(inputt)
	begin
		case(inputt)
			4'b0000:led=7'b1000000;
			4'b0001:led=7'b1111001;
			4'b0010:led=7'b0100100;
			4'b0011:led=7'b0110000;
			4'b0100:led=7'b0011001;
			4'b0101:led=7'b0010010;
			4'b0110:led=7'b0000010;
			4'b0111:led=7'b1111000;
			4'b1000:led=7'b0000000;
			4'b1001:led=7'b0011000;
			4'b1010:led=7'b0001000;
			4'b1011:led=7'b0000011;
			4'b1100:led=7'b1000110;
			4'b1101:led=7'b0100001;
			4'b1110:led=7'b0000110;
			4'b1111:led=7'b0001110;
		default : led=7'b1000000;
		endcase
	end
endmodule
