package ram_scoreboard_pkg;

import uvm_pkg::*;
`include "uvm_macros.svh"
import ram_seq_item_pkg::*;
import shared_para::*;

    class ram_scoreboard extends uvm_scoreboard;
        `uvm_component_utils(ram_scoreboard);
        ram_seq_item ram_item;

        uvm_analysis_export #(ram_seq_item) ram_sb_ep;
        uvm_tlm_analysis_fifo #(ram_seq_item) ram_sb_fifo;

        // here we define needed varibles for scoreboard
        logic tx_valid_exp;
        logic  [7:0] dout_exp;

        logic [ ADDR_SIZE-1 : 0] memory_ram [0 : MEM_DEPTH-1];
        logic [ADDR_SIZE-1:0]    write_add,read_add;

        function new(string name = "ram scoreboard", uvm_component parent =null);
            super.new(name,parent);
        endfunction

        function void build_phase(uvm_phase phase);
            super.build_phase(phase);
            ram_sb_ep=new("ram_sb_export",this);
            ram_sb_fifo=new("ram_sb_fifo",this);
        endfunction

        function void connect_phase(uvm_phase phase);  
            super.connect_phase(phase);
            ram_sb_ep.connect(ram_sb_fifo.analysis_export);
        endfunction

        task run_phase(uvm_phase phase);
            super.run_phase(phase);
            forever begin
                ram_sb_fifo.get(ram_item);
                update_memory(ram_item);
                if(tx_valid_exp != ram_item.tx_valid || dout_exp != ram_item.dout)begin
                    `uvm_error("run_phase",ram_item.convert2string());
                    error_count ++;
                end
                else begin
                    correct_count++;
                end
            end
        endtask

        
        function void update_memory(ram_seq_item tr);
            if(~tr.rst_n)begin
                dout_exp=0;
                tx_valid_exp=0;
            end
            else begin
                if(tr.rx_valid)begin
                    if(tr.din[9:8]==2'b00 || tr.din[9:8]==2'b10)begin
                        write_add=tr.din[7:0];
                    end
                    else if(tr.din[9:8]==2'b01)begin
                        memory_ram[write_add] = tr.din[7:0];
                    end
                    else if(tr.din[9:8]==2'b10)begin
                        read_add = tr.din[7:0];
                    end
                end
                else if(tr.din[9:8]==2'b11)begin
                    tx_valid_exp=1;
                    dout_exp=memory_ram[read_add];
                end
                else
                    tx_valid_exp=0;
            end
            
        endfunction
       

        /*function void report_phase (uvm_phase phase);
            super.report_phase(phase);
            `uvm_info("report_phase",$sformatf("cases passed %0d,failed cases %0d",correct,error),UVM_MEDIUM);
        endfunction */


    endclass





endpackage