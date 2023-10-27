

/* 
This is the place holder for design under test
ALU Arithmetic and Logic Operations

|ALU_Sel|   ALU Operation

0  |   ALU_Out = A + B;

1  |   ALU_Out = A & B;

2  |   ALU_Out = A * B;

3  |   ALU_Out = !A;

*/


module alu(
  input clock,
  input reset,
  input [7:0] A,B,  // ALU 8-bit Inputs                 
  input [3:0] ALU_Sel,// ALU Selection
  output reg [7:0] ALU_Out, // ALU 8-bit Output
  output bit CarryOut // Carry Out Flag
);

  reg [7:0] ALU_Result;
  wire [8:0] tmp;

  assign tmp = {1'b0,A} + {1'b0,B};

  
  always @(posedge clock or posedge reset) begin
    if(reset) begin
      ALU_Out  <= 8'd0;
      CarryOut <= 1'd0;
    end
    else begin
      ALU_Out <= ALU_Result;
      CarryOut <= tmp[8];
    end
  end


  always @(*) 
    begin
      case(ALU_Sel)
        4'b0000: // Addition
          ALU_Result = A + B ; 
        4'b0001: // A and B
          ALU_Result = A & B ;
        4'b0010: // Multiplication
          ALU_Result = A * B;
        4'b0011: // not A
          ALU_Result = !A;
        default: ALU_Result = 8'hff ; // keeping ff as default output
      endcase
    end

endmodule
