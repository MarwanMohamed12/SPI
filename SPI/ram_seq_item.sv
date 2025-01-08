
package ram_seq_item_pkg;
    import uvm_pkg::*;
    `include "uvm_macros.svh"
    import shared_para::*;

    class ram_seq_item extends uvm_sequence_item ;
        `uvm_object_utils(ram_seq_item);

        function new(string name = "ram_seq_item");
            super.new(name);
        endfunction

        rand logic [ADDR_SIZE+1:0]din;
        rand logic rx_valid,rst_n;
        logic  [ADDR_SIZE-1:0]dout;
        logic tx_valid;

        function string convert2string();
            return $sformatf("%s  reset =%0b rx_valid=%0b ,din=%0b ,dout=%0b ,tx_valid=%0b ",
            super.convert2string(),rst_n,rx_valid,din,dout,tx_valid);            
        endfunction

        function string convert2string_stimulus();
            return $sformatf("%s  reset =%0b rx_valid=%0b ,din=%0b ",
            super.convert2string(),rst_n,rx_valid,din);  
        endfunction

    

    endclass
endpackage
