`ifndef AXI4LITE_ENV_SV
`define AXI4LITE_ENV_SV

`include "uvm_macros.svh"
import uvm_pkg::*;

class axi4lite_env extends uvm_env;
  `uvm_component_utils(axi4lite_env)

  axi4lite_agent      agent;
  axi4lite_scoreboard sb;

  function new(string name = "axi4lite_env", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    agent = axi4lite_agent::type_id::create("agent", this);
    sb    = axi4lite_scoreboard::type_id::create("sb", this);
  endfunction

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    // ✅ connect monitor’s analysis port to scoreboard’s export
    agent.mon.ap.connect(sb.analysis_export);
  endfunction

endclass

`endif
