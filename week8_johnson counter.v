module johnson_counter(clk, reset, led); //Johnson Counter
		input clk, reset;
		output [3:0] led;
wire [3:0] Q;
		dfff (~Q[3], clk, reset, Q[0]);
		dfff (Q[0], clk, reset, Q[1]);
		dfff (Q[1], clk, reset, Q[2]);
		dfff (Q[2], clk, reset, Q[3]);
		assign led = Q;
endmodule

module dfff(D, clk, rst, Q); //D Flip-flop
		input D, clk, rst;
		output reg Q;
		always @(posedge clk, negedge rst)
			if(!rst)Q <= 1'b0; //if(rst == 0)
			else Q <= D;
endmodule
