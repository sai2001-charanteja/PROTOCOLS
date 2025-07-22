module apb_slave_waitstates
(
input PCLK,
input PRESET,
input [31:0]PADDR,
input PSEL,
input PWRITE,
input [31:0]PWDATA,
input PENABLE,
output reg PREADY,
output reg PSLVERR,
output reg [31:0]PRDATA
);

logic [3:0] icnt;
parameter logic [3:0] WAIT_CYCLES = 5;

reg [31:0][31:0] slave_memory;
always @(posedge PCLK) begin
	if(PRESET) begin
		PREADY 	<= 1'b0;
		PSLVERR <= 1'b0;
		PRDATA 	<= 'b0;
		slave_memory <= 'b0;
	end else begin
		PREADY 	<= 1'b0;
		PSLVERR <= 1'b0;
		PRDATA 	<= 'b0;
		if(PSEL && PENABLE) begin
			if(icnt==WAIT_CYCLES) begin
				if(PADDR >=0 && PADDR <= 31) begin
					if(PWRITE) begin
						//Write operation
						slave_memory[PADDR] <= PWDATA;
					end else begin
					// Read Operation
						PRDATA <= slave_memory[PADDR];
					end
					PREADY <= 1'b1;
				end else begin
					PSLVERR <= 1'b1;
				end
			end
			
		end 
		
	end
end

always @(posedge PCLK) begin
	if(PRESET) icnt <= 0;
	else begin
		if(PSEL && PENABLE) icnt <= icnt == WAIT_CYCLES?0:icnt + 1;
		else icnt <=0;
	end
	
end

endmodule