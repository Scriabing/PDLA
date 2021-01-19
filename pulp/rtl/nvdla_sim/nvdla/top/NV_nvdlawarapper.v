`define VLIB_BYPASS_POWER_CG
`define NV_FPGA_FIFOGEN
`define FIFOGEN_MASTER_CLK_GATING_DISABLED
`define FPGA
`define SYNTHESIS

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/19 22:08:48
// Design Name: 
// Module Name: NV_nvdla_wrapper
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

`define VLIB_BYPASS_POWER_CG
`define NV_FPGA_FIFOGEN
`define FIFOGEN_MASTER_CLK_GATING_DISABLED
`define FPGA
`define SYNTHESIS
module NV_nvdla_wrapper(
pclk,
prstn,
paddr,
penable,
psel,
pwdata,
pwrite,
prdata,
pready,
pslverr,
dla_core_clk,
dla_csb_clk,
dla_reset_rstn,
direct_reset_,
global_clk_ovr_on,
tmc2slcg_disable_clock_gating,
test_mode,

nvdla_core2dbb_aw_awvalid,
nvdla_core2dbb_aw_awready,
nvdla_core2dbb_aw_awid_t,
nvdla_core2dbb_aw_awlen_t,
nvdla_core2dbb_aw_awaddr,
nvdla_core2dbb_w_wvalid,
nvdla_core2dbb_w_wready,
nvdla_core2dbb_w_wdata,
nvdla_core2dbb_w_wstrb,
nvdla_core2dbb_w_wlast,
nvdla_core2dbb_ar_arvalid,
nvdla_core2dbb_ar_arready,
nvdla_core2dbb_ar_arid_t,
nvdla_core2dbb_ar_arlen_t,
nvdla_core2dbb_ar_araddr,
nvdla_core2dbb_b_bvalid,
nvdla_core2dbb_b_bready,
nvdla_core2dbb_b_bid_t,
nvdla_core2dbb_r_rvalid,
nvdla_core2dbb_r_rready,
nvdla_core2dbb_r_rid_t,
nvdla_core2dbb_r_rlast,
nvdla_core2dbb_r_rdata,
nvdla_core2dbb_aw_awsize,
nvdla_core2dbb_ar_arsize,
nvdla_core2dbb_aw_awburst,
nvdla_core2dbb_ar_arburst,
nvdla_core2dbb_aw_awlock,
nvdla_core2dbb_ar_arlock,
nvdla_core2dbb_aw_awcache,
nvdla_core2dbb_ar_arcache,
nvdla_core2dbb_aw_awprot,
nvdla_core2dbb_ar_arprot,
nvdla_core2dbb_aw_awqos,
nvdla_core2dbb_ar_arqos,
nvdla_core2dbb_aw_awuser,
nvdla_core2dbb_ar_aruser,
nvdla_core2dbb_w_user,
nvdla_core2dbb_b_resp,
nvdla_core2dbb_b_user,
nvdla_core2dbb_r_resp,
nvdla_core2dbb_r_user,
dla_intr,
nvdla_pwrbus_ram_c_pd,
nvdla_pwrbus_ram_ma_pd,
nvdla_pwrbus_ram_mb_pd,
nvdla_pwrbus_ram_p_pd,
nvdla_pwrbus_ram_o_pd,
nvdla_pwrbus_ram_a_pd
);

/***apb/csb***/
input pclk;
input prstn;
input [31:0]paddr;
input penable;
input psel;
input [31:0]pwdata;
input pwrite;
output [31:0]prdata;
output pready;

output pslverr;//推断时作为从端信号线S_APB_PSLVERR

/***NV_nvdla***/
input dla_core_clk;
input dla_csb_clk;
input global_clk_ovr_on;//--
input tmc2slcg_disable_clock_gating;//--
input dla_reset_rstn;
input direct_reset_;
input test_mode;
//output nvdla2csb_wr_complete;没用到，置空？

output nvdla_core2dbb_aw_awvalid;
input nvdla_core2dbb_aw_awready;
output [5:0] nvdla_core2dbb_aw_awid_t;//todo vvviy
output [7:0] nvdla_core2dbb_aw_awlen_t;//todo //地址8位有效？
output [32 -1:0] nvdla_core2dbb_aw_awaddr;
output nvdla_core2dbb_w_wvalid;
input nvdla_core2dbb_w_wready;
output [64 -1:0] nvdla_core2dbb_w_wdata;
output [64/8-1:0] nvdla_core2dbb_w_wstrb;
output nvdla_core2dbb_w_wlast;
output nvdla_core2dbb_ar_arvalid;
input nvdla_core2dbb_ar_arready;
output [5:0] nvdla_core2dbb_ar_arid_t;//todo
output [7:0] nvdla_core2dbb_ar_arlen_t;//todo
output [32 -1:0] nvdla_core2dbb_ar_araddr;
input nvdla_core2dbb_b_bvalid;
output nvdla_core2dbb_b_bready;
input [5:0] nvdla_core2dbb_b_bid_t;//todo
input nvdla_core2dbb_r_rvalid;
output nvdla_core2dbb_r_rready;
input [5:0] nvdla_core2dbb_r_rid_t;//todo
input nvdla_core2dbb_r_rlast;
input [64 -1:0] nvdla_core2dbb_r_rdata;

//axi剩下的信号线 apb2dbb  from vvviy to zyx
// output  [2 : 0]   M_AXI_AWSIZE;
// output  [1 : 0]   M_AXI_AWBURST;
// output            M_AXI_AWLOCK;
// output  [3 : 0]   M_AXI_AWCACHE;
// output  [2 : 0]   M_AXI_AWPROT;
// output  [3 : 0]   M_AXI_AWQOS;
// output            M_AXI_AWUSER;
// output            M_AXI_WUSER;//todo
// input   [1 : 0]   M_AXI_BRESP;//todo
// input             M_AXI_BUSER;//todo
// output  [2 : 0]   M_AXI_ARSIZE;
// output  [1 : 0]   M_AXI_ARBURST;
// output            M_AXI_ARLOCK;
// output  [3 : 0]   M_AXI_ARCACHE;
// output  [2 : 0]   M_AXI_ARPROT;
// output  [3 : 0]   M_AXI_ARQOS;
// output            M_AXI_ARUSER;
// input   [1 : 0]   M_AXI_RRESP;//todo
// input             M_AXI_RUSER;//todo  
output [2:0] nvdla_core2dbb_aw_awsize;//用这部分做axi推断，taiwan把他们初始化定义了
output [2:0] nvdla_core2dbb_ar_arsize;
output [1:0] nvdla_core2dbb_aw_awburst;
output [1:0] nvdla_core2dbb_ar_arburst;
output       nvdla_core2dbb_aw_awlock;
output       nvdla_core2dbb_ar_arlock;
output [3:0] nvdla_core2dbb_aw_awcache;
output [3:0] nvdla_core2dbb_ar_arcache;
output [2:0] nvdla_core2dbb_aw_awprot;
output [2:0] nvdla_core2dbb_ar_arprot;
output [3:0] nvdla_core2dbb_aw_awqos;
output [3:0] nvdla_core2dbb_ar_arqos;
output       nvdla_core2dbb_aw_awuser;
output       nvdla_core2dbb_ar_aruser;
output       nvdla_core2dbb_w_user;
input[1 : 0] nvdla_core2dbb_b_resp;
input        nvdla_core2dbb_b_user;
input[1 : 0] nvdla_core2dbb_r_resp;
input        nvdla_core2dbb_r_user;
//可能被修改位宽后的csb/dbb需要,from taiwan,修改方式位宽不一样
//  assign nvdla_core2dbb_aw_awsize = 3'b011;
//  assign nvdla_core2dbb_ar_arsize = 3'b011;
//  assign nvdla_core2dbb_aw_awburst = 2'b01;
//  assign nvdla_core2dbb_ar_arburst = 2'b01;
//  assign nvdla_core2dbb_aw_awlock = 1'b0;
//  assign nvdla_core2dbb_ar_arlock = 1'b0;
//  assign nvdla_core2dbb_aw_awcache = 4'b0000;//不同于vvviy
//  assign nvdla_core2dbb_ar_arcache = 4'b0000;
//  assign nvdla_core2dbb_aw_awprot = 3'b010;//不同于vvviy
//  assign nvdla_core2dbb_ar_arprot = 3'b010;
//  assign nvdla_core2dbb_aw_awqos = 4'b0000;
//  assign nvdla_core2dbb_ar_arqos = 4'b0000;
//  assign nvdla_core2dbb_aw_awuser = 1'b0;
//  assign nvdla_core2dbb_ar_aruser = 1'b0;//不同于vvviy

// assign nvdla_core2cvsram_aw_awvalid = 1'b0;//后面vvviy没有
// assign nvdla_core2cvsram_w_wvalid = 1'b0;
// assign nvdla_core2cvsram_w_wlast = 1'b0;
// assign nvdla_core2cvsram_b_bready = 1'b1;
// assign nvdla_core2cvsram_r_rready = 1'b1;

output dla_intr;
input [31:0] nvdla_pwrbus_ram_c_pd;//在neigh都置为0
input [31:0] nvdla_pwrbus_ram_ma_pd;
input [31:0] nvdla_pwrbus_ram_mb_pd;
input [31:0] nvdla_pwrbus_ram_p_pd;
input [31:0] nvdla_pwrbus_ram_o_pd;
input [31:0] nvdla_pwrbus_ram_a_pd;


/**部分信号线初始化**/
//add these code to NV_nvdla module
assign nvdla_core2dbb_aw_awsize  = 3'b011;
assign nvdla_core2dbb_aw_awburst = 2'b01;
assign nvdla_core2dbb_aw_awlock = 1'b0;
assign nvdla_core2dbb_aw_awcache = 4'b0010;
assign nvdla_core2dbb_aw_awprot  = 3'h0;
assign nvdla_core2dbb_aw_awqos   = 4'h0;
assign nvdla_core2dbb_aw_awuser  = 'b1;
assign nvdla_core2dbb_w_user  = 'b0;
assign nvdla_core2dbb_ar_arsize  = 3'b011;
assign nvdla_core2dbb_ar_arburst = 2'b01;
assign nvdla_core2dbb_ar_arlock  = 1'b0;
assign nvdla_core2dbb_ar_arcache = 4'b0010;
assign nvdla_core2dbb_ar_arprot  = 3'h0;
assign nvdla_core2dbb_ar_arqos  = 4'h0;
assign nvdla_core2dbb_ar_aruser  = 1'b1;
//add below code to NV_NVDLA_apb2csb module
assign pslverr = 1'b0;

//zhilianxian,wuduiwaikou
wire        m_csb2nvdla_valid;
wire        m_csb2nvdla_ready;
wire [15:0] m_csb2nvdla_addr;
wire [31:0] m_csb2nvdla_wdat;
wire        m_csb2nvdla_write;
wire        m_csb2nvdla_nposted;
wire        m_nvdla2csb_valid;
wire [31:0] m_nvdla2csb_data;


wire [3:0]nvdla_core2dbb_aw_awlen_m;
wire [7:0]nvdla_core2dbb_aw_awid_m;
wire [7:0]nvdla_core2dbb_b_bid_m;
wire [7:0]nvdla_core2dbb_r_rid_m;
wire [7:0]nvdla_core2dbb_ar_arid_m;
wire [3:0]nvdla_core2dbb_ar_arlen_m;

assign nvdla_core2dbb_aw_awlen_t[7:0] = {4'b0, nvdla_core2dbb_aw_awlen_m};
assign nvdla_core2dbb_aw_awid_t[5:0] = nvdla_core2dbb_aw_awid_m[5:0];
assign nvdla_core2dbb_b_bid_m[7:0]= {2'd0,nvdla_core2dbb_b_bid_t};//input
assign nvdla_core2dbb_r_rid_m[7:0]= {2'd0,nvdla_core2dbb_r_rid_t};//input
assign nvdla_core2dbb_ar_arid_t[5:0] = nvdla_core2dbb_ar_arid_m[5:0];
assign nvdla_core2dbb_ar_arlen_t[7:0] = {4'b0, nvdla_core2dbb_ar_arlen_m};

NV_NVDLA_apb2csb n_nvdla_apb2csb(
   .pclk(pclk)
  ,.prstn(prstn)
  ,.csb2nvdla_ready(m_csb2nvdla_ready)
  ,.nvdla2csb_data(m_nvdla2csb_data)
  ,.nvdla2csb_valid(m_nvdla2csb_valid)
  ,.paddr(paddr)
  ,.penable(penable)
  ,.psel(psel)
  ,.pwdata(pwdata)
  ,.pwrite(pwrite)
  ,.csb2nvdla_addr(m_csb2nvdla_addr)
  ,.csb2nvdla_nposted(m_csb2nvdla_nposted)
  ,.csb2nvdla_valid(m_csb2nvdla_valid)
  ,.csb2nvdla_wdat(m_csb2nvdla_wdat)
  ,.csb2nvdla_write(m_csb2nvdla_write)
  ,.prdata(prdata)
  ,.pready(pready)
  );
  
  NV_nvdla n_nvdla(
   .dla_core_clk(dla_core_clk) //|< i
  ,.dla_csb_clk(dla_csb_clk) //|< i
  ,.global_clk_ovr_on(global_clk_ovr_on) //|< i
  ,.tmc2slcg_disable_clock_gating(tmc2slcg_disable_clock_gating) //|< i
  ,.dla_reset_rstn(dla_reset_rstn) //|< i
  ,.direct_reset_(direct_reset_) //|< i
  ,.test_mode(test_mode) //|< i
  ,.csb2nvdla_valid(m_csb2nvdla_valid) //|< i
  ,.csb2nvdla_ready(m_csb2nvdla_ready) //|> o
  ,.csb2nvdla_addr(m_csb2nvdla_addr) //|< i
  ,.csb2nvdla_wdat(m_csb2nvdla_wdat) //|< i
  ,.csb2nvdla_write(m_csb2nvdla_write) //|< i
  ,.csb2nvdla_nposted(m_csb2nvdla_nposted) //|< i
  ,.nvdla2csb_valid(m_nvdla2csb_valid) //|> o
  ,.nvdla2csb_data(m_nvdla2csb_data) //|> o
  ,.nvdla2csb_wr_complete() //|> o
  ,.nvdla_core2dbb_aw_awvalid(nvdla_core2dbb_aw_awvalid) //|> o
  ,.nvdla_core2dbb_aw_awready(nvdla_core2dbb_aw_awready) //|< i
  ,.nvdla_core2dbb_aw_awid(nvdla_core2dbb_aw_awid_m) //|> o
  ,.nvdla_core2dbb_aw_awlen(nvdla_core2dbb_aw_awlen_m) //|> o
  ,.nvdla_core2dbb_aw_awaddr(nvdla_core2dbb_aw_awaddr) //|> o
  ,.nvdla_core2dbb_w_wvalid(nvdla_core2dbb_w_wvalid) //|> o
  ,.nvdla_core2dbb_w_wready(nvdla_core2dbb_w_wready) //|< i
  ,.nvdla_core2dbb_w_wdata(nvdla_core2dbb_w_wdata) //|> o
  ,.nvdla_core2dbb_w_wstrb(nvdla_core2dbb_w_wstrb) //|> o
  ,.nvdla_core2dbb_w_wlast(nvdla_core2dbb_w_wlast) //|> o
  ,.nvdla_core2dbb_b_bvalid(nvdla_core2dbb_b_bvalid) //|< i
  ,.nvdla_core2dbb_b_bready(nvdla_core2dbb_b_bready) //|> o
  ,.nvdla_core2dbb_b_bid(nvdla_core2dbb_b_bid_m) //|< i
  ,.nvdla_core2dbb_ar_arvalid(nvdla_core2dbb_ar_arvalid) //|> o
  ,.nvdla_core2dbb_ar_arready(nvdla_core2dbb_ar_arready) //|< i
  ,.nvdla_core2dbb_ar_arid(nvdla_core2dbb_ar_arid_m) //|> o
  ,.nvdla_core2dbb_ar_arlen(nvdla_core2dbb_ar_arlen_m) //|> o
  ,.nvdla_core2dbb_ar_araddr(nvdla_core2dbb_ar_araddr) //|> o
  ,.nvdla_core2dbb_r_rvalid(nvdla_core2dbb_r_rvalid) //|< i
  ,.nvdla_core2dbb_r_rready(nvdla_core2dbb_r_rready) //|> o
  ,.nvdla_core2dbb_r_rid(nvdla_core2dbb_r_rid_m) //|< i
  ,.nvdla_core2dbb_r_rlast(nvdla_core2dbb_r_rlast) //|< i
  ,.nvdla_core2dbb_r_rdata(nvdla_core2dbb_r_rdata) //|< i
  ,.dla_intr(dla_intr) //|> o
  ,.nvdla_pwrbus_ram_c_pd(nvdla_pwrbus_ram_c_pd) //|< i
  ,.nvdla_pwrbus_ram_ma_pd(nvdla_pwrbus_ram_ma_pd) //|< i *
  ,.nvdla_pwrbus_ram_mb_pd(nvdla_pwrbus_ram_mb_pd) //|< i *
  ,.nvdla_pwrbus_ram_p_pd(nvdla_pwrbus_ram_p_pd) //|< i
  ,.nvdla_pwrbus_ram_o_pd(nvdla_pwrbus_ram_o_pd) //|< i
  ,.nvdla_pwrbus_ram_a_pd(nvdla_pwrbus_ram_a_pd) //|< i
  );

endmodule
