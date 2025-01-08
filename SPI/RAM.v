module RAM #(parameter MEM_DEPTH=256, ADDR_SIZE=8)(din,rx_valid,clk,rst_n,dout,tx_valid);

input [ADDR_SIZE+1:0]din;
input rx_valid,clk,rst_n;
output reg [ADDR_SIZE-1:0]dout;
output reg tx_valid;


reg [ADDR_SIZE-1:  0] RAM_x[0 : MEM_DEPTH-1];
reg [ADDR_SIZE-1:0] we_addr,rd_addr;

always @(posedge clk or negedge rst_n) begin
    if(~ rst_n)begin
        we_addr<='b0;
        rd_addr<='b0;
        dout<='b0;
        tx_valid<=0;
    end
    else begin
        if(rx_valid)begin
            if(din[9:8]==2'b00 || din[9:8]==2'b10)begin
                we_addr<=din[7:0];
            end
            else if(din[9:8]==2'b01)begin
                RAM_x[we_addr] <= din[7:0];
            end
            else if(din[9:8]==2'b10)begin
                rd_addr <= din[7:0];
            end
        end
        else if(din[9:8]==2'b11)begin
            tx_valid<=1;
            dout<=RAM_x[rd_addr];
        end
        else
            tx_valid<=0;
    end
    
end

    
endmodule