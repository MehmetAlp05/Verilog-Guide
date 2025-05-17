module OurRegE #(parameter W = 8)(
    input clk,      // Clock
	 input reset,
	 input enable,
    input [W-1:0] datain,
	 output reg [W-1:0]dataout // W-bit output
);
    always @(posedge clk)begin
	  if(reset)begin
			dataout<={W{1'b0}};
		end
		else if (enable) begin 
			dataout<=datain;
		end
	  end

endmodule