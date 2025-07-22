`include "environment.sv"
class test;

	virtual apb_if.modport_tb vif;
	virtual apb_if.modport_mon ivif;
	virtual apb_if.modport_mon ovif;
	environment env;
	
	
	function new(virtual apb_if.modport_tb vif,	virtual apb_if.modport_mon ivif,virtual apb_if.modport_mon ovif);
		this.vif = vif;
		this.ivif = ivif;
		this.ovif = ovif;
	endfunction
	
	task run();
		env = new(vif,ivif,ovif);
		env.run();
	endtask
	
endclass