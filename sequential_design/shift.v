module shift #(
    parameter W = 8
)(
    input wire clk,
    input wire shift_left,      // 1: shift left, 0: shift right
    input wire shift_en,        // 1: shift, 0: no shift
    input wire load,            // 1: parallel load, 0: shift
    input wire [W-1:0] d_in,    // Parallel data input
    input wire serial_in_left,  // Serial input for left shift
    input wire serial_in_right, // Serial input for right shift
    output reg [W-1:0] q,       // Register output
    output wire serial_out_left, // Serial output from left end
    output wire serial_out_right // Serial output from right end
);
assign serial_out_left = q[W-1];
assign serial_out_right = q[0];
always @(posedge clk) begin
	 if (load) begin
        q <= d_in;
    end else if (shift_en) begin
        if (shift_left) begin
            q <= {q[W-2:0], serial_in_left};
        end else begin
            q <= {serial_in_right, q[W-1:1]};
        end
    end
end

endmodule