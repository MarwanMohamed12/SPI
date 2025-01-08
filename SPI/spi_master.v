module spi_master(clk,rst_n,MOSI,MISO,SS_n);

input clk,rst_n,SS_n,MOSI;
output MISO;

wire [9:0] RX_DATA;
wire RX_VALID,TX_VALID;
wire [7:0]TX_DATA;

RAM RM(RX_DATA,RX_VALID,clk,rst_n,TX_DATA,TX_VALID);
slave SV (MOSI,SS_n,clk,rst_n,TX_VALID,TX_DATA,MISO,RX_VALID,RX_DATA);


endmodule