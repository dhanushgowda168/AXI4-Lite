`ifndef AXI4LITE_MONITOR_SV
`define AXI4LITE_MONITOR_SV

`include "uvm_macros.svh"
import uvm_pkg::*;

class axi4lite_monitor extends uvm_component;
  `uvm_component_utils(axi4lite_monitor)

  // Virtual interface handle
  virtual axi4lite_if vif;

  // Analysis port to send observed transactions
  uvm_analysis_port #(axi4lite_seq_item) ap;

  function new(string name = "axi4lite_monitor", uvm_component parent = null);
    super.new(name, parent);
    ap = new("ap", this);
  endfunction

  // Get the virtual interface from config DB
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db#(virtual axi4lite_if)::get(this, "", "vif", vif)) begin
      `uvm_fatal("NOVIF", "Virtual interface not set for monitor (uvm_config_db get failed).")
    end
  endfunction

  task run_phase(uvm_phase phase);
    axi4lite_seq_item tr;
    // Wait for reset release
    @(posedge vif.ACLK);
    wait (vif.ARESETN == 1);

    forever begin
      @(posedge vif.ACLK);

      // Only forward meaningful samples (you can refine this to detect valid handshakes)
      tr = axi4lite_seq_item::type_id::create("tr", this);
      tr.address = vif.address;
      tr.data    = vif.data;
      // infer is_write from START signals (might be pulsed)
      tr.is_write = vif.START_WRITE;

      ap.write(tr);
    end
  endtask

endclass

`endif
