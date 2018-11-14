/***************************************************
* Control Unit for GCD calculator
* Shanthanu S Rai(17CO242) and Varun Pattar(17CO249)
* November, 3 2018
****************************************************/

module Control_Unit(
input eq, gth, clk, rst, start,
output Selp, Selq, Sela, Selb, Ldp, Ldq, Ldr, valid,
output[1:0] State_Y
);

parameter N = 8;

reg[N-1:0] Control_Variable;
//y is the current state, Y is the next state
reg[1:0] y, Y;
wire Selp, Selq, Sela, Selb, Ldp, Ldq, Ldr, valid;

parameter S0 = 0, S1 = 1, S2 = 2, S3 = 3;
 
//next state logic
always @ (y, start, eq, gth) begin
	
	case(y)
		S0: if(!start) Y = S0;
			else if(eq) Y = S1;
			else if(gth) Y = S2;
			else Y = S3;
		S1: Y = S0;
		S2: if(eq) Y = S1;
			else if(gth) Y = S2;
			else Y = S3;
		S3:	if(eq) Y = S1;
			else if(gth) Y = S2;
			else Y = S3;
	endcase
	
end

//state register
always @ (posedge rst, negedge clk)
	if(rst) y<=S0;
	else y<=Y;
	
//Assign Control_Variable wires
assign {Selp, Selq, Sela, Selb, Ldp, Ldq, Ldr, valid} = Control_Variable;

//output logic

always @ (y)
	case(y)
		S0: Control_Variable = 8'b11001100;
		S1: Control_Variable = 8'b00000011;
		S2: Control_Variable = 8'b00111000;
		S3: Control_Variable = 8'b00000100;
	endcase
	
assign State_Y = Y;

endmodule
