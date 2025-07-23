class coverage;

	mailbox#(packet) mbx;
	packet ref_pkt;
	
	int tx_id;
	real coverage_rate;

	covergroup fcov with function sample(packet pkt);
	
		coverpoint pkt.PADDR{
			bins addr = {[0:31]};
		}
		
		coverpoint pkt.PWDATA{
			bins wdatasmall = {[0:100]};
			bins wdatamedium = {[100:200]};
		}
		
		cross pkt.PWRITE,pkt.PADDR;
		cross pkt.PWRITE,pkt.PWDATA;
	endgroup
	
	function new(mailbox#(packet) mbx);
		fcov = new();
		this.mbx = mbx;
	endfunction
	
	
	task run();
		tx_id = 0;
		$display("[Coverage] Run started at time : %0t",$time);
		forever begin
		@(mbx.num);
		mbx.peek(ref_pkt);
		fcov.sample(ref_pkt);
		coverage_rate = fcov.get_coverage();
		tx_id++;
		$display("[Coverage] Transaction %0d , cov rate : %0f,  completed at time : %0t ",tx_id,coverage_rate,$time);
		end
		
		$display("[Coverage] Run completed at time : %0t",$time);
	
	endtask
	
	
	function void Report();
		
		$display("\n*************** COVERAGE ANALYSIS***************");
		$display("***********Coverage Rate : %0f***********",coverage_rate);
	
	endfunction
	
endclass