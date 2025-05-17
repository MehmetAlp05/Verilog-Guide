module ALU #(
    parameter W = 12
)(
    input  [W-1:0] DATA_A,
    input  [W-1:0] DATA_B,
    input  [1:0] control,
    output [W-1:0] OUT,
    output CO, OVF, N, Z
);

    wire [W-1:0] ao, lo;
    wire aco, aovf;
    Arithmetic_Unit #(.W(W)) AU (
        .DATA_A(DATA_A),
        .DATA_B(DATA_B),
        .control(control[0]), // Use LSB to select ADD or SUB
        .OUT(ao),
        .CO(aco),
        .OVF(aovf),
        .N(),
        .Z()
    );
    Logic_Unit #(.W(W)) LU (
        .DATA_A(DATA_A),
        .DATA_B(DATA_B),
        .control(control[0]), 
        .OUT(logic_out),
        .N(),
        .Z()
    );
    assign OUT = (control[1] == 1'b1) ? arith_out : logic_out;
    assign CO  = (control[1] == 1'b1) ? aco: 1'b0;
    assign OVF = (control[1] == 1'b1) ? aovf: 1'b0;
    assign N   = OUT[W-1];
    assign Z   = (OUT == {W{1'b0}});
    
endmodule
