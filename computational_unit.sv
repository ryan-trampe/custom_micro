module computational_unit(
    input clk,sync_reset,i_sel,x_sel,y_sel,
    input [3:0] ir_nibble,source_sel,dm,i_pins,
    input [8:0] reg_en,
    output r_eq_0,
    output [3:0] i,data_bus,o_reg
);

reg [3:0] x0,x1,y0,y1,r,zero_flag,m,i_reg;
wire alu_out_eq_0;
wire [3:0] x,y,alu_out;
wire[7:0] alu_multiply;
wire [2:0] alu_function;

// x0 block
always @ (posedge clk)
    if(reg_en[0]) x0 = data_bus;
    else x0 = x0;

//x1 block
always @ (posedge clk)
    if(reg_en[1]) x1 = data_bus;
    else x1 = x1;

//y0 block
always @ (posedge clk)
    if(reg_en[2]) y0 = data_bus;
    else y0 = y0;

// y1 block
always @ (posedge clk)
    if(reg_en[3]) y1 = data_bus;
    else y1 = y1;

// r register
always @ (posedge clk)
    if(reg_en[4]) r <= alu_out;
    else r <= r;

// zero_flag register
always @ (posedge clk)
    if(reg_en[4]) zero_flag <= alu_out_eq_0;
    else zero_flag <= zero_flag;

// output r_eq_0
always @ *
    r_eq_0 = zero_flag;

// m register
always @ (posedge clk)
    if(reg_en[5]) m = data_bus;
    else m = m;

// i register
always @ (posedge clk)
    if(reg_en[6])
        if(i_sel) i_reg = m + i;
        else i_reg = data_bus;
    else i_reg = i_reg;

// i output from i_reg
always @ *
    i = i_reg;

// output register
always @ (posedge clk)
    if(reg_en[8]) o_reg = data_bus;
    else o_reg = o_reg;

// source select mux
always @ *
    case(source_sel)
        4'h0: data_bus = x0;
        4'h1: data_bus = x1;
        4'h2: data_bus = y0;
        4'h3: data_bus = y1;
        4'h4: data_bus = r;
        4'h5: data_bus = m;
        4'h6: data_bus = i;
        4'h7: data_bus = dm;
        4'h8: data_bus = ir_nibble;
        4'h9: data_bus = i_pins;
        default: data_bus = 4'h0;
    endcase

// x select mux
always @ *
    if(x_sel) x = x1;
    else x = x0;

// y select mux
always @ *
    if(y_sel) y = y1;
    else y = y0;

/****************** ALU block ******************/
// alu_function wire
always @ *
    alu_function = ir_nibble[2:0];

// Extra multiplication register 8 bits wide to store MS and LS nibble
always @ *
    alu_multiply = x * y;

// ALU output calculations
always @ *
    if(sync_reset) alu_out = 4'h0;
    else if(alu_function == 3'h0)
        if(ir_nibble[3]) alu_out = r;
        else alu_out = -x;
    else if(alu_function == 3'h1) alu_out = x - y;
    else if(alu_function == 3'h2) alu_out = x + y;
    else if(alu_function == 3'h3) alu_out = alu_multiply[7:4];
    else if(alu_function == 3'h4) alu_out = alu_multiply[3:0];
    else if(alu_function == 3'h5) alu_out = x ^ y;
    else if(alu_function == 3'h6) alu_out = x & y;
    else if(alu_function == 3'h7)
        if(ir_nibble[3]) alu_out = r;
        else alu_out = ~x;
    else alu_out = 4'h0;

// ALU zero_flag output
always @ *
    if(sync_reset) alu_out_eq_0 = 1'b1;
    else if(alu_out == 4'h0) alu_out_eq_0 = 1'b1;
    else alu_out_eq_0 = 1'b0;




endmodule
