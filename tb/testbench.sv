`timescale 1ns/1ps

module testbench; 
  import timer_pkg::*;
  import test_pkg::*;
 
  dut_if d_if();

  timer_top u_dut(
    .ker_clk(d_if.ker_clk),       
    .pclk(d_if.pclk),       
    .presetn(d_if.presetn),    
    .psel(d_if.psel),       
    .penable(d_if.penable),    
    .pwrite(d_if.pwrite),     
    .paddr(d_if.paddr),      
    .pwdata(d_if.pwdata),     
    .prdata(d_if.prdata),     
    .pready(d_if.pready),     
    .interrupt(d_if.interrupt));

  bit[7:0] reg_TDR;
    
  timer_counter u_dut1(
   .pclk(d_if.pclk),
   .presetn(d_if.presetn),
   .clk_in (clk_in),
   .s_ovf (s_ovf),
   .s_udf (s_udf));
  

  
  initial begin
    d_if.presetn = 0;
    #100ns d_if.presetn = 1;
  end

  // 50 MHz
  initial begin
    d_if.pclk = 0;
    forever begin 
      #10ns;
      d_if.pclk = ~d_if.pclk;
    end
  end
 
  // 200 MHz
  initial begin
    d_if.ker_clk = 1;
    forever begin 
      #2.5ns;
      d_if.ker_clk = ~d_if.ker_clk;
    end
  end
  
  //fake cnt
  bit [7:0] cnt;
  initial begin
  cnt = 0;
  end
    
  always @(negedge d_if.penable) begin
    if (d_if.paddr == 8'h01) begin
        cnt = d_if.pwdata;
    end else if (d_if.paddr == 8'h00 && d_if.pwdata[1:0] == 01) begin
        @(posedge clk_in);
        cnt = cnt + 1;
    end else if (d_if.paddr == 8'h00 && d_if.pwdata[1:0] == 11) begin
        @(posedge clk_in);
        cnt = cnt - 1;
    end else cnt = 0;
  end
  
  initial begin
    d_if.ker_clk   = 0;
    d_if.pclk      = 0;
    d_if.presetn   = 0;
    d_if.psel      = 0;
    d_if.penable   = 0;
    d_if.pwrite    = 0;
    d_if.paddr     = 0;
    d_if.pwdata    = 0;
  end



  //addwaveform
  logic ker_clk;
  logic pclk;
  logic presetn;
  logic psel;
  logic penable;
  logic pwrite;
  logic[7:0] paddr;
  logic[7:0] pwdata;
  logic[7:0] prdata;
  logic pready;
  logic interrupt;


  assign pclk      = d_if.pclk;
  assign ker_clk   = d_if.ker_clk;
  assign presetn   = d_if.presetn;
  assign paddr     = d_if.paddr;
  assign pwrite    = d_if.pwrite;
  assign psel      = d_if.psel;
  assign penable   = d_if.penable;
  assign pwdata    = d_if.pwdata;
  assign pready    = d_if.pready;
  assign prdata    = d_if.prdata;
  assign interrupt = d_if.interrupt;
  assign s_ovf     = u_dut1.s_ovf;
  assign s_udf     = u_dut1.s_udf;

  initial begin
    #1ms;
    $display("[testbench] Time out....Seems your tb is hang!");
    $finish;
  end
  
  //Assertion
  sequence apb_write_seq;
    d_if.penable ##1
    !d_if.psel && !d_if.penable;
  endsequence

  property apb_write_check;
    @(posedge d_if.pclk) d_if.psel && !d_if.penable && d_if.pwrite |=> apb_write_seq;
  endproperty

  assert property(apb_write_check)
    $display("%0t: Assertion pass", $time);
  else
    $display("Assertion fail");

 

  //Polymophisrm        
  base_test                                                             bt             = new ();
  count_up_0_nod_interrupt_test                                         cu0nd          = new ();
  def_val_reg_test                                                      dvrt           = new ();
  R_and_W_value_check                                                   rawvc          = new ();
  reset_on_the_fly_check                                                rotfc          = new ();
  RW1C_check                                                            rw1c           = new ();
  reserved_register_check                                               rrc            = new ();
  count_up_0_d2_interrupt_test                                          cu0d2          = new ();
  count_up_0_d4_interrupt_test                                          cu0d4          = new ();
  count_up_0_d8_interrupt_test                                          cu0d8          = new ();
  count_down_255_nod_interrupt_test                                     cdnd           = new ();
  count_down_255_d2_interrupt_test                                      cdd2           = new ();
  count_down_255_d4_interrupt_test                                      cdd4           = new ();
  count_down_255_d8_interrupt_test                                      cdd8           = new ();
  count_up_rand_nod_interrupt_test                                      curnd          = new ();
  count_up_rand_d2_interrupt_test                                       curd2          = new ();
  count_up_rand_d4_interrupt_test                                       curd4          = new ();
  count_up_rand_d8_interrupt_test                                       curd8          = new ();
  count_down_rand_nod_interrupt_test                                    cdrnd          = new ();
  count_down_rand_d2_interrupt_test                                     cdrd2          = new ();
  count_down_rand_d4_interrupt_test                                     cdrd4          = new ();
  count_down_rand_d8_interrupt_test                                     cdrd8          = new ();
  count_up_0_then_change_the_counter_at_the_middle_interrupt_test       cu0ndtctctatm  = new ();
  count_up_0_then_change_to_count_down_interrupt_test                   cu0tctcd       = new ();
  count_up_rand_then_change_to_count_down_interrupt_test                curtctcd       = new ();
  count_down_255_then_change_the_counter_at_the_middle_interrupt_test   cdndtctctatm   = new ();
  count_down_255_then_change_to_count_up_interrupt_test                 cdtctcd        = new ();
  count_down_rand_then_change_to_count_up_interrupt_test                cdrtctcu       = new ();
  count_down_with_data_change_divide_at_the_middle_test                 cdwdcdatm      = new ();
  count_down_with_out_data_change_divide_at_the_middle_test             cdwodcdatm     = new ();
  count_up_with_data_change_divide_at_the_middle_test                   cuwdcdatm      = new ();
  count_up_with_out_data_change_divide_at_the_middle_test               cuwodcdatm     = new ();
  count_down_with_data_changes_divide_at_the_middle_then_count_up       cdwdcdatmtcu   = new ();
  count_down_with_out_data_changes_divide_at_the_middle_then_count_up   cdwodcdatmtcu  = new ();
  count_up_with_data_changes_divide_at_the_middle_then_count_down       cuwdcdatmtcd   = new ();
  count_up_with_out_data_changes_divide_at_the_middle_then_count_down   cuwodcdatmtcd  = new ();
  count_up_with_rand_divde_then_changes_rand_divide                     cuwrdtcrd      = new ();
  count_up_with_data_rand_divde_then_changes_rand_divide                cuwdrdtcrd     = new ();
  count_down_with_rand_divde_then_changes_rand_divide                   cdwrdtcrd      = new ();
  count_down_with_data_rand_divde_then_changes_rand_divide              cdwdrdtcrd     = new ();


  initial begin
    if($test$plusargs("def_val_reg_test")) begin
        $display("%0t: [Testbench] Run def_val_reg_test", $time);
        bt = dvrt;
    end
    if($test$plusargs("R_and_W_value_check")) begin
        $display("%0t: [Testbench] Run_R_and_W_value_check", $time);
        bt = rawvc;
    end
    if($test$plusargs("reset_on_the_fly_check")) begin
        $display("%0t: [Testbench] reset_on_the_fly_check", $time);
        bt = rotfc;
    end
    if($test$plusargs("RW1C_check")) begin
        $display("%0t: [Testbench] RW1C_check", $time);
        bt = rw1c;
    end
    if($test$plusargs("reserved_register_check")) begin
        $display("%0t: [Testbench] reserved_register_check", $time);
        bt = rrc;
    end
    if($test$plusargs("count_up_0_nod_interrupt_test")) begin
        $display("%0t: [Testbench] count_up_0_nod_interrupt_test", $time);
        bt = cu0nd;
    end
    if($test$plusargs("count_up_0_d2_interrupt_test")) begin
        $display("%0t: [Testbench] count_up_0_d2_interrupt_test", $time);
        bt = cu0d2;
    end
    if($test$plusargs("count_up_0_d4_interrupt_test")) begin
        $display("%0t: [Testbench] count_up_0_d4_interrupt_test", $time);
        bt = cu0d4;
    end
    if($test$plusargs("count_up_0_d8_interrupt_test")) begin
        $display("%0t: [Testbench] count_up_0_d8_interrupt_test", $time);
        bt = cu0d8;
    end
    if($test$plusargs("count_down_255_nod_interrupt_test")) begin
        $display("%0t: [Testbench] count_down_255_nod_interrupt_test", $time);
        bt = cdnd;
    end
    if($test$plusargs("count_down_255_d2_interrupt_test")) begin
        $display("%0t: [Testbench] count_down_255_d2_interrupt_test", $time);
        bt = cdd2;
    end
    if($test$plusargs("count_down_255_d4_interrupt_test")) begin
        $display("%0t: [Testbench] count_down_255_d4_interrupt_test", $time);
        bt = cdd4;
    end
    if($test$plusargs("count_down_255_d8_interrupt_test")) begin
        $display("%0t: [Testbench] count_down_255_d8_interrupt_test", $time);
        bt = cdd8;
    end
    if($test$plusargs("count_up_rand_nod_interrupt_test")) begin
        $display("%0t: [Testbench] count_up_rand_nod_interrupt_test", $time);
        bt = curnd;
    end
    if($test$plusargs("count_up_rand_d2_interrupt_test")) begin
        $display("%0t: [Testbench] count_up_rand_d2_interrupt_test", $time);
        bt = curd2;
    end
    if($test$plusargs("count_up_rand_d4_interrupt_test")) begin
        $display("%0t: [Testbench] count_up_rand_d4_interrupt_test", $time);
        bt = curd4;
    end
    if($test$plusargs("count_up_rand_d8_interrupt_test")) begin
        $display("%0t: [Testbench] count_up_rand_d8_interrupt_test", $time);
        bt = curd8;
    end
    if($test$plusargs("count_down_rand_nod_interrupt_test")) begin
       $display("%0t: [Testbench] count_down_rand_nod_interrupt_test", $time);
        bt = cdrnd;
    end
    if($test$plusargs("count_down_rand_d2_interrupt_test")) begin
        $display("%0t: [Testbench] count_down_rand_d2_interrupt_test", $time);
        bt = cdrd2;
    end
    if($test$plusargs("count_down_rand_d4_interrupt_test")) begin
        $display("%0t: [Testbench] count_down_rand_d4_interrupt_test", $time);
        bt = cdrd4;
    end
    if($test$plusargs("count_down_rand_d8_interrupt_test")) begin
        $display("%0t: [Testbench] count_down_rand_d8_interrupt_test", $time);
        bt = cdrd8;
    end
    if($test$plusargs("count_up_0_then_change_the_counter_at_the_middle_interrupt_test")) begin
        $display("%0t: [Testbench] count_up_0_then_change_the_counter_at_the_middle_interrupt_test", $time);
        bt = cu0ndtctctatm;
    end
    if($test$plusargs("count_up_0_then_change_to_count_down_interrupt_test")) begin
       $display("%0t: [Testbench] count_up_0_then_change_to_count_down_interrupt_test", $time);
       bt = cu0tctcd;
    end
    if($test$plusargs("count_up_rand_then_change_to_count_down_interrupt_test")) begin
       $display("%0t: [Testbench]  count_up_rand_then_change_to_count_down_interrupt_test", $time);
       bt = curtctcd;
    end
    if($test$plusargs("count_down_255_then_change_the_counter_at_the_middle_interrupt_test")) begin
       $display("%0t: [Testbench] count_down_255_then_change_the_counter_at_the_middle_interrupt_test", $time);
       bt = cdndtctctatm;
    end
    if($test$plusargs("count_down_255_then_change_to_count_up_interrupt_test")) begin
       $display("%0t: [Testbench] count_down_255_then_change_to_count_up_interrupt_test", $time);
       bt = cdtctcd;
    end
    if($test$plusargs("count_down_rand_then_change_to_count_up_interrupt_test")) begin
       $display("%0t: [Testbench]  count_down_rand_then_change_to_count_up_interrupt_test", $time);
       bt = cdrtctcu;
    end
    if($test$plusargs("count_down_with_data_change_divide_at_the_middle_test")) begin
       $display("%0t: [Testbench]  count_down_with_data_change_divide_at_the_middle_test", $time);
       bt = cdwdcdatm;
    end
    if($test$plusargs("count_down_with_out_data_change_divide_at_the_middle_test")) begin
       $display("%0t: [Testbench]  count_down_with_data_change_divide_at_the_middle_test", $time);
       bt = cdwodcdatm;
    end
    if($test$plusargs("count_up_with_data_change_divide_at_the_middle_test")) begin
       $display("%0t: [Testbench]  count_up_with_data_change_divide_at_the_middle_test", $time);
       bt = cuwdcdatm;
    end
    if($test$plusargs("count_up_with_out_data_change_divide_at_the_middle_test")) begin
       $display("%0t: [Testbench]  count_up_with_out_data_change_divide_at_the_middle_test", $time);
       bt = cuwodcdatm;
    end
    if($test$plusargs("count_down_with_data_changes_divide_at_the_middle_then_count_up")) begin
       $display("%0t: [Testbench] count_down_with_data_changes_divide_at_the_middle_then_count_up", $time);
       bt = cdwdcdatmtcu;
    end
    if($test$plusargs("count_down_with_out_data_changes_divide_at_the_middle_then_count_up")) begin
       $display("%0t: [Testbench] count_down_with_out_data_changes_divide_at_the_middle_then_count_up", $time);
       bt = cdwodcdatmtcu;
    end
    if($test$plusargs("count_up_with_data_changes_divide_at_the_middle_then_count_down")) begin
       $display("%0t: [Testbench] count_up_with_data_changes_divide_at_the_middle_then_count_down", $time);
       bt = cuwdcdatmtcd;
    end
    if($test$plusargs("count_up_with_out_data_changes_divide_at_the_middle_then_count_down")) begin
       $display("%0t: [Testbench] count_up_with_out_data_changes_divide_at_the_middle_then_count_down", $time);
       bt = cuwodcdatmtcd;
    end
    if($test$plusargs("count_up_with_rand_divde_then_changes_rand_divide")) begin
       $display("%0t: [Testbench] count_up_with_rand_divde_then_changes_rand_divide", $time);
       bt = cuwrdtcrd;
    end
    if($test$plusargs("count_up_with_data_rand_divde_then_changes_rand_divide")) begin
       $display("%0t: [Testbench] count_up_with_data_rand_divde_then_changes_rand_divide", $time);
       bt = cuwdrdtcrd ;
    end
    if($test$plusargs("count_down_with_rand_divde_then_changes_rand_divide")) begin
       $display("%0t: [Testbench] count_down_with_rand_divde_then_changes_rand_divide", $time);
       bt = cdwrdtcrd;
    end
    if($test$plusargs("count_down_with_data_rand_divde_then_changes_rand_divide")) begin
       $display("%0t: [Testbench] count_down_with_data_rand_divde_then_changes_rand_divide", $time);
       bt = cdwdrdtcrd;
    end



  bt.dut_vif = d_if;
  bt.run_test();

  end

endmodule
