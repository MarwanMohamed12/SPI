package spi_env_pkg;
    import uvm_pkg::*;
        `include "uvm_macros.svh"
    //import spi_coverage_pkg::*;
    import spi_scoreboard_pkg::*;
    import ram_scoreboard_pkg::*;
    import spi_agent_pkg::*;
    import ram_agent_pkg::*;
  //  import ram_coverage_pkg::*;

    class spi_env extends uvm_env;
        `uvm_component_utils(spi_env);
        //spi_coverage spi_cov;
       // ram_coverage ram_cov;
        ram_agent ram_agt;
        spi_scoreboard spi_sb;
        ram_scoreboard ram_sb;
        spi_agent spi_agt;

        function new(string name ="spi_env",uvm_component parent=null);
            super.new(name,parent);
        endfunction 

        function void build_phase(uvm_phase phase);
            super.build_phase(phase);
           // spi_cov=spi_coverage::type_id::create("spi_coverage",this);
            spi_agt=spi_agent::type_id::create("spi_agent",this);
            spi_sb=spi_scoreboard::type_id::create("spi_scorebored",this);
            ram_sb=ram_scoreboard::type_id::create("ram_scorebored",this);
            //ram_cov=ram_coverage::type_id::create("ram_coverage",this);
            ram_agt=ram_agent::type_id::create("ram_agent",this);
        endfunction

        function void connect_phase(uvm_phase phase);
            super.connect_phase(phase);
            spi_agt.spi_agt_p.connect(spi_sb.spi_sb_ep);
            ram_agt.ram_agt_p.connect(ram_sb.ram_sb_ep);
           // spi_agt.spi_agt_p.connect(spi_cov.spi_cov_ep);
           // ram_agt.ram_agt_p.connect(ram_cov.ram_cov_ep);
        endfunction

    endclass 

    
endpackage