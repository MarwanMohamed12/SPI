package ram_coverage_pkg;
    import uvm_pkg::*;
        `include "uvm_macros.svh"
    import ram_seq_item_pkg::*;


    class ram_coverage extends uvm_component;
        `uvm_component_utils(ram_coverage);
        
        ram_seq_item item;
        uvm_analysis_export #(ram_seq_item) ram_cov_ep;
        uvm_tlm_analysis_fifo #(ram_seq_item) ram_cov_fifo;

        /*covergroup cvr_gp;

       
        endgroup*/

        function new(string name ="ram coverage",uvm_component parent=null);
            super.new(name,parent);
            //cvr_gp=new();
        endfunction 


        function void build_phase(uvm_phase phase);
            super.build_phase(phase);
            ram_cov_fifo=new("ram fifo",this);
            ram_cov_ep=new("ram coverage export",this);
        endfunction

        function void connect_phase(uvm_phase phase);  
            super.connect_phase(phase);
            ram_cov_ep.connect(ram_cov_fifo.uvm_analysis_export);
        endfunction

        task run_phase(uvm_phase phase);  
            super.run_phase(phase);
            forever begin
                ram_cov_fifo.get(item);
               // cvr_gp.sample();
            end

        endtask


    endclass 

    
endpackage