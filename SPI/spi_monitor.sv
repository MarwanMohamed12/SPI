package spi_monitor_pkg;
    import uvm_pkg::*;
        `include "uvm_macros.svh"
    import spi_seq_item_pkg::*;    

    class spi_monitor extends uvm_monitor ;
        `uvm_component_utils(spi_monitor);
        spi_seq_item item;
        virtual spi_if vif;
        uvm_analysis_port #(spi_seq_item) spi_mon_p;

        function new(string name ="spi_monitor",uvm_component parent=null);
            super.new(name,parent);
        endfunction 

        function void build_phase(uvm_phase phase);
            super.build_phase(phase);
            spi_mon_p=new("spi monitor port",this);
        endfunction

        task run_phase(uvm_phase phase);
            super.run_phase(phase);
            forever begin
                // create new itwe
                item=spi_seq_item::type_id::create("item received");
                @(negedge vif.clk);

                item.rst_n=vif.rst_n;
                item.SS_n=vif.SS_n;
                item.MISO=vif.MISO;
                item.MOSI=vif.MOSI;
                item.rx_data=vif.rx_data;
                item.rx_valid=vif.rx_valid;
                item.tx_data=vif.tx_valid;
                item.tx_valid=vif.tx_valid;
                
                spi_mon_p.write(item);
                `uvm_info("run_phase",item.convert2string(),UVM_HIGH);
            end
        endtask
    endclass 
endpackage