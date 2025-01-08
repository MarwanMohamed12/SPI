package ram_config_obj_pkg;
    import uvm_pkg::*;
        `include "uvm_macros.svh"
    class ram_cfg extends uvm_object ;
        `uvm_object_utils(ram_cfg);
        virtual ram_if vif;
        uvm_active_passive_enum is_active;
        
        function new(string name ="ram configurtion object");
            super.new(name);
        endfunction 


    endclass 
endpackage