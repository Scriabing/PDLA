`define VLIB_BYPASS_POWER_CG
`define NV_FPGA_FIFOGEN
`define FIFOGEN_MASTER_CLK_GATING_DISABLED
`define FPGA
`define SYNTHESIS

// ================================================================
// NVDLA Open Source Project
//
// Copyright(c) 2016 - 2017 NVIDIA Corporation. Licensed under the
// NVDLA Open Hardware License; Check "LICENSE" which comes with
// this distribution for more information.
// ================================================================
// File Name: SDFQD1.v
module SDFQD1 (
  SI
 ,D
 ,SE
 ,CP
 ,Q
 );
input SI ;
input D ;
input SE ;
input CP ;
output Q ;
reg Q;
assign sel = SE ? SI : D;
always @(posedge CP)
begin
    Q <= sel;
end
endmodule
