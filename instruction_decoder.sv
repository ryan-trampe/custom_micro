module instruction_decoder(
    input [7:0] pm_data,
    input sync_reset,clk,
    output jmp,jmp_nz,i_sel,y_sel,x_sel,
    output[3:0] ir_nibble,source_sel,
    output[8:0] reg_en
);
// Design follows design process in schematic diagrams consisting
// of 4 logic boxes
wire [7:0] ir;

//Making the instruction register
always @ (posedge clk)
    ir = pm_data;

always @ *
    ir_nibble = ir[3:0];

//Logic box determining instruction type
always @ *
    if (sync_reset) jmp = 1'b0;
    else if(ir[7:4] == 4'b1110) jmp = 1'b1;
    else jmp = 1'b0;

always @ *
    if(sync_reset) jmp_nz = 1'b0;
    else if(ir[7:4] == 4'b1111) jmp_nz = 1'b1;
    else jmp_nz = 1'b0;

// x-selcct
always @ *
    if(sync_reset) x_sel = 1'b0;
    else if(ir[7:5] == 3'b110) x_sel = ir[4];

// y-select
always @ *
    if(sync_reset) y_sel= 1'b0;
    else if(ir[7:5] == 3'b110) y_sel = ir[3];

always @ *
    if(sync_reset) i_sel= 1'b0;
    else if((ir[7:4] == 4'b0110) || (ir[7:3] == 5'b10110)) i_sel = 1'b0;
    else i_sel = 1'b1;

// Source select logic
always @ *
    if(sync_reset) source_sel = 4'd10;
    else if(ir[7] == 1'b0) source_sel = 4'd8;
    else if(ir[7:6] == 2'b10) 
        if((ir[5:3] == ir[2:0]) && (ir[5:3] != 3'd4)) source_sel = 4'd9;
        else source_sel = {1'b0,ir[2:0]};
    else source_sel = 4'd10;

always @ *
    if(sync_reset) reg_en[0] = 1'b1;
    else if((ir[7:4] == 4'b0000) || (ir[7:3] == 5'b10000)) reg_en[0] = 1'b1;
    else reg_en[0] = 1'b0;

always @ *
    if(sync_reset) reg_en[1] = 1'b1;
    else if((ir[7:4] == 4'b0001) || (ir[7:3] == 5'b10001)) reg_en[1] = 1'b1;
    else reg_en[1] = 1'b0;

always @ *
    if(sync_reset) reg_en[2] = 1'b1;
    else if((ir[7:4] == 4'b0010) || (ir[7:3] == 5'b10010)) reg_en[2] = 1'b1;
    else reg_en[2] = 1'b0;

always @ *
    if(sync_reset) reg_en[3] = 1'b1;
    else if((ir[7:4] == 4'b0011) || (ir[7:3] == 5'b10011)) reg_en[3] = 1'b1;
    else reg_en[3] = 1'b0;

always @ *
    if(sync_reset) reg_en[4] = 1'b1;
    else if(ir[7:5] == 3'b110) reg_en[4] = 1'b1;
    else reg_en[4] = 1'b0;

always @ *
    if(sync_reset) reg_en[5] = 1'b1;
    else if((ir[7:4] == 4'b0101) || (ir[7:3] == 5'b10101)) reg_en[5] = 1'b1;
    else reg_en[5] = 1'b0;

always @ *
    if(sync_reset) reg_en[6] = 1'b1;
    else if(ir[7:3] == 5'b10110) reg_en[6] = 1'b1;
    else if(ir[7:4] == 4'b0110) reg_en[6] = 1'b1;
    else if(ir[7:3] == 5'b10111) reg_en[6] = 1'b1;
    else if(ir[7:4] == 4'b0111) reg_en[6] = 1'b1;
    else if((ir[7:6] == 2'b10) && (ir[2:0] == 3'b111)) reg_en[6] = 1'b1;
    else reg_en[6] = 1'b0;

always @ *
    if(sync_reset) reg_en[7] = 1'b1;
    else if((ir[7:4] == 4'b0111) || (ir[7:3] == 5'b10111)) reg_en[7] = 1'b1;
    else reg_en[7] = 1'b0;

always @ *
    if(sync_reset) reg_en[8] = 1'b1;
    else if ((ir[7:4] == 4'b0100) || (ir[7:3] == 5'b10100)) reg_en[8] = 1'b1;
    else reg_en[8] = 1'b0;

endmodule