`include "environment.sv"
class basetest;

	virtual apb_if.modport_tb vif;
	virtual apb_if.modport_mon ivif;
	virtual apb_if.modport_mon ovif;
	environment env;
	int ttl_no_tnxs;
	
	function new(virtual apb_if.modport_tb vif,	virtual apb_if.modport_mon ivif,virtual apb_if.modport_mon ovif);
		this.vif = vif;
		this.ivif = ivif;
		this.ovif = ovif;
	endfunction
	
	task build();
		ttl_no_tnxs = 1000;
		env = new(vif,ivif,ovif,ttl_no_tnxs);
		env.build();
	endtask
	
	virtual task run();
	
		build();
		
		env.run();
	endtask
	
endclass


class newtest extends basetest;
	virtual apb_if.modport_tb vif;
	virtual apb_if.modport_mon ivif;
	virtual apb_if.modport_mon ovif;
	
	newpacket npkt;
	
	function new(virtual apb_if.modport_tb vif,	virtual apb_if.modport_mon ivif,virtual apb_if.modport_mon ovif);
		
		super.new(vif,ivif,ovif);
		
	endfunction
	
	task automatic changePktkind();
		
		wait(env.gen.tx_id == 0.3*ttl_no_tnxs); // 30% Burst Transaction
		env.gen.ref_pkt.kind = IDLE;
		wait(env.gen.tx_id == 0.7*ttl_no_tnxs); // 40% Idle Transaction
		npkt = new();
		env.gen.ref_pkt = npkt;
		env.gen.ref_pkt.kind = INVALID;
		wait(env.drvr.tx_id == ttl_no_tnxs); // 30% Invalid Transactions
		
	endtask
	
	task run();
		build();
		env.gen.ref_pkt.kind = BURST;
		fork
			env.run();
			changePktkind();
		join
		
	endtask

endclass
