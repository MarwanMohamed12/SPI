package ram_monitor_pkg;
    import uvm_pkg::*;
        `include "uvm_macros.svh"
    import ram_seq_item_pkg::*;    

    class ram_monitor extends uvm_monitor ;
        `uvm_component_utils(ram_monitor);
        ram_seq_item item;
        virtual ram_if vif;
        uvm_analysis_port #(ram_seq_item) ram_mon_p;

        function new(string name ="ram_monitor",uvm_component parent=null);
            super.new(name,parent);
        endfunction 

        function void build_phase(uvm_phase phase);
            super.build_phase(phase);
            ram_mon_p=new("ram monitor port",this);
        endfunction

        task run_phase(uvm_phase phase);
            super.run_phase(phase);
            forever begin
                // create new itwe
                item=ram_seq_item::type_id::create("item received");
                item.din=vif.din;
                item.rx_valid=vif.rx_valid;
                item.rst_n=vif.rst_n;
                item.dout=vif.dout;
                item.tx_valid=vif.tx_valid;

                ram_mon_p.write(item);
                `uvm_info("run_phase",item.convert2string(),UVM_HIGH);
            end
        endtask
    endclass 
endpackage
