interface axi4lite_if(input logic ACLK, input logic ARESETN);

  //==============================
  // Control Inputs
  //==============================
  logic START_READ;
  logic START_WRITE;
  logic [31:0] address;
  logic [31:0] data;

  //==============================
  // AXI4-Lite Master Interface Signals
  //==============================

  // Read Address Channel
  logic [31:0] ARADDR;
  logic        ARVALID;
  logic        ARREADY;

  // Read Data Channel
  logic [31:0] RDATA;
  logic [1:0]  RRESP;
  logic        RVALID;
  logic        RREADY;

  // Write Address Channel
  logic [31:0] AWADDR;
  logic        AWVALID;
  logic        AWREADY;

  // Write Data Channel
  logic [31:0] WDATA;
  logic [3:0]  WSTRB;
  logic        WVALID;
  logic        WREADY;

  // Write Response Channel
  logic [1:0]  BRESP;
  logic        BVALID;
  logic        BREADY;



endinterface
