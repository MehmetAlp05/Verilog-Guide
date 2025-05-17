//------------------------------------------------------------------------------
// Module Declaration
// A 'module' in Verilog is the fundamental building block of a design. It
// encapsulates a specific functionality and can be instantiated multiple times
// within a design hierarchy.
//
// Parameters
// Parameters are constants that can be set at compile time to configure the
// behavior or structure of a module. They allow for reusable and flexible
// module definitions.
//
// Ports
// Ports are the input and output connections of a module. They define how data
// enters and exits the module. Ports can be of type input, output, or inout.
//
// This file contains a Verilog module definition with parameters and ports,
// demonstrating how to create configurable and reusable hardware components.
//------------------------------------------------------------------------------
module moduleName #(
    W=4 // Default width of 4 bits
) (
    input Control,         // 2-bit control signal
    input [W-1:0]DATA,        // W-bit input DATA_A
    output reg [W-1:0]Result    // W-bit output
);
    always @(*) begin
        // -----------------------------------------------------------------------------
        // Example of module declaration and case statement usage in Verilog.
        //
        // This code snippet demonstrates a combinational logic block that performs
        // different operations on the input 'DATA' based on the value of the 'Control'
        // signal. The result of the operation is assigned to the 'Result' output.
        //
        // - case (Control): Selects the operation to perform based on the 2-bit 'Control' input.
        //   - 2'b00: Increment operation. Adds 1 to 'DATA'.
        //   - 2'b01: Decrement operation. Subtracts 1 from 'DATA'.
        //   - 2'b10: Shift left operation. Shifts 'DATA' one bit to the left.
        //   - 2'b11: Shift right operation. Shifts 'DATA' one bit to the right.
        //   - default: Assigns zero to 'Result' using a concatenation of W zeros.
        //
        // Each case provides a simple arithmetic or bitwise operation, making this
        // example useful for understanding basic combinational logic and control flow
        // in Verilog.
        // -----------------------------------------------------------------------------
        case (Control)
            2'b00: Result = DATA + 1;         // Increment
            2'b01: Result = DATA - 1;         // Decrement
            2'b10: Result = DATA << 1;        // Shift left
            2'b11: Result = DATA >> 1;        // Shift right
            default: Result = {W{1'b0}};      // Default to zero
        endcase
    end
        
endmodule