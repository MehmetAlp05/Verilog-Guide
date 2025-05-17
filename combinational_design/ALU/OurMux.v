module OurMux #(parameter W = 8)(
    input [W-1:0] inmux1,// 8-bit input
	 input [W-1:0] inmux2,
	 input [W-1:0] inmux3,
	 input [W-1:0] inmux4,
	 input [W-1:0] inmux5,
	 input [W-1:0] inmux6,
	 input [W-1:0] inmux7,
	 input [W-1:0] inmux8,
	 input [2:0] select,
    output reg [W-1:0]outmux // 1-bit output
);
    always @(*) begin
      case(select)
			3'b000:outmux=inmux1;
			3'b001:outmux=inmux2;
			3'b010:outmux=inmux3;
			3'b011:outmux=inmux4;
			3'b100:outmux=inmux5;
			3'b101:outmux=inmux6;
			3'b110:outmux=inmux7;
			3'b111:outmux=inmux8;
			default :outmux={W{1'b0}};
		endcase
    end

endmodule