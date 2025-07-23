`include "packet.sv"
`include "driver.sv"
`include "generator.sv"
`include "iMonitor.sv"
`include "oMonitor.sv"
`include "scoreboard.sv"
`include "coverage.sv"

class environment;
	virtual apb_if.modport_tb vif;
	virtual apb_if.modport_mon ivif;
	virtual apb_if.modport_mon ovif;
	mailbox#(packet) mbx;
	mailbox#(packet) imbx;
	mailbox#(packet) ombx;
	
	generator gen;
	driver drvr;
	iMonitor imon;
	oMonitor omon;
	scoreboard scb;
	coverage cov;
	
	int ttl_no_tnxs;
	
	function new(virtual apb_if.modport_tb vif,	virtual apb_if.modport_mon ivif,virtual apb_if.modport_mon ovif,int ttl_no_tnxs);
		this.ttl_no_tnxs = ttl_no_tnxs;
		this.vif = vif;
		this.ivif = ivif;
		this.ovif = ovif;
	endfunction
	
	function void build();
	
		$display("[Environment] Build strated at time : %0t",$time);
		mbx = new(1);
		imbx = new(1);
		ombx = new(1);
		gen = new(mbx,ttl_no_tnxs);
		drvr = new(mbx,vif);
		imon = new(imbx,ivif);
		omon = new(ombx,ovif);
		scb = new(imbx,ombx);
		cov = new(imbx);
		$display("[Environment] Build completed at time : %0t",$time);
		
	endfunction
	
	task automatic run();
		$display("[Environment] Run started at time : %0t",$time);
		
		fork 
			gen.run();
			drvr.run();
			imon.run();
			omon.run();
			scb.run();
			cov.run();
		join_any
		
		wait(drvr.tx_id == ttl_no_tnxs);
		
		repeat(50) @(vif.cb);
		scb.Report();
		cov.Report();
		$display("[Environment] Run completed at time : %0t",$time);
	endtask


endclass