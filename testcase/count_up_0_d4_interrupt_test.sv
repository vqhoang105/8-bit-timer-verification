class count_up_0_d4_interrupt_test extends base_test;

    function new();
        super.new();
    endfunction
    
    bit[7:0] data;
    virtual task run_scenario();
        wait(dut_vif.presetn == 1);
        //count up with overflow
        write (8'h00, 8'b00010000);
        write (8'h03, 8'b00000001);
        write (8'h02, 8'd0);
        write (8'h00, 8'b00010100);
        write (8'h00, 8'b00010000);
        write (8'h00, 8'b00010001);
        read  (8'h01, data);
        #5500ns;
        read  (8'h01, data);
        if (data != 8'h01) error_cnt ++;
        #100ns;
        if (dut_vif.interrupt != 1) error_cnt ++;
        #5500ns;
        write (8'h03, 8'b00000000);
        #100ns;
        if(dut_vif.interrupt != 0) error_cnt ++;
        write (8'h03, 8'b00000001);
    endtask

endclass
