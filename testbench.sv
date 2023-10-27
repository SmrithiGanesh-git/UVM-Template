

`timescale 1ns/1ns

import uvm_pkg::*;
`include "uvm_macros.svh"



//Include Files- order important, else compile error!

`include "interface.sv"
`include "sequence_item.sv"
`include "sequence.sv"
`include "sequencer.sv"
`include "driver.sv"
`include "monitor.sv"
`include "agent.sv"
`include "scoreboard.sv"
`include "env.sv"
`include "test.sv"


module top;
  
  
  
  

  logic clock;
  //Instantiation of design under test
  alu_interface intf(.clock(clock));
  
  alu dut(
    .clock(intf.clock),
    .reset(intf.reset),
    .A(intf.a),
    .B(intf.b),
    .ALU_Sel(intf.op_code),
    .ALU_Out(intf.result),
    .CarryOut(intf.carry_out)
  );
  
  
 
  //Calling Interface
  
  initial begin
    uvm_config_db #(virtual alu_interface)::set(null, "*", "vif", intf );
  end
  
  
  
  //proceed to test.sv's module
  initial begin
    run_test("alu_test");
  end
  
  
 
  //Clock Generating clock
  
  initial begin
    clock = 0;
    #5;
    forever begin
      clock = ~clock;
      #5;
    end
  end
  
  
 //keeping it to a limited simulation time
  initial begin
    #1000;
    $display("limiting to 1000 cycles!");
    $finish();
  end
  
  
  //to generate output waveforms
  initial begin
    $dumpfile("outputd.vcd");
    $dumpvars();
  end
  
  
  
endmodule: top
