class axi4lite_sequence extends uvm_sequence #(axi4lite_seq_item);
  `uvm_object_utils(axi4lite_sequence)

  function new(string name = "axi4lite_sequence");
    super.new(name);
  endfunction

  task body();
    axi4lite_seq_item tr;

    // Number of random transactions you want to generate
    int unsigned num_transactions = 10;

    for (int unsigned i = 0; i < num_transactions; i++) begin
      tr = axi4lite_seq_item::type_id::create("tr");
      wait_for_grant();

      // Use randomize() to randomize all rand fields in req
      if (!tr.randomize()) begin
        `uvm_error("SEQ", "Randomization failed for tr")
      end
      send_request(tr);
      wait_for_item_done();

      start_item(tr);
      finish_item(tr);
    end
  endtask
endclass
