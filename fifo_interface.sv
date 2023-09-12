import uvm_pkg::*;
`include "uvm_macros.svh"
`timescale 1ns/10ps

interface fifo_interface(input clk,rstn);
    bit o_full,o_empty,o_alm_full,o_alm_empty,i_wren,i_rden;
    bit [127:0] i_wrdata;
    bit [127:0] o_rddata;
endinterface : dut_if

clocking driver_cb @(posedge clk);
    default input #1 output #1;
    output i_wren;
    output i_rden;
    output i_wrdata;
    input o_full;
    input o_empty;
    input o_alm_full;
    input o_alm_empty;
    input o_rddata;
  endclocking

clocking active_mon_cb @(posedge clk);
   default input #0 output #0;
    input i_wren;
    input i_rden;
    input i_wrdata;
  endclocking

 clocking passive_mon_cb @(posedge clk);
    default input #1 output #1;
    input o_full;
    input o_empty;
    input o_alm_full;
   input o_alm_empty;
   input o_rddata;
  endclocking

modport driver_mp (input clk, rstn, clocking driver_cb);
    modport active_mon_mp (input clk, rstn, clocking active_mon_cb);
      modport passive_mon_mp (input clk, rstn, clocking passive_mon_cb);
    
endinterface
