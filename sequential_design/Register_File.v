module Register_File #(// This is a template. 
// You can modify the input-output declerations(width etc.) without changing the names.
    parameter W = 4                 // Data width parameter (default 4 bits)
) (
    input CLK,                 // Clock signal
    input Reset,               // Reset signal (active high)
    input [W-1:0] Data,        // W-bit data input
    input [2:0] Destination_Select,  // 3-bit write address
    input Write_Enable,        // Write enable signal
    input [2:0] Source_Select_0,  // 3-bit read address for port 0
    input [2:0] Source_Select_1,  // 3-bit read address for port 1
    output [W-1:0] Out_0,       // W-bit output for port 0
    output [W-1:0] Out_1        // W-bit output for port 1
);

// Fill here
wire [7:0]decout;
wire [W-1:0]regout0;
wire [W-1:0]regout1;
wire [W-1:0]regout2;
wire [W-1:0]regout3;
wire [W-1:0]regout4;
wire [W-1:0]regout5;
wire [W-1:0]regout6;
wire [W-1:0]regout7;

OurDecoder mydec(
.indecoder(Destination_Select),
.outdecoder(decout)
);
OurRegE #(.W(W)) REG0 (
.clk(CLK),      // Clock
.reset(Reset),
.enable(Write_Enable&&decout[0]),
.datain(Data),
.dataout(regout0)
);

OurRegE #(.W(W)) REG1 (
.clk(CLK),      // Clock
.reset(Reset),
.enable(Write_Enable&&decout[1]),
.datain(Data),
.dataout(regout1)
);

OurRegE #(.W(W)) REG2 (
.clk(CLK),      // Clock
.reset(Reset),
.enable(Write_Enable&&decout[2]),
.datain(Data),
.dataout(regout2)
);

OurRegE #(.W(W)) REG3 (
.clk(CLK),      // Clock
.reset(Reset),
.enable(Write_Enable&&decout[3]),
.datain(Data),
.dataout(regout3)
);
OurRegE #(.W(W)) REG4 (
.clk(CLK),      // Clock
.reset(Reset),
.enable(Write_Enable&&decout[4]),
.datain(Data),
.dataout(regout4)
);

OurRegE #(.W(W)) REG5 (
.clk(CLK),      // Clock
.reset(Reset),
.enable(Write_Enable&&decout[5]),
.datain(Data),
.dataout(regout5)
);

OurRegE #(.W(W)) REG6 (
.clk(CLK),      // Clock
.reset(Reset),
.enable(Write_Enable&&decout[6]),
.datain(Data),
.dataout(regout6)
);

OurRegE #(.W(W)) REG7 (
.clk(CLK),  // Clock
.reset(Reset),
.enable(Write_Enable&&decout[7]),
.datain(Data),
.dataout(regout7)
);
OurMux #(.W(W)) MUX1(
.inmux1(regout0),
.inmux2(regout1),
.inmux3(regout2),
.inmux4(regout3),
.inmux5(regout4),
.inmux6(regout5),
.inmux7(regout6),
.inmux8(regout7),
.select(Source_Select_0),
.outmux(Out_0)
);

OurMux #(.W(W)) MUX2(
.inmux1(regout0),
.inmux2(regout1),
.inmux3(regout2),
.inmux4(regout3),
.inmux5(regout4),
.inmux6(regout5),
.inmux7(regout6),
.inmux8(regout7),
.select(Source_Select_1),
.outmux(Out_1)
);

endmodule