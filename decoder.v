// Decoder circuit
`define AND and #50
`define OR or #50
`define XOR xor #50
`define NOT not #50

module behavioralDecoder
(
    output out0, out1, out2, out3,
    input address0, address1,
    input enable
);
    // Uses concatenation and shift operators
    assign {out3,out2,out1,out0}=enable<<{address1,address0};
endmodule


module structuralDecoder
(
    output out0, out1, out2, out3,
    input address0, address1,
    input enable
);

	wire nadd0;
	wire nadd1;
    wire add0add1;
    wire nadd0add1;
    wire add0nadd1;
    wire nadd0nadd1;

    `NOT   inv(nadd0, address0);
    `NOT   inv(nadd1, address1);
    `AND   andgate(add0add1, address0, address1);
    `AND   andgate(nadd0add1, nadd0, address1);
    `AND   andgate(add0nadd1, address0, nadd1);
    `AND   andgate(nadd0nadd1, nadd0, nadd1);

    `AND   andgate(out0, enable, nadd0nadd1);
    `AND   andgate(out1, enable, add0nadd1);
    `AND   andgate(out2, enable, nadd0add1);
    `AND   andgate(out3, enable, add0add1);

endmodule

