package spi_scoreboard_pkg;

import uvm_pkg::*;
`include "uvm_macros.svh"
import spi_seq_item_pkg::*;
import shared_para::*;

    class spi_scoreboard extends uvm_scoreboard;
        `uvm_component_utils(spi_scoreboard);
        spi_seq_item spi_item;

        uvm_analysis_export #(spi_seq_item) spi_sb_ep;
        uvm_tlm_analysis_fifo #(spi_seq_item) spi_sb_fifo;

        // here we define needed varibles for scoreboard
        logic MISO_exp,rx_valid_exp;
        logic  [9:0] rx_data_exp;

        logic [9:0]shift_reg;
        int count;
        static state_e ps;
        function new(string name = "ram scoreboard", uvm_component parent =null);
            super.new(name,parent);
        endfunction

        function void build_phase(uvm_phase phase);
            super.build_phase(phase);
            spi_sb_ep=new("ram_sb_export",this);
            spi_sb_fifo=new("ram_sb_fifo",this);
        endfunction

        function void connect_phase(uvm_phase phase);  
            super.connect_phase(phase);
            spi_sb_ep.connect(spi_sb_fifo.analysis_export);
        endfunction

        task run_phase(uvm_phase phase);
            super.run_phase(phase);
            forever begin
                spi_sb_fifo.get(spi_item);
                update_state(spi_item);
                if(spi_item.rx_data != rx_data_exp ||spi_item.rx_valid != rx_valid_exp ||
                    spi_item.MISO != MISO_exp)begin
                    `uvm_error("run_phase",spi_item.convert2string());
                    error_count ++;
                end 
                else begin
                    correct_count++;
                end
            end
        endtask

        
        function void update_state(spi_seq_item tr);
            static bit read_address_done; 
            if(!tr.rst_n)begin
                ps=IDLE;
            end
            else begin
                case (ps)
                IDLE:begin
                    counter=0;
                    if(!tr.SS_n)
                        ps=CHK_CMD;
                    else if(tr.SS_n)
                        ps=IDLE;
                end
                CHK_CMD:begin
                    if(!tr.SS_n && !tr.MOSI)
                        ps=WRITE;
                    else if(tr.SS_n)
                        ps=IDLE;
                    else if(!tr.SS_n && tr.MOSI && !read_address_done)
                        ps=READ_ADD;
                    else if(!tr.SS_n && tr.MOSI && read_address_done)
                        ps=READ_DATA;    
                end
                WRITE:begin
                    if(tr.SS_n)begin
                        ps=IDLE;

                    end
                    else if (! tr.SS_n && count <10) begin
                        ps=WRITE;
                        counter++;
                    end

                end
                READ_DATA:begin
                    if(tr.SS_n)begin
                        ps=IDLE;
                    end
                    else if(!tr.SS_n && counter <10)begin
                        ps=READ_DATA;
                        counter++;
                    end
                    else if(counter == 10)begin
                        read_address_done=0;
                    end
                end
                READ_ADD:begin
                    if(tr.SS_n)begin
                        ps=IDLE;
                    end
                    else if(!tr.SS_n && counter <10)begin
                        ps=READ_DATA;
                        counter++;
                    end
                    else if(counter == 10)begin
                        read_address_done=1;
                    end
                end
                endcase
            end
        endfunction

        function void update_output(spi_seq_item tr);
            if(!tr.rst_n)begin
                rx_data_exp=0;
                rx_valid_exp=0;
                MISO_exp=0;
            end
            else begin
            case (ps)
                WRITE:begin
                    if(counter<10)begin
                        shift_reg={shift_reg[8:0],tr.MOSI};
                    end
                    else if (counter == 10)begin
                        rx_data_exp=shift_reg;
                        rx_valid_exp=1;
                    end
                end
                READ_DATA:begin
                    if(counter<=2)begin
                        shift_reg={shift_reg[8:0],tr.MOSI};
                        if(counter == 2)begin
                            rx_data_exp=shift_reg;
                            rx_valid_exp=1;
                        end
                    end
                    else if (counter < 10 && counter >2 && tr.tx_valid)begin
                        MISO_exp=tr.tx_data[10-counter];
                        
                    end
                end
                READ_ADD:begin
                    if(counter<10)begin
                        shift_reg={shift_reg[8:0],tr.MOSI};
                    end
                    else if (counter == 10)begin
                        rx_data_exp=shift_reg;
                        rx_valid_exp=1;
                    end
                end
            endcase
            end 
        endfunction
        /*function void report_phase (uvm_phase phase);
            super.report_phase(phase);
            `uvm_info("report_phase",$sformatf("cases passed %0d,failed cases %0d",correct,error),UVM_MEDIUM);
        endfunction */
    endclass

endpackage