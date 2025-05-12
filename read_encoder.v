module Read_Encoder (
    input wire clk,
    input wire rst_n,

    input wire A,
    input wire B,

    output reg [1:0] dir
);

    reg A_anterior;
    reg B_anterior;

    always @(posedge clk or negedge rst_n) begin
        if(~rst_n) begin
            dir <= 2'b00;
            A_anterior <= 1'b0;
            B_anterior <= 1'b0;
        end else begin
            // Detecta sentido anti-horário
            if ((A_anterior == 0 && B_anterior == 0 && A == 1 && B == 0) ||
                (A_anterior == 1 && B_anterior == 0 && A == 1 && B == 1) ||
                (A_anterior == 1 && B_anterior == 1 && A == 0 && B == 1) ||
                (A_anterior == 0 && B_anterior == 1 && A == 0 && B == 0)) begin
                    dir <= 2'b01;
            end

            // Detecta sentido horário
            else if ((A_anterior == 0 && B_anterior == 0 && A == 0 && B == 1) ||
                     (A_anterior == 0 && B_anterior == 1 && A == 1 && B == 1) ||
                     (A_anterior == 1 && B_anterior == 1 && A == 1 && B == 0) ||
                     (A_anterior == 1 && B_anterior == 0 && A == 0 && B == 0)) begin
                dir <= 2'b10;
            end

            else begin
                dir <= 2'b00;
            end

            // Atualiza estados anteriores
            A_anterior <= A;
            B_anterior <= B;
        end
    end

endmodule