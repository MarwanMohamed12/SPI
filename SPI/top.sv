
//--------------------------//
import uvm_pkg::*;
    `include "uvm_macros.svh";
import test_pkg::*;

module top ();

bit clk;
always #5 clk=!clk;

spi_if ifs(clk);
spi_master SPM(ifs.clk,ifs.rst_n,ifs.MOSI,ifs.MISO,ifs.SS_n);
ram_if ifr(clk);
RAM RM(ifr.din,ifr.rx_valid,ifr.clk,ifr.rst_n,ifr.dout,ifr.tx_valid);

initial begin
    uvm_config_db #(virtual spi_if)::set(null,"*","SPI_IF",ifs);
    uvm_config_db #(virtual ram_if)::set(null,"*","RAM_IF",ifr);
    run_test("spi_test");
end


endmodule