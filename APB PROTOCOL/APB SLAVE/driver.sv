class driver;
	
	mailbox#(packet) mbx;
	virtual apb_if.modport_tb vif;
	
	packet drvr_pkt;
	int tx_id;
	
	function new(mailbox#(packet) mbx,	virtual apb_if.modport_tb vif);
		this.mbx = mbx;
		this.vif = vif;
	endfunction
	
	task automatic apply_reset();
		$display("[Driver] Reset Applied at time :%0t",$time);
		vif.cb.PRESET 	<= 1'b1;
		vif.cb.PSEL 	<= 1'b0;
		vif.cb.PADDR	<= 'b0;
		vif.cb.PWRITE 	<= 'b0;
		vif.cb.PWDATA 	<= 'b0;
		vif.cb.PENABLE 	<= 1'b0;
		repeat(2) @(vif.cb);
		
		$display("[Driver] Reset completed at time :%0t",$time);
		
	endtask
	
	task automatic drive_SetupPhase();
		//@(vif.cb);
		vif.cb.PRESET 	<= 1'b0;
		vif.cb.PSEL 	<= 1'b1;
		vif.cb.PADDR	<= drvr_pkt.PADDR;
		vif.cb.PWRITE 	<= drvr_pkt.PWRITE;
		vif.cb.PWDATA 	<= ((drvr_pkt.PWRITE)?drvr_pkt.PWDATA:'b0);
	endtask
	
	task automatic drive_AccessPhase();
		
		@(vif.cb);
		vif.cb.PENABLE 	<= 1'b1;
	endtask
	
	task waitforReady();
		@(vif.cb);
		while(!vif.cb.PREADY) @(vif.cb);
		vif.cb.PSEL 	<= 1'b0;
		vif.cb.PENABLE	<= 1'b0;
	endtask
	
	task drive();
		$display("[Driver] Driving of packet - %0d started at time : %0t",tx_id,$time);
		drive_SetupPhase();
		drive_AccessPhase();
		waitforReady();
		$display("[Driver] Transaction - %0d completed at time : %0t",tx_id,$time);
	endtask
	
	task run();
		$display("[Driver] Run started at time : %0t",$time);
		tx_id =0;
		apply_reset();
		
		forever begin
			mbx.get(drvr_pkt);
			tx_id++;
			drive();
		end
	
		$display("[Driver] Run completed at time : %0t",$time);
	endtask
	
endclass