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
// File Name: PGAOPV_AN2D2PO4.v
module PGAOPV_AN2D2PO4 (
  A1
 ,A2
 ,Z
 );
//---------------------------------------
//IO DECLARATIONS
input A1 ;
input A2 ;
output Z ;
assign Z = A1 & A2;
endmodule
