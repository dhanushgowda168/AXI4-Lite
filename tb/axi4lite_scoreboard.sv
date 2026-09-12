`ifndef AXI4LITE_SCOREBOARD_SV
`define AXI4LITE_SCOREBOARD_SV

`include "uvm_macros.svh"
import uvm_pkg::*;

class axi4lite_scoreboard extends uvm_component;
  `uvm_component_utils(axi4lite_scoreboard)

  // ✅ Create analysis export to receive transactions
  uvm_analysis_imp #(axi4lite_seq_item, axi4lite_scoreboard) analysis_export;

  // Expected vs actual comparison storage (optional)
  axi4lite_seq_item exp_queue[$];

  function new(string name = "axi4lite_scoreboard", uvm_component parent = null);
    super.new(name, parent);
    analysis_export = new("analysis_export", this);
  endfunction

  // This is automatically called whenever monitor writes to analysis port
  function void write(axi4lite_seq_item tr);
    `uvm_info("SCOREBOARD", $sformatf("Received transaction: Addr=0x%0h, Data=0x%0h", tr.address, tr.data), UVM_MEDIUM)
    // You can add functional checking or comparison here
  endfunction

endclass

`endif
