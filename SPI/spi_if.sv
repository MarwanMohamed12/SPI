interface spi_if(clk);
    import shared_para::*;
    input bit clk;
logic MOSI,SS_n,rst_n,tx_valid;
logic [7:0] tx_data;
logic  MISO,rx_valid;
logic [9:0]rx_data;
endinterface //ram_if(input clk)
