module slave(MOSI,SS_n,clk,rst_n,tx_valid,tx_data,MISO,rx_valid,rx_data);

input MOSI,SS_n,clk,rst_n,tx_valid;
input [7:0] tx_data;
output reg  MISO,rx_valid;
output reg [9:0]rx_data;

localparam     IDLE = 3'b000,
               CHK_CMD = 3'b001,
               WRITE = 3'b010,
               READ_DATA = 3'b011,
               READ_ADD = 3'b100;
reg [2:0] ns,ps;
reg [9:0] shift_reg;
reg [3:0] counter;
reg address_saved=0;

always @(posedge clk or negedge rst_n) begin
    if(~rst_n)begin
        ps<=IDLE;
    end
    else begin
        ps<=ns;
    end
end

always @(*) begin
    case(ps)
        IDLE:begin
            if(SS_n)begin
                ns=IDLE;
            end
            else if(!SS_n) begin
                ns=CHK_CMD;
            end
        end
        CHK_CMD:begin
            if(!SS_n && ! MOSI)begin
                ns=WRITE;  
            end
            else if (SS_n) begin
                ns=IDLE;
            end
            else if(!SS_n && MOSI && !address_saved)begin
                ns=READ_ADD;
            end
            else if(!SS_n && MOSI && address_saved)begin
                ns=READ_DATA;
            end

        end
        WRITE:begin
            if(!SS_n)begin
                ns=WRITE;
            end
            else if(SS_n) begin
                ns=IDLE;
            end
        end
        READ_DATA:begin
            if(!SS_n)begin
                ns=READ_DATA;
            end
            else if(SS_n) begin
                ns=IDLE;
            end
        end
        READ_ADD:begin
            if(!SS_n)begin
                ns=READ_ADD;
            end
            else if(SS_n) begin
                ns=IDLE;
            end
        end


    endcase
end

always @(posedge clk) begin
    case(ps)
        IDLE:begin
            counter<=0;
            shift_reg<=0;
            rx_valid<=0;
            rx_data<=0;
            MISO<=0;
        end
        /*CHK_CMD:begin
        
            //there is missing state here read data
        end*/
        WRITE:begin
            if(counter<10)begin
                counter<=counter+1;
                shift_reg<={shift_reg[8:0],MOSI};
            end
            else if(counter==10)begin
                rx_data<=shift_reg;
                rx_valid<=1;
            end
        end
        READ_DATA:begin
             if(counter==0)begin
                shift_reg<={shift_reg[8:0],MOSI};
                counter<=counter+1;
            end
            else if(counter==1)begin
                rx_data<={MOSI,shift_reg[0],6'D0};
                rx_valid<=1;
                counter<=counter+1;
            end
            else if(counter>2 && counter<10)begin
                MISO<=tx_data[10-counter];
                counter<=counter+1;
            end
            else if(counter==10)begin
                address_saved<=0;
            end

        end
        READ_ADD:begin
            
             if(counter<10)begin
                counter<=counter+1;
                shift_reg<={shift_reg[8:0],MOSI};
            end
            else if(counter==10)begin
                rx_data<=shift_reg;
                rx_valid<=1;
                address_saved<=1;
            end
        end


    endcase
end





endmodule