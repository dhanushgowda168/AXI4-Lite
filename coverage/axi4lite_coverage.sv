`timescale 1ns/1ps
`ifndef AXI4LITE_COVERAGE_SV
`define AXI4LITE_COVERAGE_SV

module axi4lite_coverage (axi4lite_if intf);

  // ======================================================
  // COVERGROUP DEFINITIONS (Auto-sampled on posedge ACLK)
  // ======================================================

  // -------------------- Write Address -------------------
  covergroup cg_write_address @(posedge intf.ACLK);
    cp_awvalid: coverpoint intf.AWVALID;
    cp_awready: coverpoint intf.AWREADY;
    cx_aw_handshake: cross intf.AWVALID, intf.AWREADY;
  endgroup

  // -------------------- Write Data -----------------------
  covergroup cg_write_data @(posedge intf.ACLK);
    cp_wvalid: coverpoint intf.WVALID;
    cp_wready: coverpoint intf.WREADY;
    cx_w_handshake: cross intf.WVALID, intf.WREADY;
  endgroup

  // -------------------- Write Response -------------------
  covergroup cg_write_response @(posedge intf.ACLK);
    cp_bvalid: coverpoint intf.BVALID;
    cp_bready: coverpoint intf.BREADY;
    cp_bresp: coverpoint intf.BRESP {
      bins okay    = {2'b00};
      bins exokay  = {2'b01};
      bins slverr  = {2'b10};
      bins decerr  = {2'b11};
    }
    cx_b_handshake: cross intf.BVALID, intf.BREADY;
  endgroup

  // -------------------- Read Address ---------------------
  covergroup cg_read_address @(posedge intf.ACLK);
    cp_arvalid: coverpoint intf.ARVALID;
    cp_arready: coverpoint intf.ARREADY;
    cx_ar_handshake: cross intf.ARVALID, intf.ARREADY;
  endgroup

  // -------------------- Read Data ------------------------
  covergroup cg_read_data @(posedge intf.ACLK);
    cp_rvalid: coverpoint intf.RVALID;
    cp_rready: coverpoint intf.RREADY;
    cp_rresp: coverpoint intf.RRESP {
      bins okay    = {2'b00};
      bins exokay  = {2'b01};
      bins slverr  = {2'b10};
      bins decerr  = {2'b11};
    }
    cx_r_handshake: cross intf.RVALID, intf.RREADY;
  endgroup

  // ======================================================
  // INSTANTIATION
  // ======================================================
  cg_write_address   write_addr_cg   = new();
  cg_write_data      write_data_cg   = new();
  cg_write_response  write_resp_cg   = new();
  cg_read_address    read_addr_cg    = new();
  cg_read_data       read_data_cg    = new();

  // ======================================================
  // FUNCTIONAL COVERAGE REPORT (DISPLAY + FILE)
  // ======================================================
  final begin
    integer f;
    real total_cov;

    total_cov = (
      write_addr_cg.get_coverage() +
      write_data_cg.get_coverage() +
      write_resp_cg.get_coverage() +
      read_addr_cg.get_coverage() +
      read_data_cg.get_coverage()
    ) / 5.0;

    f = $fopen("coverage_report.txt", "w");

    $display("========================================");
    $display("AXI4-Lite FUNCTIONAL COVERAGE SUMMARY");
    $display("========================================");
    $display("Write Address Coverage  = %0.2f%%", write_addr_cg.get_coverage());
    $display("Write Data Coverage     = %0.2f%%", write_data_cg.get_coverage());
    $display("Write Response Coverage = %0.2f%%", write_resp_cg.get_coverage());
    $display("Read Address Coverage   = %0.2f%%", read_addr_cg.get_coverage());
    $display("Read Data Coverage      = %0.2f%%", read_data_cg.get_coverage());
    $display("----------------------------------------");
    $display("TOTAL AXI4-Lite Coverage = %0.2f%%", total_cov);
    $display("========================================");

    $fwrite(f, "========================================\n");
    $fwrite(f, "AXI4-Lite FUNCTIONAL COVERAGE SUMMARY\n");
    $fwrite(f, "========================================\n");
    $fwrite(f, "Write Address Coverage  = %0.2f%%\n", write_addr_cg.get_coverage());
    $fwrite(f, "Write Data Coverage     = %0.2f%%\n", write_data_cg.get_coverage());
    $fwrite(f, "Write Response Coverage = %0.2f%%\n", write_resp_cg.get_coverage());
    $fwrite(f, "Read Address Coverage   = %0.2f%%\n", read_addr_cg.get_coverage());
    $fwrite(f, "Read Data Coverage      = %0.2f%%\n", read_data_cg.get_coverage());
    $fwrite(f, "----------------------------------------\n");
    $fwrite(f, "TOTAL AXI4-Lite Coverage = %0.2f%%\n", total_cov);
    $fwrite(f, "========================================\n");

    $fclose(f);
  end

endmodule

`endif
