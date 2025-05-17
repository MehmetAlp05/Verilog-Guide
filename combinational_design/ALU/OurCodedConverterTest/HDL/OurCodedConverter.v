module OurCodedConverter (
    input [15:0] inencoder,         // 16-bit input for Encoder
    output [15:0] outdecoder        // 16-bit output from Decoder
);

    // Internal wires to connect modules
    wire [3:0] outencoder;
    wire [3:0] outgray;
    wire [15:0] decoder_output;

    // Instantiate encoder
    OurEncoder encoder_ex (
        .inencoder(inencoder),   
        .outencoder(outencoder)
    );

    // Instantiate binary-to-gray converter
    OurBinaryToGrayConverter btg (
        .binary(outencoder),
        .gray(outgray)
    );

    // Instantiate decoder
    OurDecoder decoder_ex (
        .indecoder(outgray),
        .outdecoder(decoder_output)
    );

    // Assign decoder output to module output
    assign outdecoder = decoder_output;

endmodule
