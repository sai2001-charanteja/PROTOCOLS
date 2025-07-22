module apb_slave
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

reg [31:0][31:0] slave_memory;
int i;
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
		end else if(PSEL && !PENABLE) begin
			PREADY <= 1'b1;
		end
	end
end

endmodule