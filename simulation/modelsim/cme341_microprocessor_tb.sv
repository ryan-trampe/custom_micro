`timescale 1us/1ns
module cme341_microprocessor_tb();
reg clk,reset;
reg[3:0] i_pins;
wire[3:0] o_reg,data_bus,source_select;
wire [7:0] pm_address,pm_data;
wire[8:0] reg_enables;

initial #200 $stop;

initial begin
    reset = 1'b1;
    #0.75 reset = 1'b0;
end

initial clk = 1'b0;
always #0.5 clk = ~clk;

initial begin
    i_pins = 4'h9;
    #10 i_pins = 4'hc;
end

cme_341_microprocessor test_unit(
    .clk(clk),
    .reset(reset),
    .i_pins(i_pins),
    .o_reg(o_reg),
    .data_bus(data_bus),
    .source_select(source_select),
    .reg_enables(reg_enables),
    .pm_address(pm_address),
    .pm_data(pm_data)
);
endmodule
