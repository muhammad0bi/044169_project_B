`timescale 1ns / 1ps

module adder
    (input logic [8:0] a, b,
     output logic [8:0] y);


assign y = a + b;

endmodule
