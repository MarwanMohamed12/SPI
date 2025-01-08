package ram_sequencer_pkg;

import uvm_pkg::*;
`include "uvm_macros.svh"
    import ram_seq_item_pkg::*;
    class ram_sequencer extends uvm_sequencer #(ram_seq_item);
        `uvm_component_utils(ram_sequencer);

        function new(string name="ram_sequencer",uvm_component phase);
            super.new(name,phase);
        endfunction
    endclass


endpackage