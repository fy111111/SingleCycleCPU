`timescale 1ns / 1ps
`include "head.v"
module PC(
    input clk,
    input RST,
    input [31:0]newpc,
    output reg [31:0]pc
    );
    always@(posedge clk or negedge RST) begin
        pc <= RST == 0 ? 0 : newpc;
    end
endmodule

module PCHelper(
    input clk,
    input [31:0] pc,
    input [15:0] immd16,
    input [25:0] immd26,
    input [1:0] sel,
    output reg [31:0] newpc
    );
    always@(negedge clk) begin
        case (sel)
            `NextIns : newpc <= pc + 4;
            `RelJmp : newpc <= pc + 4 + immd16 << 2;
            `AbsJmp : newpc <= {pc[31:28], immd26, 2'b00};
            `HALT : newpc <= pc;
        endcase
    end
endmodule
