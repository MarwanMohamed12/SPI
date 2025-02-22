package spi_sequencer_pkg;
    import uvm_pkg::*;
        `include "uvm_macros.svh"
    import spi_seq_item_pkg::*;

    class spi_sequencer extends uvm_sequencer #(spi_seq_item);
        `uvm_component_utils(spi_sequencer);

        function new(string name ="spi_sequencer",uvm_component parent=null);
            super.new(name,parent);
        endfunction 
    endclass 
endpackage