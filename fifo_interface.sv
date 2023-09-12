import uvm_pkg::*;
`include "uvm_macros.svh"
`timescale 1ns/10ps

/***********************************************
* interface 
*********************************************/
interface dut_if(clk,rstn);
    logic o_full,o_empty,o_alm_full,o_alm_empty,i_wren,i_rden;
    logic [127:0] i_wrdata;
    logic [127:0] o_rddata;
endinterface : dut_if

clocking d_cb @(posedge clk);
    default input #1 output #1;
    output i_wren;
    output i_rden;
    output i_wrdata;
  endclocking

 clocking m_cb @(posedge clk);
    default input #1 output #1;
    input o_full;
    input o_empty;
    input o_alm_full;
   input o_alm_empty;
   input o_rddata;
  endclocking

modport d_mp (input clk, rstn, clocking d_cb);
  modport m_mp (input clk, rstn, clocking m_cb);
    
endinterface
