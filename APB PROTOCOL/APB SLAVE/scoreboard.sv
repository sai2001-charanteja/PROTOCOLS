class scoreboard;

	mailbox#(packet) imbx;
	mailbox#(packet) ombx;
	packet gen_pkt;
	packet drvr_pkt;
	int tx_id;
	int matched, missMatched;
	bit [31:0][31:0] shadow_memory;
	function new(mailbox#(packet) imbx, mailbox#(packet) ombx);
		this.imbx = imbx;
		this.ombx = ombx;
	endfunction
	
	function void compareResults();
		if(!drvr_pkt.PSLVERR) begin
			if(gen_pkt.PWRITE) begin
				shadow_memory[gen_pkt.PADDR] = gen_pkt.PWDATA;
			end else begin
				if(shadow_memory[gen_pkt.PADDR] == drvr_pkt.PRDATA) matched++;
				else missMatched++;
				
				if(shadow_memory[gen_pkt.PADDR] != drvr_pkt.PRDATA) $display("MissMatched");
			end
		end
	endfunction
	
	task run();
		tx_id = 0;
		matched = 0;
		missMatched = 0;
		$display("[Scoreboard] run strated at time : %0t",$time);
		
		forever begin
			imbx.peek(gen_pkt);
			ombx.get(drvr_pkt);
			gen_pkt.print();
			drvr_pkt.print();
			compareResults();
			tx_id++;
			$display("[Scoreboard] Transaction : %0d completed at time : %0t",tx_id,$time);
		end
		
		$display("[Scoreboard] run completed at time : %0t",$time);
	
	endtask


	function void Report();
		$display("\n*********[ScoreBoard] Results at %0t**********",$time);
		$display("*********Matched : %0d, MissMatched : %0d*********",matched,missMatched);
		$display("Shadow Memory : %0p",shadow_memory);
	endfunction
endclass