`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    01:58:07 08/11/2018 
// Design Name: 
// Module Name:    CSA_3-2 
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
module CSA_32(
    input a,
    input b,
    input c,
    output s,
    output o
    );
	 
	 assign s = (a^b)^c;
	 assign o = (a & b) | (c & (a^b));


endmodule
