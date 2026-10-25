`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/09/2026 10:07:48 PM
// Design Name: 
// Module Name: uart_tx
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


module uart_tx(input clk,rst,write_en,tx_en,input [7:0] data_in, output reg tx,rdy);
    parameter idle=2'b00, start=2'b01, data=2'b10, stop=2'b11;
    reg [3:0] ind;
    reg [1:0] state;
    reg [7:0] data_buffer;
    always@(posedge clk,posedge rst) begin
        if(rst) begin
            state<=2'b00;
            rdy<=1;
            tx<=1;
            data_buffer<=0;
            ind<=3'b000;
        end
        else begin
            case(state) 
                idle: begin
                    rdy<=1;
                    tx<=1;
                    ind<=0;
                    if(write_en)begin
                        data_buffer<=data_in;
                        rdy<=0;
                        state<=start;
                    end
                    else state<=idle;
                end
                start: begin
                    rdy<=0;
                    tx<=0;
                    if(tx_en)begin
                        
                        state<=data;
                    end
                end
                data: begin
                    rdy<=0;
                    if(tx_en) begin
                        tx<=data_buffer[ind];
                        if(ind==7) state<=stop;
                        else ind<=ind+1;
                    end
                end
                stop: begin
                    rdy<=0;
                    if(tx_en)begin
                        tx<=1;
                        state<=idle;
                    end
                end
                default: state<=idle;
            endcase 
        end
    end
endmodule
