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
// File Name: SDFCNQD1.v
module SDFCNQD1 (
  SI
 ,D
 ,SE
 ,CP
 ,CDN
 ,Q
 );
input SI ;
input D ;
input SE ;
input CP ;
input CDN ;
output Q ;
reg Q;
assign sel = SE ? SI : D;
always @(posedge CP or negedge CDN)
begin
    if(~CDN)
        Q <= 1'b0;
    else
        Q <= sel;
end
endmodule
