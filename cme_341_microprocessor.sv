module cme_341_microprocessor (
input clk, reset,
input [3:0] i_pins,
output[3:0] o_reg,data_bus,source_select,
output [7:0]pm_address,pm_data,
output [8:0] reg_enables);

// Wires fpr prog_sequencer
wire jump,conditional_jump,zero_flag;
wire [3:0] LS_nibble_ir;
/*wire[7:0] pm_address;*/

// Wires for prog_mem
/*wire [7:0] pm_data;*/

// Wires for instr_decoder
wire i_mux_select,y_reg_select,x_reg_select;
/*wire [3:0] source_select;*/
/*wire [8:0] reg_enables;*/

// Wires for data_mem
wire [3:0] data_mem_addr, /*data_bus,*/ dm;

// Sync Reset
reg sync_reset;
always @ (posedge clk)
	sync_reset = reset;


// Instantiations	
program_sequencer prog_sequencer (
	.clk(clk),
	.sync_reset(sync_reset),
	.dont_jmp(zero_flag),
	.jmp(jump),
	.jmp_nz(conditional_jump),
	.jmp_addr(LS_nibble_ir),
	.pm_addr(pm_address)	);

program_memory prog_mem	(
	.clock(~clk),
	.address(pm_address),
	.q(pm_data)	);
	
instruction_decoder instr_decoder(
	.clk(clk),
	.pm_data(pm_data),
	.sync_reset(sync_reset),
	.jmp(jump),
	.jmp_nz(conditional_jump),
	.ir_nibble(LS_nibble_ir),
	.i_sel(i_mux_select),
	.y_sel(y_reg_select),
	.x_sel(x_reg_select),
	.source_sel(source_select),
	.reg_en(reg_enables)	);

computational_unit comp_unit(
	.clk(clk),
	.sync_reset(sync_reset),
	.i_pins(i_pins),
	.r_eq_0(zero_flag),
	.ir_nibble(LS_nibble_ir),
	.i_sel(i_mux_select),
	.y_sel(y_reg_select),
	.x_sel(x_reg_select),
	.source_sel(source_select),
	.reg_en(reg_enables),
	.o_reg(o_reg),
	.dm(dm),
	.data_bus(data_bus),
	.i(data_mem_addr)
);

data_memory data_mem(
	.clock(~clk),
	.address(data_mem_addr),
	.data(data_bus),
	.q(dm),
	.wren(reg_enables[7])
);
	


endmodule
