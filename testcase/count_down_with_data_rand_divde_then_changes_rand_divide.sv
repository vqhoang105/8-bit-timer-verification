class count_down_with_data_rand_divde_then_changes_rand_divide extends base_test;

    function new();
        super.new();
    endfunction
    
    bit[7:0] data;
    packet pkt = new(); 
    bit [7:0] tmp;
    bit[7:0] clockd;
    bit[7:0] clockd1;
    virtual task run_scenario();
        if(pkt.randomize())
        clockd  = pkt.clockd;
        clockd1 = pkt.clockd1;
        wait(dut_vif.presetn == 1);
        tmp = $urandom_range (0,256);
        //count up with overflow
        write (8'h02, tmp);
        write (8'h03, 8'b00000010);
        write (8'h00, 8'b00000100);
        write (8'h00, clockd);
        read  (8'h01, data);
        if (clockd == 8'b00000011) begin
        repeat(tmp) begin
         #5ns;
         end
         read  (8'h01, data);
         if (data != 8'h02) error_cnt ++;
         #100ns;
         if (dut_vif.interrupt != 1) error_cnt ++;
        end else if (clockd == 8'b00011011) begin
         repeat(tmp) begin
         #40ns;
         end
         read  (8'h01, data);
         if (data != 8'h02) error_cnt ++;
         #85ns;
         if (dut_vif.interrupt != 1) error_cnt ++;
        end else if(clockd == 8'b00001011) begin
         repeat(tmp) begin
         #10ns;
         end
         read  (8'h01, data);
         if (data != 8'h02) error_cnt ++;
         #100ns;
         if (dut_vif.interrupt != 1) error_cnt ++;
        end else if(clockd == 8'b00010011) begin
         repeat(tmp) begin
         #20ns;
         end
         read  (8'h01, data);
         if (data != 8'h02) error_cnt ++;
         #45ns;
         if (dut_vif.interrupt != 1) error_cnt ++;
        end
        //change divide 2
        tmp = $urandom_range (0,256);
        write (8'h02, tmp);
        write (8'h03, 8'b00000010);
        write (8'h00, 8'b00000100);
        write (8'h00, clockd1);
        if (clockd1 == 8'b00000011) begin
         repeat(tmp) begin
          #5ns;
          end
          read  (8'h01, data);
          if (data != 8'h02) error_cnt ++;
          #100ns;
          if (dut_vif.interrupt != 1) error_cnt ++;
         end else if (clockd1 == 8'b00011011) begin
         repeat(tmp) begin
          #40ns;
          end
          read  (8'h01, data);
          if (data != 8'h02) error_cnt ++;
          #85ns;
          if (dut_vif.interrupt != 1) error_cnt ++;
         end else if(clockd1 == 8'b00001011) begin
         repeat(tmp) begin
          #10ns;
          end
          read  (8'h01, data);
          if (data != 8'h02) error_cnt ++;
          #100ns;
          if (dut_vif.interrupt != 1) error_cnt ++;
         end else if(clockd1 == 8'b00010011) begin
         repeat(256-tmp) begin
          #20ns;
          end
          read  (8'h01, data);
          if (data != 8'h02) error_cnt ++;
          #45ns;
          if (dut_vif.interrupt != 1) error_cnt ++;
         end
        write (8'h01, 8'b00000010);
        read (8'h01, data);
        if (data != 0) error_cnt ++;
        #15ns;
        if (dut_vif.interrupt != 0) error_cnt ++;
     endtask
endclass
