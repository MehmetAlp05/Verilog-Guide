module Arithmetic_Unit#(parameter W=12)
        ( // This is a template. 
// You can modify the input-output declerations(width etc.) without changing the names.
    input   [W-1:0] DATA_A, 
    input   [W-1:0] DATA_B, 
    input   control,
    output  [W-1:0] OUT, 
    output  CO, OVF, N, Z
);
wire [W-1:0] B_new= control ? DATA_B : ~DATA_B;
wire [W:0] arithmetic= {1'b0, DATA_A} + {1'b0, B_new} + {{W{1'b0}}, ~control}; 
//output
assign OUT = arithmetic[W-1:0]; 
assign CO = arithmetic[W]; // carry out signal
assign OVF = (DATA_A[W-1] == B_new[W-1]) && (DATA_A[W-1] != OUT[W-1]); //overflow
assign Z= (OUT ==0); // zero
assign N = OUT[W-1]; // negative


endmodule