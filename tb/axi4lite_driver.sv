`ifndef AXI4LITE_DRIVER_SV
`define AXI4LITE_DRIVER_SV

`include "uvm_macros.svh"
import uvm_pkg::*;

class axi4lite_driver extends uvm_driver #(axi4lite_seq_item);
  `uvm_component_utils(axi4lite_driver)

  // Virtual interface handle
  virtual axi4lite_if vif;

  function new(string name = "axi4lite_driver", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  // Get the virtual interface from config DB
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db#(virtual axi4lite_if)::get(this, "", "vif", vif)) begin
      `uvm_fatal("NOVIF", "Virtual interface not set for driver (uvm_config_db get failed).")
    end
  endfunction

  // Drive transactions to DUT
  task run_phase(uvm_phase phase);
    axi4lite_seq_item tr;
    // Wait until reset is deasserted
    @(posedge vif.ACLK);
    wait (vif.ARESETN == 1);

    forever begin
      seq_item_port.get_next_item(tr);

      // drive address/data onto interface
      vif.address <= tr.address;
      vif.data    <= tr.data;

      // pulse START_WRITE or START_READ for one clock cycle
      if (tr.is_write) begin
        vif.START_WRITE <= 1;
        vif.START_READ  <= 0;
      end else begin
        vif.START_WRITE <= 0;
        vif.START_READ  <= 1;
      end

      // wait one clock and deassert starts
      @(posedge vif.ACLK);
      vif.START_WRITE <= 0;
      vif.START_READ  <= 0;

      // let sequence know we're done
      seq_item_port.item_done();
    end
  endtask

endclass

`endif
