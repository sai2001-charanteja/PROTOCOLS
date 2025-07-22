class packet;

rand bit [31:0]PADDR;
rand bit PWRITE;
rand bit [31:0]PWDATA;
bit [31:0]PRDATA;
bit PSLVERR;

constraint C1{
	PADDR inside {[0:31]};
	PWRITE inside {0,1};
	if(PWRITE) PWDATA inside {[0:200]};
}

extern function void copy(packet pkt);
extern function void print();

endclass


function void packet::copy(packet pkt);
	
	this.PADDR = pkt.PADDR;
	this.PWRITE = pkt.PWRITE;
	this.PWDATA = pkt.PWDATA;

endfunction


function void packet::print();

	$display("%0s, PADDR : %0d, PWDATA : %0d, PRDATA : %0d , PSLVERR:%0b",PWRITE?"Write":"Read",PADDR,PWDATA,PRDATA,PSLVERR);
	
endfunction