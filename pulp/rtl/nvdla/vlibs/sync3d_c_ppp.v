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
// File Name: sync3d_c_ppp.v
module sync3d_c_ppp ( d, clk, clr_, q );
input d, clk, clr_;
output q;
    p_SSYNC3DO_C_PPP NV_GENERIC_CELL( .d(d), .clk(clk), .clr_(clr_), .q(q) );
// synopsys dc_script_begin
// synopsys dc_script_end
//g2c if {[find / -null_ok -subdesign sync3d_c_ppp] != {} } { set_attr preserve 1 [find / -subdesign sync3d_c_ppp] }
endmodule
