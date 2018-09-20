// Multiplexer circuit
`define AND and #50
`define OR or #50
`define XOR xor #50
`define NOT not #50

module behavioralMultiplexer
(
    output out,
    input address0, address1,
    input in0, in1, in2, in3
);
    // Join single-bit inputs into a bus, use address as index
    wire[3:0] inputs = {in3, in2, in1, in0};
    wire[1:0] address = {address1, address0};
    assign out = inputs[address];
endmodule


module structuralMultiplexer
(
    output out,
    input address0, address1,
    input in0, in1, in2, in3
);

    wire nadd0;
    wire nadd1;
    wire add0add1;
    wire nadd0add1;
    wire add0nadd1;
    wire nadd0nadd1;

    wire add0add13;
    wire nadd0add12;
    wire add0nadd11;
    wire nadd0nadd10;

    wire in3orin2;
    wire in1orin0;

    `NOT  inv(nadd0, address0);
    `NOT  inv(nadd1, address1);
    `AND  andgate(add0add1, address0, address1);
    `AND  andgate(nadd0add1, nadd0, address1);
    `AND  andgate(add0nadd1, address0, nadd1);
    `AND  andgate(nadd0nadd1, nadd0, nadd1);

    `AND  andgate(add0add13, add0add1, in3);
    `AND  andgate(nadd0add12, nadd0add1, in2);
    `AND  andgate(add0nadd11, add0nadd1, in1);
    `AND  andgate(nadd0nadd10, nadd0nadd1, in0);

    `OR   orgate(in3orin2, add0add13, nadd0add12);
    `OR   orgate(in1orin0, add0nadd11, nadd0nadd10);
    `OR   orgate(out, in3orin2, in1orin0);
endmodule

