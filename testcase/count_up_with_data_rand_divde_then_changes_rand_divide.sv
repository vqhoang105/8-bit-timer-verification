class count_up_with_data_rand_divde_then_changes_rand_divide extends base_test;

    function new();
        super.new();
    endfunction
    
    bit[7:0] data;
    packet pkt = new(); 
    bit [7:0] tmp;
    bit[7:0] clocku;
    bit[7:0] clocku1;
    virtual task run_scenario();
        if(pkt.randomize())
        clocku  = pkt.clock1;
        clocku1 = pkt.clock;
        wait(dut_vif.presetn == 1);
        tmp = $urandom_range (0,256);
        write (8'h02, tmp);
        write (8'h03, 8'b00000001);
        write (8'h00, 8'b00000100);
        write (8'h00, clocku);
        read  (8'h01, data);
        if (clocku == 8'b00000001) begin
            repeat(256-tmp) begin
                #5ns;
            end
            read  (8'h01, data);
            if (data != 8'h01) error_cnt ++;
            #1000ns;
             if (dut_vif.interrupt != 1) error_cnt ++;
        end else if (clocku == 8'b00011001) begin
            repeat(256-tmp) begin
                #40ns;
            end
            read  (8'h01, data);
            if (data != 8'h01) error_cnt ++;
            #1000ns;
            if (dut_vif.interrupt != 1) error_cnt ++;
        end else if(clocku == 8'b00001001) begin
            repeat(256-tmp) begin
                #10ns;
            end
            read  (8'h01, data);
            if (data != 8'h01) error_cnt ++;
            #1000ns;
            if (dut_vif.interrupt != 1) error_cnt ++;
        end else if(clocku == 8'b00010001) begin
            repeat(256-tmp) begin
                #20ns;
            end
            read  (8'h01, data);
            if (data != 8'h01) error_cnt ++;
            #1000ns;
            if (dut_vif.interrupt != 1) error_cnt ++;
        end
        tmp = $urandom_range (0,256);
        write (8'h02, tmp);
        write (8'h00, 8'b00000100);
        write (8'h00, clocku1);
        if (clocku1 == 8'b00000001) begin
         repeat(256-tmp) begin
          #5ns;
          end
          read  (8'h01, data);
          if (data != 8'h01) error_cnt ++;
          #1000ns;
          if (dut_vif.interrupt != 1) error_cnt ++;
         end else if (clocku1 == 8'b00011001) begin
         repeat(256-tmp) begin
          #40ns;
          end
          read  (8'h01, data);
          if (data != 8'h01) error_cnt ++;
          #1000ns;
          if (dut_vif.interrupt != 1) error_cnt ++;
         end else if(clocku1 == 8'b00001001) begin
         repeat(256-tmp) begin
          #10ns;
          end
          read  (8'h01, data);
          if (data != 8'h01) error_cnt ++;
          #1000ns;
          if (dut_vif.interrupt != 1) error_cnt ++;
         end else if(clocku1 == 8'b00010001) begin
         repeat(256-tmp) begin
          #20ns;
          end
          read  (8'h01, data);
          if (data != 8'h01) error_cnt ++;
          #1000ns;
          if (dut_vif.interrupt != 1) error_cnt ++;
         end
        endtask
endclass
