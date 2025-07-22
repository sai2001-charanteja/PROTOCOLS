`include "apb_if.sv"
module top;

	bit clk;
	apb_if apb_if_inst(clk);
	
	always #5 clk = !clk;
	
	//apb_slave dut(
	apb_slave_waitstates dut(
				.PCLK(clk),
				.PRESET(apb_if_inst.PRESET),
				.PADDR(apb_if_inst.PADDR),
				.PSEL(apb_if_inst.PSEL),
				.PWRITE(apb_if_inst.PWRITE),
				.PWDATA(apb_if_inst.PWDATA),
				.PENABLE(apb_if_inst.PENABLE),
				.PREADY(apb_if_inst.PREADY),
				.PSLVERR(apb_if_inst.PSLVERR),
				.PRDATA(apb_if_inst.PRDATA)
				);

	testbench tb(apb_if_inst);
endmodule