interface apb_if(input clk);

logic PRESET;
logic [31:0]PADDR;
logic PSEL;
logic PWRITE;
logic [31:0]PWDATA;
logic PENABLE;
logic PREADY;
logic PSLVERR;
logic [31:0]PRDATA;

clocking cb @(posedge clk);
output PRESET,PADDR,PSEL,PWRITE,PWDATA,PENABLE;
input PREADY,PSLVERR,PRDATA;
endclocking

clocking cb_mon@(posedge clk);
input PRESET,PADDR,PSEL,PWRITE,PWDATA,PENABLE;
input PREADY,PSLVERR,PRDATA;

endclocking


modport modport_tb(clocking cb);
modport modport_mon(clocking cb_mon);

endinterface