module program_sequencer(
input clk,sync_reset,jmp,jmp_nz,dont_jmp,
input [3:0] jmp_addr,
output [7:0] pm_addr);

reg [7:0] pc_reg;

always @ (posedge clk)
	pc_reg <= pm_addr;

always @ *
	if (sync_reset)
		pm_addr = 8'h0;
	else if(jmp)
		pm_addr = {jmp_addr,4'h0};
	else if(jmp_nz & !dont_jmp)
		pm_addr = {jmp_addr,4'h0};
	else
		pm_addr <= pc_reg + 8'b01;



endmodule
