package ram_agent_pkg;
    import uvm_pkg::*;
        `include "uvm_macros.svh"
    import ram_driver_pkg::*;
    import ram_sequencer_pkg::*;
    import ram_monitor_pkg::*;
    import ram_seq_item_pkg::*;
    import ram_config_obj_pkg::*;


    class ram_agent extends uvm_agent;
        `uvm_component_utils(ram_agent);
        ram_monitor ram_mon;
        ram_sequencer ram_sqr;
        ram_driver ram_drv;
        uvm_analysis_port #(ram_seq_item) ram_agt_p;

        ram_cfg cfg;

        uvm_active_passive_enum is_active;


        function new(string name ="ram_agent",uvm_component parent=null);
            super.new(name,parent);
        endfunction 

        function void build_phase(uvm_phase phase);
            super.build_phase(phase);

            ram_mon=ram_monitor::type_id::create("ram_monitor",this);
            ram_agt_p=new("ram_agent_port",this);
            if(!uvm_config_db #(ram_cfg)::get(this,"","ram_CFG",cfg))
                `uvm_fatal("build_phase","cant get ram_CFG");
            is_active=cfg.is_active;
            if(is_active==UVM_ACTIVE)begin            
                ram_sqr=ram_sequencer::type_id::create("ram_sequencer",this);
                ram_drv=ram_driver::type_id::create("ram_driver",this);
            end
        endfunction

        function void connect_phase(uvm_phase phase);
            super.connect_phase(phase);
            if(is_active==UVM_ACTIVE)begin            
                ram_drv.vif=cfg.vif;
                ram_drv.seq_item_port.connect(ram_sqr.seq_item_export);
            end
            ram_mon.vif=cfg.vif;
            ram_mon.ram_mon_p.connect(ram_agt_p);
        endfunction


    endclass 

    
endpackage