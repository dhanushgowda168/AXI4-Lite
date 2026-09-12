`timescale 1ns / 1ps

module axi4lite_assertions(
    axi4lite_if intf
);

    initial begin
        $display("[%0t] ✅ AXI4LITE_ASSERTIONS module is elaborated and running!", $time);
    end

    // Assertion counters
    int pass_count = 0;
    int fail_count = 0;

    //===========================================
    // ASSERTION 1: AWVALID Stability
    //===========================================
    property awvalid_stable;
        @(posedge intf.ACLK) disable iff (!intf.ARESETN)
        (intf.AWVALID && !intf.AWREADY) |=> intf.AWVALID;
    endproperty
    
    assert_awvalid_stable: assert property(awvalid_stable) begin
        pass_count++;
    end else begin
        fail_count++;
        $error("[%0t] ❌ [ASSERTION 1 FAILED] AWVALID deasserted before AWREADY handshake", $time);
    end

    //===========================================
    // ASSERTION 2: AWADDR Stability
    //===========================================
    property awaddr_stable;
        @(posedge intf.ACLK) disable iff (!intf.ARESETN)
        (intf.AWVALID && !intf.AWREADY) |=> $stable(intf.AWADDR);
    endproperty
    
    assert_awaddr_stable: assert property(awaddr_stable) begin
        pass_count++;
    end else begin
        fail_count++;
        $error("[%0t] ❌ [ASSERTION 2 FAILED] AWADDR changed before handshake completed", $time);
    end

    //===========================================
    // ASSERTION 3: WVALID Stability
    //===========================================
    property wvalid_stable;
        @(posedge intf.ACLK) disable iff (!intf.ARESETN)
        (intf.WVALID && !intf.WREADY) |=> intf.WVALID;
    endproperty
    
    assert_wvalid_stable: assert property(wvalid_stable) begin
        pass_count++;
    end else begin
        fail_count++;
        $error("[%0t] ❌ [ASSERTION 3 FAILED] WVALID deasserted before WREADY handshake", $time);
    end

    //===========================================
    // ASSERTION 4: WDATA Stability
    //===========================================
    property wdata_stable;
        @(posedge intf.ACLK) disable iff (!intf.ARESETN)
        (intf.WVALID && !intf.WREADY) |=> $stable(intf.WDATA);
    endproperty
    
    assert_wdata_stable: assert property(wdata_stable) begin
        pass_count++;
    end else begin
        fail_count++;
        $error("[%0t] ❌ [ASSERTION 4 FAILED] WDATA changed before handshake completed", $time);
    end

    //===========================================
    // ASSERTION 5: BVALID Stability
    //===========================================
    property bvalid_stable;
        @(posedge intf.ACLK) disable iff (!intf.ARESETN)
        (intf.BVALID && !intf.BREADY) |=> intf.BVALID;
    endproperty
    
    assert_bvalid_stable: assert property(bvalid_stable) begin
        pass_count++;
    end else begin
        fail_count++;
        $error("[%0t] ❌ [ASSERTION 5 FAILED] BVALID deasserted before BREADY handshake", $time);
    end

    //===========================================
    // ASSERTION 6: BRESP Valid Values
    //===========================================
    property bresp_valid_values;
        @(posedge intf.ACLK) disable iff (!intf.ARESETN)
        intf.BVALID |-> (intf.BRESP inside {2'b00, 2'b01, 2'b10, 2'b11});
    endproperty
    
    assert_bresp_valid: assert property(bresp_valid_values) begin
        pass_count++;
    end else begin
        fail_count++;
        $error("[%0t] ❌ [ASSERTION 6 FAILED] BRESP has invalid value: %b", $time, intf.BRESP);
    end

    //===========================================
    // ASSERTION 7: ARVALID Stability
    //===========================================
    property arvalid_stable;
        @(posedge intf.ACLK) disable iff (!intf.ARESETN)
        (intf.ARVALID && !intf.ARREADY) |=> intf.ARVALID;
    endproperty
    
    assert_arvalid_stable: assert property(arvalid_stable) begin
        pass_count++;
    end else begin
        fail_count++;
        $error("[%0t] ❌ [ASSERTION 7 FAILED] ARVALID deasserted before ARREADY handshake", $time);
    end

    //===========================================
    // ASSERTION 8: ARADDR Stability
    //===========================================
    property araddr_stable;
        @(posedge intf.ACLK) disable iff (!intf.ARESETN)
        (intf.ARVALID && !intf.ARREADY) |=> $stable(intf.ARADDR);
    endproperty
    
    assert_araddr_stable: assert property(araddr_stable) begin
        pass_count++;
    end else begin
        fail_count++;
        $error("[%0t] ❌ [ASSERTION 8 FAILED] ARADDR changed before handshake completed", $time);
    end

    //===========================================
    // ASSERTION 9: RVALID Stability
    //===========================================
    property rvalid_stable;
        @(posedge intf.ACLK) disable iff (!intf.ARESETN)
        (intf.RVALID && !intf.RREADY) |=> intf.RVALID;
    endproperty
    
    assert_rvalid_stable: assert property(rvalid_stable) begin
        pass_count++;
    end else begin
        fail_count++;
        $error("[%0t] ❌ [ASSERTION 9 FAILED] RVALID deasserted before RREADY handshake", $time);
    end

    //===========================================
    // ASSERTION 10: RRESP Valid Values
    //===========================================
    property rresp_valid_values;
        @(posedge intf.ACLK) disable iff (!intf.ARESETN)
        intf.RVALID |-> (intf.RRESP inside {2'b00, 2'b01, 2'b10, 2'b11});
    endproperty
    
    assert_rresp_valid: assert property(rresp_valid_values) begin
        pass_count++;
    end else begin
        fail_count++;
        $error("[%0t] ❌ [ASSERTION 10 FAILED] RRESP has invalid value: %b", $time, intf.RRESP);
    end

    //===========================================
    // FINAL REPORT
    //===========================================
    final begin
        $display("\n");
        $display("# =============================================");
        $display("# AXI4-LITE ASSERTION SUMMARY REPORT");
        $display("# =============================================");
        $display("# Total Assertions Checked: %0d", pass_count + fail_count);
        $display("# Assertions Passed: %0d", pass_count);
        $display("# Assertions Failed: %0d", fail_count);
        $display("# ---------------------------------------------");
        if (fail_count == 0) begin
            $display("# STATUS: ✅ ALL ASSERTIONS PASSED");
        end else begin
            $display("# STATUS: ❌ %0d ASSERTION(S) FAILED", fail_count);
        end
        $display("# =============================================");
        $display("\n");
    end

endmodule
