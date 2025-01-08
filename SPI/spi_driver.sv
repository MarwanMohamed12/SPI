package spi_driver_pkg;
    import uvm_pkg::*;
        `include "uvm_macros.svh"
    import spi_seq_item_pkg::*;


    class spi_driver extends uvm_driver #(spi_seq_item);
        `uvm_component_utils(spi_driver);

        virtual spi_if vif;
        spi_seq_item item;

        function new(string name ="driver",uvm_component parent=null);
            super.new(name,parent);
        endfunction 

        task run_phase(uvm_phase phase);
            super.run_phase(phase);
            forever begin
                item=spi_seq_item::type_id::create("seq item");
                seq_item_port.get_next_item(item);
                vif.MOSI=item.MOSI;
                vif.SS_n=item.SS_n;
                vif.rst_n=item.rst_n;
                @(negedge vif.clk);
                seq_item_port.item_done();

            end
        endtask

    endclass 

    
endpackage