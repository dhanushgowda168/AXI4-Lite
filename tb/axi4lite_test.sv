`ifndef AXI4LITE_TEST_SV
`define AXI4LITE_TEST_SV

`include "uvm_macros.svh"
import uvm_pkg::*;

class axi4lite_test extends uvm_test;
  `uvm_component_utils(axi4lite_test)

  axi4lite_env env;
  axi4lite_sequence seq;

  function new(string name = "axi4lite_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env = axi4lite_env::type_id::create("env", this);
  endfunction

  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    seq = axi4lite_sequence::type_id::create("seq");
    seq.start(env.agent.seqr);

    #50;
    phase.drop_objection(this);
  endtask

endclass

`endif
