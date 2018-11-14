/***************************************************
* GCD calculator
* Shanthanu S Rai(17CO242) and Varun Pattar(17CO249)
* November, 13 2018
****************************************************/

`include "Control_Unit.v"
`include "Datapath.v"

module GCD_Calculator(
input[N-1:0] P, Q,
input clk, rst, start,
output[N-1:0] R,
output valid,
output[1:0] State_Y
);

parameter N = 8;

wire Selp, Selq, Sela, Selb, Ldp, Ldq, Ldr, valid, eq, gth;

Control_Unit C(eq, gth, clk, rst, start, Selp, Selq, Sela, Selb, Ldp, Ldq, Ldr, valid, State_Y);

Datapath D(P, Q, Selp, Selq, Sela, Selb, Ldp, Ldq, Ldr, clk, rst, R, eq, gth);

endmodule
