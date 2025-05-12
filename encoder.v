module Encoder (
    input wire clk,
    input wire rst_n,

    input wire horario,
    input wire antihorario,

    output reg A,
    output reg B
);

reg [1:0] current_state;

localparam [1:0] S0 = 2'b00,
                 S1 = 2'b01,
                 S2 = 2'b10,
                 S3 = 2'b11;

always @(posedge clk, negedge rst_n) begin
    if(~rst_n) begin
        A <= 0;
        B <= 0;
        current_state <= 0;
    end

    else begin
        if(horario && ~antihorario) begin
            case (current_state)
                S0: begin
                    current_state <= S2;
                    A <= S2[1];
                    B <= S2[0];
                end 
                S1: begin
                    current_state <= S0;
                    A <= S0[1];
                    B <= S0[0]; 
                end 
                S2: begin
                    current_state <= S3;
                    A <= S3[1];
                    B <= S3[0];
                end 
                S3: begin
                    current_state <= S1;
                    A <= S1[1];
                    B <= S1[0];
                end 
            endcase
        end

        else if(antihorario && ~horario) begin
            case (current_state)
                S0: begin
                    current_state <= S1;
                    A <= S1[1];
                    B <= S1[0];
                end 
                S1: begin
                    current_state <= S3;
                    A <= S3[1];
                    B <= S3[0]; 
                end 
                S2: begin
                    current_state <= S0;
                    A <= S0[1];
                    B <= S0[0];
                end 
                S3: begin
                    current_state <= S2;
                    A <= S2[1];
                    B <= S2[0];
                end 
            endcase
        end

        else begin
            current_state <= current_state;
            A <= current_state[1];
            B <= current_state[0];
        end
    end

end

endmodule
