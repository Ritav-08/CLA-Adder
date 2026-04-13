`timescale 1ns / 1ps

module tb_claAdder();
reg [3:0]a_i;
reg [3:0]b_i; 
reg carry_i;
wire [3:0]sum_o; 
wire carry_o;


//instantiation
claAdder DUT(.a_i(a_i), 
    .b_i(b_i), 
    .carry_i(carry_i), 
    .sum_o(sum_o), 
    .carry_o(carry_o));

initial begin //feeding
a_i = 4'b0000; b_i = 4'b0000; carry_i = 1'b0; //all 0s
#5 a_i = 4'd5; b_i = 4'd7; carry_i = 1'b0; //without carry
#5 a_i = 4'd7; b_i = 4'd7; carry_i = 1'b1; //with carry
#5 a_i = 4'd8; b_i = 4'd8; carry_i = 1'b0; //overflow without carry
#5 a_i = 4'd8; b_i = 4'd8; carry_i = 1'b1; //overflow with carry
#5 a_i = 4'd15; b_i = 4'd15; carry_i = 1'b1; //max
end

initial begin //capture
$monitor("Time: %0t | A: %0d, B: %0d, Carry_input: %b | Sum: %0d, Carry_output: %b", $time, a_i, b_i, carry_i, sum_o, carry_o);
$dumpfile("claAdder.vcd");
$dumpvars(0, tb_claAdder);
#30 $finish;
end

endmodule
