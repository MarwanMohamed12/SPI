package shared_para;
parameter MEM_DEPTH=256, ADDR_SIZE=8  ;
int error_count,correct_count,counter;
typedef enum {IDLE,CHK_CMD,WRITE,READ_DATA,READ_ADD }state_e;
endpackage