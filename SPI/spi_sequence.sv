package Spi_sequence_pkg;
    import uvm_pkg::*;
        `include "uvm_macros.svh"
    import spi_seq_item_pkg::*;

    class reset_sequence extends uvm_sequence #(spi_seq_item);
        `uvm_object_utils(reset_sequence);

        function new(string name ="reset_sequence");
            super.new(name);
        endfunction 

        task body();
            spi_seq_item item;
            item=spi_seq_item::type_id::create("sequence_reset");
            start_item(item);
            item.rst_n=0;
            finish_item(item);
        endtask
    endclass 

    class write_sequence extends uvm_sequence #(spi_seq_item);
        `uvm_object_utils(write_sequence);

        function new(string name ="write_sequence",uvm_component parent=null);
            super.new(name);
        endfunction 

        task body();
            
            repeat(2)begin
                spi_seq_item item1;
                item1=spi_seq_item::type_id::create("seq_item1");
                start_item(item1);
                item1.rst_n=1;
                item1.SS_n=0;
                item1.MOSI=0;
                finish_item(item1);
            end
            repeat(8)begin
                spi_seq_item item2;
                item2=spi_seq_item::type_id::create("seq_item2");
                start_item(item2);
                item2.rst_n=1;
                item2.SS_n=0;
                item2.MOSI=0;
                finish_item(item2);
            end
            /*spi_seq_item item3;
            item3=spi_seq_item::type_id::create("seq_item3");
            start_item(item3);
                item3.MOSI=1;
            finish_item(item3);*/
        endtask
    endclass 

        /*class second_sequence extends uvm_sequence #(seq_item);
        `uvm_object_utils(second_sequence);

        function new(string name ="second_sequence",uvm_component parent=null);
            super.new(name);
        endfunction 

        task body();

            for(int i=0;i<5000;i++)begin
            seq_item item;
            item=seq_item::type_id::create("seq_item");
            item.constraint_mode(0);
            item.y.constraint_mode(1);
            //start_item(item);
            item.rst=0;item.bypass_A=0;item.bypass_B=0;item.red_op_A=0;item.red_op_B=0;
            item.rst.rand_mode(0);item.bypass_A.rand_mode(0);item.bypass_B.rand_mode(0);item.red_op_A.rand_mode(0);
            item.red_op_B.rand_mode(0);          
            assert(item.randomize());
            //if('{OR,XOR,ADD,MULT,SHIFT,ROTATE} ==item.arr)$display("@%0t the wanted sequence is %p",$time,tr.arr);
                foreach(item.arr[j])begin
                    start_item(item);
                    item.opcode=item.arr[j];
                    finish_item(item);
                end
            end
            
        endtask
    endclass */

    
endpackage