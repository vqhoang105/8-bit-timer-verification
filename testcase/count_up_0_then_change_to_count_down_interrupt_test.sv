class count_up_0_then_change_to_count_down_interrupt_test extends base_test;

    function new();
        super.new();
    endfunction
    
    bit[7:0] data;
    bit[7:0] tmp;
    virtual task run_scenario();
        wait(dut_vif.presetn == 1);
        //count up with overflow
        write (8'h02, 8'd0);
        write (8'h03, 8'b00000001);
        write (8'h00, 8'b00000100);
        write (8'h00, 8'b00000001);
        #1285ns;
        read  (8'h01, data);
        if (data != 8'h01) error_cnt ++;
        #490ns;
        if (dut_vif.interrupt != 1) error_cnt ++;
        write (8'h00, 8'b00000000);
        write (8'h03, 8'b00000010);
        write (8'h00, 8'b00000011);
        read  (8'h01, data);
        #600ns;
        read  (8'h01, data);
        if (data != 8'h03) error_cnt ++;
        #50ns;
        if (dut_vif.interrupt != 1) error_cnt ++;
        write (8'h01, 8'h03);
        read  (8'h01, data);
        if (data != 8'h00) error_cnt ++;
        #20ns;
        if (dut_vif.interrupt != 0) error_cnt ++;
    endtask

endclass
