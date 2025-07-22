class generator;

	mailbox #(packet) mbx;
	int ttl_no_pkts;
	packet ref_pkt;
	packet pkt;
	
	int tx_id;
	
	function new(mailbox#(packet) mbx,int ttl_no_pkts);
		this.ttl_no_pkts = ttl_no_pkts;
		this.mbx = mbx;
	endfunction
	
	
	task run();		
		tx_id = 0;
		ref_pkt = new();
		
		repeat(ttl_no_pkts) begin
			tx_id++;
			pkt = new();
			void'(ref_pkt.randomize());
			pkt.copy(ref_pkt);
			mbx.put(pkt);
			$display("[Generated] Packet : %0d, randomized at time : %0t",tx_id,$time);
		end
	
	endtask
	
endclass