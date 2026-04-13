`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.04.2026 13:08:27
// Design Name: 
// Module Name: Design
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module claAdder(
    input [3:0]a_i, 
    input [3:0]b_i, 
    input carry_i, 
    output [3:0]sum_o, 
    output carry_o
);

//net(s)
wire [3:0]c; //intermediate carries
wire [3:0]gen; //generate
wire [3:0]prop; //propagate
genvar i;

//generate and propagate
generate for(i = 0; i < 4; i = i + 1)
   begin : CLA
      assign gen[i] = a_i[i] & b_i[i];
      assign prop[i] = a_i[i] ^ b_i[i];
   end
endgenerate

//intermediate carries
assign c[1] = gen[0] | (prop[0] & carry_i); //C1 = G0 + P0.C0
assign c[2] = gen[1] | (prop[1] & gen[0]) | (prop[1] & prop[0] & carry_i); //C2 = G1 + P1.G0 + P1.P0.C0
assign c[3] = gen[2] | (prop[2] & gen[1]) | (prop[2] & prop[1] & gen[0]) | (prop[2] & prop[1] & prop[0] & carry_i);
    //C3 = G2 + P2.G1 + P2.P1.G0 + P2.P1.P0.C0

//carry out
assign carry_o = gen[3] | (prop[3] & gen[2]) | (prop[3] & prop[2] & gen[1]) | (prop[3] & prop[2] & prop[1] & gen[0]) 
   | (prop[3] & prop[2] & prop[1] & prop[0] & carry_i);

//sum
assign c[0] = carry_i;
generate for(i = 0; i < 4; i = i + 1)
   begin : SUM
      assign sum_o[i] = prop[i] ^ c[i];
   end
endgenerate

endmodule
