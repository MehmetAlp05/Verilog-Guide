module OurDecoder (
    input [2:0] indecoder,      // 3-bit input
    output reg [7:0]outdecoder // 8-bit output
);
    always @(*) begin
			case (indecoder)
				  3'b000: outdecoder = 8'b00000001;
				  3'b001: outdecoder = 8'b00000010;
				  3'b010: outdecoder = 8'b00000100;
				  3'b011: outdecoder = 8'b00001000;
				  3'b100: outdecoder = 8'b00010000;
				  3'b101: outdecoder = 8'b00100000;
				  3'b110: outdecoder = 8'b01000000;
				  3'b111: outdecoder = 8'b10000000;
				  default: outdecoder = 8'b00000000; 
			 endcase     
	  end

endmodule