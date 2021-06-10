module RippleCarryAdder(Cin, X, Y, S, Cout);
	parameter n = 4;
	input Cin;
	input [n-1:0] X, Y;
	output reg [n-1:0] S;
	output reg Cout;
	reg [n:0] C;
	integer k;
	always @(X, Y, Cin)
		begin
			C[0] = Cin;
			for (k=0;k<=n-1;k=k+1)
			begin
				S[k] = X[k] ^ Y[k] ^ C[k];
				C[k+1] = (X[k] & Y[k])|(X[k] & C[k])|(Y[k] & C[k]);
			end
			Cout = C[n];
		end
endmodule