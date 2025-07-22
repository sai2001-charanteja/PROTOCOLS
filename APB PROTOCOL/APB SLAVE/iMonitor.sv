class iMonitor;
	mailbox#(packet) mbx;
	virtual apb_if.modport_mon vif;
	packet gen_pkt;
	int tx_id;
	
	function new(mailbox#(packet) mbx, virtual apb_if.modport_mon vif);
		this.mbx = mbx;
		this.vif = vif;
	endfunction
	
	function void Craft_pkt();
	
		gen_pkt = new();
		gen_pkt.PADDR = vif.cb_mon.PADDR;
		gen_pkt.PWRITE = vif.cb_mon.PWRITE;
		gen_pkt.PWDATA = vif.cb_mon.PWDATA;
		
	endfunction
	
	task run();
		tx_id = 0;
		$display("[iMonitor] run strated at time : %0t",$time);
		
		forever begin
			wait(vif.cb_mon.PSEL && vif.cb_mon.PENABLE);
			Craft_pkt();
			mbx.put(gen_pkt);
			begin
				packet temp;
				#0 while(!mbx.try_get(temp));
			end
			while(!vif.cb_mon.PREADY) @(vif.cb_mon);
			@(vif.cb_mon);
			tx_id++;
			$display("[iMonitor] Transaction : %0d completed at time : %0t",tx_id,$time);
		end
		
		$display("[iMonitor] run completed at time : %0t",$time);
	
	endtask

endclass