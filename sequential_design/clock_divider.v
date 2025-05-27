module clock_divider #(
    parameter DIV_FACTOR = 4  // Must be even for 50% duty cycle
)(
    input wire clk_in,       // Input clock (e.g., 50 MHz from DE1-SoC)
    output reg clk_out       // Output divided clock
);

    // Internal counter size enough to hold up to DIV_FACTOR
    reg [31:0] counter = 0;
	 initial clk_out=0;
    always @(posedge clk_in) begin
            if (counter == (DIV_FACTOR / 2 - 1)) begin
                clk_out <= ~clk_out;
                counter <= 0;
            end else begin
                counter <= counter + 1;
            end
        end

endmodule