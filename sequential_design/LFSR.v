module LFSR (
    input wire clk,
    input wire enable,
	 input wire [15:0] d_in,
    output [15:0] q,
	 output sol,
	 output sor
);

    wire feedback;
	
    // Feedback is XOR of bits 0, 2, 3, and 5
    assign feedback = q[0] ^ q[2] ^ q[3] ^ q[5];
	 
	shift #(.W(16)) my_shift(
		.clk(clk),
		.shift_left(0),
		.shift_en(~enable),
		.load(enable),
		.d_in(d_in),
		.serial_in_left(feedback),
		.serial_in_right(feedback),
		.q(q),
		.serial_out_left(sol),
		.serial_out_right(sor)
	);
endmodule