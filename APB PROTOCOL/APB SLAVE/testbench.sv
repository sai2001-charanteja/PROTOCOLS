program testbench(apb_if vif);
	
	`include "test.sv"
	
	//basetest test1;
	newtest test1;
	initial begin
		test1 = new(vif,vif,vif);
		test1.run();
	end	


endprogram