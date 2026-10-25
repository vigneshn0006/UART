`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/09/2026 07:17:28 PM
// Design Name: 
// Module Name: Baud_rate_gen
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


module Baud_rate_gen(input clk,rst,output reg tx_en,rx_en );
    reg [13:0]tx_count=0;
    reg [9:0]rx_count=0;
    always@( posedge clk,posedge rst) begin
        if(rst) begin
            tx_count<=0;
            rx_count<=0;
            tx_en<=0;
            rx_en<=0;
        end
        else begin
            if(tx_count==14'd10415)begin
                tx_en<=1'b1;
                tx_count<=0;
            end
            else begin
                tx_en<=1'b0;
                tx_count<=tx_count+1;
            end
            if(rx_count==10'd650) begin
                rx_en<=1'b1;
                rx_count<=0;
            end
            else begin
                rx_en<=1'b0;
                rx_count<=rx_count+1;
            end
         end
    end
    
endmodule
