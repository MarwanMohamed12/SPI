package spi_coverage_pkg;
    import uvm_pkg::*;
        `include "uvm_macros.svh"
    import spi_seq_item_pkg::*;


    class spi_coverage extends uvm_component;
        `uvm_component_utils(spi_coverage);
        
        spi_seq_item item;
        uvm_analysis_export #(spi_seq_item) spi_cov_ep;
        uvm_tlm_analysis_fifo #(spi_seq_item) spi_cov_fifo;

        /*covergroup cvr_gp;

       
        endgroup*/

        function new(string name ="SPI coverage",uvm_component parent=null);
            super.new(name,parent);
            //cvr_gp=new();
        endfunction 


        function void build_phase(uvm_phase phase);
            super.build_phase(phase);
            spi_cov_fifo=new("spi fifo",this);
            spi_cov_ep=new("spi coverage export",this);
        endfunction

        function void connect_phase(uvm_phase phase);  
            super.connect_phase(phase);
            spi_cov_ep.connect(spi_cov_fifo.uvm_analysis_export);
        endfunction

        task run_phase(uvm_phase phase);  
            super.run_phase(phase);
            forever begin
                spi_cov_fifo.get(item);
               // cvr_gp.sample();
            end

        endtask


    endclass 

    
endpackage