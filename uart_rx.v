`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/09/2026 11:04:19 PM
// Design Name: 
// Module Name: uart_rx
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


module uart_rx(input rdy, rx, clk, rst,rx_en, output reg [7:0]data_out, output reg done);
    parameter idle=2'b00, start=2'b01, data=2'b10, stop=2'b11;
    reg [4:0] sample;
    reg[2:0] bit_count;
    reg [1:0] state;
    reg [7:0] data_buffer;
    always@(posedge clk, posedge rst)begin
        if(rst) begin
            sample<=0;
            bit_count<=0;
            state<=idle;
            data_buffer<=0;
            done<=0;
            data_out<=0;
        end
        else begin
            done<=0;
            case(state)
                idle: begin
                    sample<=0;
                    bit_count<=0;
                    if(rx==0) state<=start;
                end
                start: begin
                    if(rx_en) begin
                        if(sample==4'd7) begin
                            sample<=0;
                            if(rx==0) state<=data;
                            else state<=idle;
                        end
                        else sample<=sample+1;
                    end
                end
                data: begin
                    if(rx_en) begin
                        if(sample==4'd15) begin
                            data_buffer[bit_count]<=rx;
                            sample<=0;
                            if(bit_count==7) state<=stop;
                            else bit_count<=bit_count+1;
                        end
                        else sample<=sample+1;
                    end
                end
                stop: begin
                    if(rx_en) begin
                        if(sample==4'd15) begin
                            if(rx==1) begin
                                data_out<=data_buffer;
                                done<=1;
                            end
                            state<=idle;
                        end
                        else sample<=sample+1;
                    end
                end
                default: state<=idle;
            endcase
        end
    end
endmodule
