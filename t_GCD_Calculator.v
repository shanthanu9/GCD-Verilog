/***************************************************
* GCD calculator
* Shanthanu S Rai(17CO242) and Varun Pattar(17CO249)
* November, 13 2018
****************************************************/

`include "GCD_Calculator.v"

module t_GCD_Calculator;

parameter N = 8;

reg[N-1:0] P, Q;
reg clk, rst, start;
wire[N-1:0] R;
wire valid;
wire[1:0] State_Y;

GCD_Calculator G(P, Q, clk, rst, start, R, valid, State_Y);

always  #10 clk = ~clk;

initial begin
	
	$monitor($time, " rst = %d, State_Y = %d, P = %d, Q = %d, start = %d, clk = %d, R = %d, valid = %d", rst, State_Y, P, Q, start, clk, R, valid);
	clk = 0;
	rst = 1;
	#10 P = 24 ; Q = 13;
	rst = 0;
	#5 start = 1;
	#25 start = 0;
	#500 $finish;	
	
end

initial begin
	$dumpfile("t_GCD_Calculator.vcd");
	$dumpvars(0, t_GCD_Calculator);
end

endmodule
