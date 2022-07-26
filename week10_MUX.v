module MUX(clk, sw, stop, out, select);
	input clk, stop;
	input [7:0] sw;
	output out;
	output [2:0] select;
	wire newclk; //after frequency divide
	FreqDiv fd(clk, stop, newclk);
	upcounter uc(newclk, select);
	mux8to1 m81(sw, select, out);
endmodule

module upcounter(clk, Q); //mod-8 up counter
	input clk;
	output wire [2:0] Q;
	
	J_K jk0(1, 1, clk, 1'b1, Q[0]); //J, K are high
	J_K jk1(1, 1, Q[0], 1'b1, Q[1]);
	J_K jk2(1, 1, Q[1], 1'b1, Q[2]);
endmodule

module FreqDiv(iClk, clear, oClk);
	input iClk, clear;
	output oClk;
	reg oClk;
	integer count; //計數用
	parameter RATE = 50000000; //50MHz to 1Hz
	
	initial
		count = 0;
	always @(posedge iClk) //正脈緣觸發 iClk: low to high
	if(clear) // 暫停的switch為high, 繼續; 暫停的switch為low, 暫停
	begin
		if(count < RATE / 2) //count < 欲除頻率之一半 output high
			oClk = 1;
		else //count > 欲除頻率之一半 output low
			oClk = 0;
			
		count = (count + 1) % RATE; //每偵測到一個脈衝輸入就+1, 以RATE為循環(0~RATE-1)
	end
endmodule

module J_K(J, K, clk, clear, Q);
	input J, K, clk, clear;
	output reg Q;
	always @(posedge clk or negedge clear) //low -> 歸零
	begin
		case({J, K})
			2'b00: Q = Q;
			2'b01: Q = 1'b0;
			2'b10: Q = 1'b1;
			2'b11: Q = ~Q;
		endcase
	end
endmodule

module mux8to1(data, select, out);
	input [7:0] data;
	input [2:0] select;
	output reg out;
	always @(select)
	begin
		case(select)
			3'b000: out = data[0];
			3'b001: out = data[1];
			3'b010: out = data[2];
			3'b011: out = data[3];
			3'b100: out = data[4];
			3'b101: out = data[5];
			3'b110: out = data[6];
			3'b111: out = data[7];
		endcase
	end
endmodule
			
	