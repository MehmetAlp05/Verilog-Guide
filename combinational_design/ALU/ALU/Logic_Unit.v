module Logic_Unit #(parameter W=4) (
    input  [W-1:0] DATA_A,
    input  [W-1:0] DATA_B,
    input  control, // 0 for AND, 1 for OR
    output [W-1:0] OUT,
    output N, Z
);

    // Perform bitwise operation based on control signal
    assign OUT = control ? (DATA_A | DATA_B) : (DATA_A & DATA_B);
    
    // Negative flag: Set if the most significant bit (MSB) is 1
    assign N = OUT[W-1];
    
    // Zero flag: Set if OUT is all zeros
    assign Z = (OUT == 0);
    
endmodule
