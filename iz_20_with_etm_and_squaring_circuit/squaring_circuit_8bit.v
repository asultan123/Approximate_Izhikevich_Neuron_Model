`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    01:36:36 08/11/2018 
// Design Name: 
// Module Name:    squaring_circuit_8bit 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module squaring_circuit_8bit(
    input [7:0] in,
    output [15:0] out
    );

	wire[15:0] pp[4:0];
	wire[15:0] sum;
	wire[15:0] sum_stage_1[2:0];
	wire[15:0] sum_stage_2[1:0];
	reg[7:0] x;
	integer i;
	
	always@(in)
	begin
		if(in[7]==1)
			begin
				for(i = 0; i<8; i = i + 1)
					begin
						x[i] = ~in[i];
					end
			end
		else
			begin
				for(i = 0; i<8; i = i + 1)
					begin
						x[i] = in[i];
					end
			end
	end
	
	assign pp[0][0] 	= x[0];
	assign pp[0][1] 	= 0;
	assign pp[0][2] 	= x[0] & x[1];
	assign pp[0][3] 	= x[0] & x[2];
	assign pp[0][4] 	= x[0] & x[3];
	assign pp[0][5] 	= x[0] & x[4];
	assign pp[0][6] 	= x[0] & x[5];
	assign pp[0][7] 	= x[0] & x[6];
	assign pp[0][8] 	= x[0] & x[7];
	assign pp[0][9]	= x[1] & x[7];
	assign pp[0][10] 	= x[2] & x[7];
	assign pp[0][11] 	= x[3] & x[7];
	assign pp[0][12] 	= x[4] & x[7];
	assign pp[0][13] 	= x[5] & x[7];
	assign pp[0][14] 	= x[6] & x[7];
	assign pp[0][15] 	= 0;

	assign pp[1][0] 	= 0;
	assign pp[1][1] 	= 0;
	assign pp[1][2] 	= x[1];
	assign pp[1][3] 	= 0;
	assign pp[1][4] 	= x[1] & x[2];
	assign pp[1][5] 	= x[1] & x[3];
	assign pp[1][6] 	= x[1] & x[4];
	assign pp[1][7] 	= x[1] & x[5];
	assign pp[1][8] 	= x[1] & x[6];
	assign pp[1][9]	= x[2] & x[6];
	assign pp[1][10] 	= x[3] & x[6];
	assign pp[1][11] 	= x[4] & x[6];
	assign pp[1][12] 	= x[5] & x[6];
	assign pp[1][13] 	= 0;
	assign pp[1][14] 	= x[7];
	assign pp[1][15] 	= 0;

	assign pp[2][0] 	= 0;
	assign pp[2][1] 	= 0;
	assign pp[2][2] 	= 0;
	assign pp[2][3] 	= 0;
	assign pp[2][4] 	= x[2];
	assign pp[2][5] 	= 0;
	assign pp[2][6] 	= x[2] & x[3];
	assign pp[2][7] 	= x[2] & x[4];
	assign pp[2][8] 	= x[2] & x[5];
	assign pp[2][9]		= x[3] & x[5];
	assign pp[2][10] 	= x[4] & x[5];
	assign pp[2][11] 	= 0;
	assign pp[2][12] 	= x[6];
	assign pp[2][13] 	= 0;
	assign pp[2][14] 	= 0;
	assign pp[2][15] 	= 0;

	assign pp[3][0] 	= 0;
	assign pp[3][1] 	= 0;
	assign pp[3][2] 	= 0;
	assign pp[3][3] 	= 0;
	assign pp[3][4] 	= 0;
	assign pp[3][5] 	= 0;
	assign pp[3][6] 	= x[3];
	assign pp[3][7] 	= 0;
	assign pp[3][8] 	= x[3] & x[4];
	assign pp[3][9]	= 0;
	assign pp[3][10] 	= x[5];
	assign pp[3][11] 	= 0;
	assign pp[3][12] 	= 0;
	assign pp[3][13] 	= 0;
	assign pp[3][14] 	= 0;
	assign pp[3][15] 	= 0;
	
	assign pp[4][0] 	= 0;
	assign pp[4][1] 	= 0;
	assign pp[4][2] 	= 0;
	assign pp[4][3] 	= 0;
	assign pp[4][4] 	= 0;
	assign pp[4][5] 	= 0;
	assign pp[4][6] 	= 0;
	assign pp[4][7] 	= 0;
	assign pp[4][8] 	= x[4];
	assign pp[4][9]	= 0;
	assign pp[4][10] 	= 0;
	assign pp[4][11] 	= 0;
	assign pp[4][12] 	= 0;
	assign pp[4][13] 	= 0;
	assign pp[4][14] 	= 0;
	assign pp[4][15] 	= 0;
	
//	assign sum = pp[0]+pp[1]+pp[2]+pp[3]+pp[4];
	
	// Stage 1 WALLACE TREE 
	
	assign sum_stage_1[0][0] = pp[0][0];
	assign sum_stage_1[0][1] = pp[0][1];
	assign sum_stage_1[0][2] = pp[0][2];
	assign sum_stage_1[1][2] = pp[1][2];
	assign sum_stage_1[0][3] = pp[0][3];
	
	CSA_32 inst_1(pp[0][4],pp[1][4],pp[2][4],sum_stage_1[0][4],sum_stage_1[0][5]);
	CSA_22 inst_2(pp[0][5],pp[1][5],sum_stage_1[1][5],sum_stage_1[0][6]);
	CSA_32 inst_3(pp[0][6],pp[1][6],pp[2][6],sum_stage_1[1][6],sum_stage_1[0][7]);
	assign sum_stage_1[2][6] = pp[3][6];
	CSA_32 inst_4(pp[0][7],pp[1][7],pp[2][7],sum_stage_1[1][7],sum_stage_1[0][8]);
	CSA_32 inst_5(pp[0][8],pp[1][8],pp[2][8],sum_stage_1[1][8],sum_stage_1[0][9]);
	CSA_22 inst_6(pp[3][8],pp[4][8],sum_stage_1[2][8],sum_stage_1[1][9]);
	CSA_32 inst_7(pp[0][9],pp[1][9],pp[2][9],sum_stage_1[2][9],sum_stage_1[0][10]);
	CSA_32 inst_8(pp[0][10],pp[1][10],pp[2][10],sum_stage_1[1][10],sum_stage_1[0][11]);
	assign sum_stage_1[2][10] = pp[3][10];
	CSA_22 inst_9(pp[0][11],pp[1][11],sum_stage_1[1][11],sum_stage_1[0][12]);
	CSA_32 inst_10(pp[0][12],pp[1][12],pp[2][12],sum_stage_1[1][12],sum_stage_1[0][13]);
	assign sum_stage_1[1][13] = pp[0][13];
	CSA_22 inst_11(pp[0][14],pp[1][14],sum_stage_1[0][14],sum_stage_1[0][15]);
	
	// Stage 2 WALLACE TREE 
	
	assign sum_stage_2[0][0] = sum_stage_1[0][0];
	assign sum_stage_2[0][1] = sum_stage_1[0][1];
	assign sum_stage_2[0][2] = sum_stage_1[0][2];
	assign sum_stage_2[1][2] = sum_stage_1[1][2];
	assign sum_stage_2[0][3] = sum_stage_1[0][3];
	assign sum_stage_2[0][4] = sum_stage_1[0][4];
	assign sum_stage_2[0][5] = sum_stage_1[0][5];
	assign sum_stage_2[1][5] = sum_stage_1[1][5];
	
	CSA_32 inst_12(sum_stage_1[0][6],sum_stage_1[1][6],sum_stage_1[2][6],sum_stage_2[0][6],sum_stage_2[0][7]);
	CSA_22 inst_13(sum_stage_1[0][7],sum_stage_1[1][7],sum_stage_2[1][7],sum_stage_2[0][8]);
	CSA_32 inst_15(sum_stage_1[0][8],sum_stage_1[1][8],sum_stage_1[2][8],sum_stage_2[1][8],sum_stage_2[0][9]);
	CSA_32 inst_16(sum_stage_1[0][9],sum_stage_1[1][9],sum_stage_1[2][9],sum_stage_2[1][9],sum_stage_2[0][10]);
	CSA_32 inst_17(sum_stage_1[0][10],sum_stage_1[1][10],sum_stage_1[2][10],sum_stage_2[1][10],sum_stage_2[0][11]);
	CSA_22 inst_18(sum_stage_1[0][11],sum_stage_1[1][11],sum_stage_2[1][11],sum_stage_2[0][12]);
	CSA_22 inst_19(sum_stage_1[0][12],sum_stage_1[1][12],sum_stage_2[1][12],sum_stage_2[0][13]);
	CSA_22 inst_20(sum_stage_1[0][13],sum_stage_1[1][13],sum_stage_2[1][13],sum_stage_2[0][14]);
	
	assign sum_stage_2[1][14] = sum_stage_1[0][14];
	assign sum_stage_2[0][15] = sum_stage_1[0][15];
	
	// Stage 2 ADDING ZEROS
	
	assign sum_stage_2[1][15] = 0;
	assign sum_stage_2[1][6] = 0;
	assign sum_stage_2[1][4] = 0;
	assign sum_stage_2[1][3] = 0;
	assign sum_stage_2[1][1] = 0;
	assign sum_stage_2[1][0] = 0;
	
	RippleCarryAdder #(.n(16)) adder(.Cin(1'b0),.X(sum_stage_2[0]),.Y(sum_stage_2[1]),.S(sum),.Cout());

	assign out = sum;

endmodule
