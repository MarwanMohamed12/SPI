package spi_config_obj_pkg;
    import uvm_pkg::*;
        `include "uvm_macros.svh"
    class spi_cfg extends uvm_object ;
        `uvm_object_utils(spi_cfg);
        virtual spi_if vif;
        uvm_active_passive_enum is_active;
        
        function new(string name ="spi configurtion object");
            super.new(name);
        endfunction 


    endclass 
endpackage