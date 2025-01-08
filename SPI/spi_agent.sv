package spi_agent_pkg;
    import uvm_pkg::*;
        `include "uvm_macros.svh"
    import spi_driver_pkg::*;
    import spi_sequencer_pkg::*;
    import spi_monitor_pkg::*;
    import spi_seq_item_pkg::*;
    import spi_config_obj_pkg::*;


    class spi_agent extends uvm_agent;
        `uvm_component_utils(spi_agent);
        spi_monitor spi_mon;
        spi_sequencer spi_sqr;
        spi_driver spi_drv;
        uvm_analysis_port #(spi_seq_item) spi_agt_p;

        spi_cfg cfg;

        uvm_active_passive_enum is_active;


        function new(string name ="spi_agent",uvm_component parent=null);
            super.new(name,parent);
        endfunction 

        function void build_phase(uvm_phase phase);
            super.build_phase(phase);

            spi_mon=spi_monitor::type_id::create("spi_monitor",this);
            spi_agt_p=new("spi_agent_port",this);
            if(!uvm_config_db #(spi_cfg)::get(this,"","spi_CFG",cfg))
                `uvm_fatal("build_phase","cant get spi cfg");
            is_active=cfg.is_active;
            if(is_active==UVM_ACTIVE)begin            
                spi_sqr=spi_sequencer::type_id::create("spi_sequencer",this);
                spi_drv=spi_driver::type_id::create("spi_driver",this);
            end
        endfunction

        function void connect_phase(uvm_phase phase);
            super.connect_phase(phase);
            if(is_active==UVM_ACTIVE)begin            
                spi_drv.vif=cfg.vif;
                spi_drv.seq_item_port.connect(spi_sqr.seq_item_export);
            end
            spi_mon.vif=cfg.vif;
            spi_mon.spi_mon_p.connect(spi_agt_p);
        endfunction


    endclass 

    
endpackage