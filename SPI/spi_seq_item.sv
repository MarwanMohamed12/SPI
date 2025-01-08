package spi_seq_item_pkg;
    import uvm_pkg::*;
        `include "uvm_macros.svh"

    class spi_seq_item extends uvm_sequence_item;
        `uvm_object_utils(spi_seq_item);

        
        logic [9:0]rx_data;
        logic rx_valid,MISO;
        rand logic MOSI;
        logic SS_n,rst_n,tx_valid;
        logic [7:0]tx_data;
        function new(string name ="spi_seq_item");
            super.new(name);
        endfunction 
        
        function string convert2string();
            return $sformatf("%s reset= %0b ,SS_n=%0b , MOSI=%0b , MISO=%0b ",super.convert2string,rst_n,SS_n,MOSI,MISO);
        endfunction

        function string convert2string_stimulus();
            return $sformatf("%s reset= %0b ,SS_n=%0b , MOSI=%0b ",super.convert2string,rst_n,SS_n,MOSI);
        endfunction

    endclass

    
endpackage