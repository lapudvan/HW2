// Adder circuit
// define gates with delays
`define AND and #50
`define OR or #50
`define XOR xor #50
`define NOT not #50

module behavioralFullAdder
(
    output sum, 
    output carryout,
    input a, 
    input b, 
    input carryin
);
    // Uses concatenation operator and built-in '+'
    assign {carryout, sum}=a+b+carryin;
endmodule

module structuralFullAdder
(
    output sum, 
    output carryout,
    input a, 
    input b, 
    input carryin
);

    wire xAorB;
    wire AandB;
    wire xAorBandCin;

    `XOR  xorgate(xAorB, a, b);   // OR gate produces AorB from A and B
    `XOR  xorgate(sum, xAorB, carryin);
    `AND  andgate(AandB, a, b);
    `AND  andgate(xAorBandCin, xAorB, carryin);
    `OR   orgate(carryout, AandB, xAorBandCin);
    
endmodule
