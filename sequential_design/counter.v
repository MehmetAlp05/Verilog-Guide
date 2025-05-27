module counter #(
    parameter W = 8 // Width of the counter
)(
    input wire clk,              // Clock signal
    input wire rst,              // Asynchronous reset
    input wire [1:0] ctrl,       // Control signal: 00=Hold, 01=Increment, 10=Decrement
    output reg [W-1:0] count     // Counter output
);

always @(posedge clk or posedge rst) begin
    if (rst) begin
        count <= 0; // Reset counter to zero
    end else begin
        case (ctrl)
            2'b00: count <= count;            // Hold
            2'b01: count <= count + 1;        // Increment
            2'b10: count <= count - 1;        // Decrement
            default: count <= count;          // Reserved (hold by default)
        endcase
    end
end

endmodule
