/***************************************************
* Datapath for GCD calculator
* Shanthanu S Rai(1NCO242) and Varun Pattar(1NCO249)
* November, 9 2018
****************************************************/

module Datapath(
input[N-1:0] P, Q,
input Selp, Selq, Sela, Selb, Ldp, Ldq, Ldr, clk, rst,
output[N-1:0] R,
output eq, gth
);

parameter N = 8;

reg[N-1:0] R;
reg[N-1:0] Pbus, Qbus, ALU;
reg[N-1:0] Abus, Bbus;

//regP
always @ (posedge clk, posedge rst) begin

	if(rst) Pbus <= 0;
	else if (Ldp) begin
		if(Selp) Pbus <= P;
		else Pbus <= ALU;
	end
	
end

//regQ
always @ (posedge clk, posedge rst) begin

	if(rst) Qbus <= 0;
	else if(Ldq) begin
		if(Selp) Qbus <= Q;
		else Qbus <= ALU;
	end

end

//mux a
always @ (Pbus, Qbus, Sela) begin

	if(Sela) Abus = Pbus;
	else Abus = Qbus;

end

//mux b
always @ (Pbus, Qbus, Selb) begin

	if(Selb) Bbus = Qbus;
	else Bbus = Pbus;

end

//alu
always @ (Abus, Bbus) ALU = Abus - Bbus;

//reg R
always @ (posedge clk) begin

	if(Ldr) R <= Pbus;
	else R <= R;
		
end

//comparator
assign eq = (Pbus == Qbus)?1:0;
assign gth = (Pbus > Qbus)?1:0;

endmodule
