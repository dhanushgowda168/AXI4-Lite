`ifndef AXI4LITE_AGENT_SV
`define AXI4LITE_AGENT_SV

`include "uvm_macros.svh"
import uvm_pkg::*;

//---------------------------------------------
// AXI4-Lite Agent
//---------------------------------------------
class axi4lite_agent extends uvm_agent;
  `uvm_component_utils(axi4lite_agent)

  // Agent subcomponents
  axi4lite_driver    drv;
  axi4lite_monitor   mon;
  axi4lite_sequencer seqr;

  // Virtual interface handle
  virtual axi4lite_if vif;


  // Constructor
  function new(string name = "axi4lite_agent", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  //---------------------------------------------
  // Build phase
  //---------------------------------------------
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    // Create monitor always (passive)
    mon = axi4lite_monitor::type_id::create("mon", this);

    // Create driver and sequencer only if ACTIVE
    if (get_is_active() == UVM_ACTIVE) begin
      drv  = axi4lite_driver::type_id::create("drv", this);
      seqr = axi4lite_sequencer::type_id::create("seqr", this);
    end
  endfunction

  //---------------------------------------------
  // Connect phase
  //---------------------------------------------
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);


    // Connect sequencer and driver if active
    if (get_is_active() == UVM_ACTIVE) begin
      drv.seq_item_port.connect(seqr.seq_item_export);
    end
  endfunction

endclass

`endif
