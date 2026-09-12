class axi4lite_seq_item extends uvm_sequence_item;
  rand bit [31:0] address;
  rand bit [31:0] data;
  rand bit        is_write; // 1 = write, 0 = read

  `uvm_object_utils(axi4lite_seq_item)

  function new(string name = "axi4lite_seq_item");
    super.new(name);
  endfunction

  function string convert2string();
    return $sformatf("ADDR=%0h DATA=%0h WRITE=%0b", address, data, is_write);
  endfunction
endclass
