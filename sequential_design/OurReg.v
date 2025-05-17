module OurReg #(parameter W = 8)(
    input clk,      // Clock
	 input reset,
    input [W-1:0] datain,
	 output reg [W-1:0]dataout // W-bit output
);
    always @(posedge clk)begin
        if(reset)dataout<={W{1'b0}};
		  else dataout<=datain;
    end

endmodule