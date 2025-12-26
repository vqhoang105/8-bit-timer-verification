class count_down_255_d8_interrupt_test extends base_test;

    function new();
        super.new();
    endfunction
    
    bit[7:0] data;
    virtual task run_scenario();
        wait(dut_vif.presetn == 1);
        //count up with overflow
        write (8'h02, 8'd255);
        write (8'h03, 8'b00000010);
        write (8'h00, 8'b00000100);
        write (8'h00, 8'b00011011);
        read  (8'h01, data);
        #10280ns;
        read  (8'h01, data);
        if (data != 8'h02) error_cnt ++;
        #160ns;
        if (dut_vif.interrupt != 1) error_cnt ++;
        write (8'h03, 8'b00000000);
        #350ns;
        read (8'h03, data);
        if (data  != 0) error_cnt ++;
        write (8'h03, 8'b00000010);
        #10280ns;
        read (8'h03, data);
        if (data  != 8'h02) error_cnt ++;
    endtask

endclass
