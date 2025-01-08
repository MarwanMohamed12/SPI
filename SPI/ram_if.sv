interface ram_if(clk);
    import shared_para::*;
input bit clk;
logic [ADDR_SIZE+1:0]din;
logic rx_valid,rst_n;
logic  [ADDR_SIZE-1:0]dout;
logic tx_valid;
endinterface //ram_if(input clk)
