/*
		Implementa uma máquina de estados que
	descreve uma máquina de refrigerante.
*/

module StateMachine(M, N, C, R, L, LR1, LR2, LL, CLK);
	input M, N, C, R, L, CLK;
	output LR1, LR2, LL;
	reg [3:0] state;

	// Estados
	parameter eS0 = 4'b0000;
	parameter eS1 = 4'b0001;
	parameter eS2 = 4'b0010;
	parameter eS3 = 4'b0011;

	parameter eLM1 = 4'b0100;
	parameter eLM2 = 4'b0101;
	parameter eLM3 = 4'b0110;


	parameter eLR1 = 4'b0111;
	parameter eLR2 = 4'b1000;
	
	parameter eLL  = 4'b1001;

	// Saidas
	assign LR1 = (state == eLR1);
	assign LR2 = (state == eLR2);
	assign LL  = (state == eLL);

	// Descricao comportamental
	always @(posedge CLK) begin
		case(state)
			eS0: begin
				if(M)
					state <= eS1;
				else if(N) 
					state <= eS2;
			end
			eS1: begin
				if(M)
					state <= eS2;
				else if(N) 
					state <= eS3;
				else if(C)
					state <= eLM1;
			end
			eS2: begin
				if(M)
					state <= eS3;
				else if(R) 
					state <= eLR1;
				else if(C)
					state <= eLM2;
			end
			eS3: begin
				if(L)
					state <= eLL;
				else if(R) 
					state <= eLR2;
				else if(C)
					state <= eLM3;
			end
			eLM1: state <= eS0;
			eLM2: state <= eS1;
			eLM3: state <= eS2;
			eLR1: state <= eS0;
			eLR2: state <= eS0;
			eLL:  state <= eS0;
		endcase
	end
endmodule