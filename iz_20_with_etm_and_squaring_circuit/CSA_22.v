`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    02:01:58 08/11/2018 
// Design Name: 
// Module Name:    CSA_22 
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
module CSA_22(
    input a,
    input b,
    output s,
    output o
    );

	assign s = a^b;
	assign o = a&b;

endmodule
