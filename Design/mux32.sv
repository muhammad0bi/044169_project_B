`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Biadsy Muhammad & Sharafi Omar
// 
// Create Date: 05/06/2025 13:40:50 PM
// Design Name: 
// Module Name: mux32
// Project Name: Ricsv backened
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


module mux32

    (input logic [31:0] d00000, d00001, d00010, d00011,
			d00100, d00101, d00110, d00111,
			d01000, d01001, d01010, d01011,
			d01100, d01101, d01110, d01111,
			d10000, d10001, d10010, d10011,
			d10100, d10101, d10110, d10111,
			d11000, d11001, d11010, d11011,
			d11100, d11101, d11110, d11111,
     input logic [4:0] s,
     output logic [31:0] y);

always_comb begin
        case (s)
            5'b00000: y = d00000;
            5'b00001: y = d00001;
            5'b00010: y = d00010;
            5'b00011: y = d00011;
            5'b00100: y = d00100;
            5'b00101: y = d00101;
            5'b00110: y = d00110;
            5'b00111: y = d00111;
            5'b01000: y = d01000;
            5'b01001: y = d01001;
            5'b01010: y = d01010;
            5'b01011: y = d01011;
            5'b01100: y = d01100;
            5'b01101: y = d01101;
            5'b01110: y = d01110;
            5'b01111: y = d01111;
            5'b10000: y = d10000;
            5'b10001: y = d10001;
            5'b10010: y = d10010;
            5'b10011: y = d10011;
            5'b10100: y = d10100;
            5'b10101: y = d10101;
            5'b10110: y = d10110;
            5'b10111: y = d10111;
            5'b11000: y = d11000;
            5'b11001: y = d11001;
            5'b11010: y = d11010;
            5'b11011: y = d11011;
            5'b11100: y = d11100;
            5'b11101: y = d11101;
            5'b11110: y = d11110;
            5'b11111: y = d11111;
            default:  y = 32'd0;
        endcase
    end

endmodule
