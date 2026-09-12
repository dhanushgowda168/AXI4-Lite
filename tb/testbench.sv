`timescale 1ns/1ps
`include "uvm_macros.svh"
import uvm_pkg::*;

`include "axi4lite_if.sv"
`include "axi4lite_seq_item.sv"
`include "axi4lite_sequence.sv"
`include "axi4lite_driver.sv"
`include "axi4lite_monitor.sv"
`include "axi4lite_sequencer.sv"
`include "axi4lite_agent.sv"
`include "axi4lite_scoreboard.sv"
`include "axi4lite_env.sv"
`include "axi4lite_test.sv"
`include "axi4lite_assertions.sv"
`include "axi4lite_coverage.sv"


module axi4lite_tb_top;
  logic ACLK;
  logic ARESETN;

  // Instantiate interface
  axi4lite_if axi_if(ACLK, ARESETN);
  
  // Instantiate assertions module (10 assertions)
  axi4lite_assertions axi_asserts(.intf(axi_if));
   
  // Instantiate coverage module (10 covergroups)
  axi4lite_coverage axi_cover(.intf(axi_if));


  // DUT Instance

  
  axi4_lite_top dut (
  .ACLK(ACLK),
  .ARESETN(ARESETN),
  .START_READ(axi_if.START_READ),
  .START_WRITE(axi_if.START_WRITE),
  .address(axi_if.address),
  .data(axi_if.data)
);

// Connect master-slave handshake signals to the interface for assertions
assign axi_if.AWADDR  = dut.master_inst.M_AXI_AWADDR;
assign axi_if.AWVALID = dut.master_inst.M_AXI_AWVALID;
assign axi_if.AWREADY = dut.slave_inst.S_AXI_AWREADY;

assign axi_if.WDATA   = dut.master_inst.M_AXI_WDATA;
assign axi_if.WVALID  = dut.master_inst.M_AXI_WVALID;
assign axi_if.WREADY  = dut.slave_inst.S_AXI_WREADY;
assign axi_if.WSTRB   = dut.master_inst.M_AXI_WSTRB;

assign axi_if.BRESP   = dut.slave_inst.S_AXI_BRESP;
assign axi_if.BVALID  = dut.slave_inst.S_AXI_BVALID;
assign axi_if.BREADY  = dut.master_inst.M_AXI_BREADY;

assign axi_if.ARADDR  = dut.master_inst.M_AXI_ARADDR;
assign axi_if.ARVALID = dut.master_inst.M_AXI_ARVALID;
assign axi_if.ARREADY = dut.slave_inst.S_AXI_ARREADY;

assign axi_if.RDATA   = dut.slave_inst.S_AXI_RDATA;
assign axi_if.RVALID  = dut.slave_inst.S_AXI_RVALID;
assign axi_if.RREADY  = dut.master_inst.M_AXI_RREADY;
assign axi_if.RRESP   = dut.slave_inst.S_AXI_RRESP;
  
  
 initial begin
    $dumpfile("waveform.vcd");
    $dumpvars(0, axi4lite_tb_top);
  end

  // Clock Generation
  initial ACLK = 0;
  always #5 ACLK = ~ACLK;

  // Reset Generation
  initial begin
    ARESETN = 0;
    #20 ARESETN = 1;
  end
 
 // Pass interface to UVM config DB
  initial begin
    uvm_config_db#(virtual axi4lite_if)::set(null, "*", "vif", axi_if);
    run_test("axi4lite_test");
  end
  


  
endmodule
