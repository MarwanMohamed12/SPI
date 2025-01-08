package test_pkg;
    import uvm_pkg::*;
        `include "uvm_macros.svh";
    import spi_env_pkg::*;
    import spi_config_obj_pkg::*;
    import ram_config_obj_pkg::*; 
    import Spi_sequence_pkg::*;

    class spi_test extends uvm_test;
        `uvm_component_utils(spi_test);

        spi_env s_env;
        spi_cfg s_cfg;
        ram_cfg r_cfg;
        reset_sequence reset;
        write_sequence writing;
        function new(string name="spi_test",uvm_component parent = null);
            super.new(name,parent);
        endfunction

        function void build_phase(uvm_phase phase);
            super.build_phase(phase);
            s_env=spi_env::type_id::create("spi_env",this);
            s_cfg=spi_cfg::type_id::create("spi_cfg");
            r_cfg=ram_cfg::type_id::create("ram_cfg");
            reset=reset_sequence::type_id::create("reset_seq");
            writing=write_sequence::type_id::create("write_seq");

            if(! uvm_config_db #(virtual spi_if)::get(this,"","SPI_IF",s_cfg.vif))
                `uvm_fatal("build_phase","unable to get spi virtual if");

            if(! uvm_config_db #(virtual ram_if)::get(this,"","RAM_IF",r_cfg.vif))
                `uvm_fatal("build_phase","unable to get ram virtual if");

            s_cfg.is_active=UVM_ACTIVE;
            r_cfg.is_active=UVM_PASSIVE;

            uvm_config_db #(spi_cfg)::set(this,"*","spi_CFG",s_cfg);
            uvm_config_db #(ram_cfg)::set(this,"*","ram_CFG",r_cfg);
        endfunction

        task run_phase(uvm_phase phase);
            super.run_phase(phase);
            phase.raise_objection(this);
                // write seq here 
            reset.start(s_env.spi_agt.spi_sqr);
            //writing.start(s_env.spi_agt.spi_sqr);
            phase.drop_objection(this);

        endtask



    endclass   
endpackage