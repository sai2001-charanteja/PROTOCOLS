class oMonitor;

	mailbox#(packet) mbx;
	virtual apb_if.modport_mon vif;
	packet drvr_pkt;
	int tx_id;
	
	function new(mailbox#(packet) mbx, virtual apb_if.modport_mon vif);
		this.mbx = mbx;
		this.vif = vif;
	endfunction
	
	function void Craft_pkt();
		drvr_pkt = new();
		drvr_pkt.PADDR = vif.cb_mon.PADDR;
		drvr_pkt.PWRITE = vif.cb_mon.PWRITE;
		drvr_pkt.PWDATA = vif.cb_mon.PWDATA;
		drvr_pkt.PRDATA = vif.cb_mon.PRDATA;
		drvr_pkt.PSLVERR = vif.cb_mon.PSLVERR;
	
	endfunction
	
	task run();
		tx_id = 0;
		$display("[oMonitor] run strated at time : %0t",$time);
		
		forever begin
			wait(vif.cb_mon.PSEL && vif.cb_mon.PENABLE);
			@(vif.cb_mon);
			while(!vif.cb_mon.PREADY) @(vif.cb_mon);
			Craft_pkt();
			mbx.put(drvr_pkt);
			tx_id++;
			$display("[oMonitor] Transaction : %0d completed at time : %0t",tx_id,$time);
		end
		
		$display("[oMonitor] run completed at time : %0t",$time);
	
	endtask

endclass