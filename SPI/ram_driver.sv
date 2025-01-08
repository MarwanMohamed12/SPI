package ram_driver_pkg;
    import uvm_pkg::*;
        `include "uvm_macros.svh"
    import ram_seq_item_pkg::*;


    class ram_driver extends uvm_driver #(ram_seq_item);
        `uvm_component_utils(ram_driver);

        virtual ram_if vif;
        ram_seq_item item;

        function new(string name ="ram driver",uvm_component parent=null);
            super.new(name,parent);
        endfunction 

        task run_phase(uvm_phase phase);
            super.run_phase(phase);
            forever begin
                item=ram_seq_item::type_id::create("seq item");
                seq_item_port.get_next_item(item);



                seq_item_port.item_done();
            end
        endtask

    endclass 

    
endpackage