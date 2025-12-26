class R_and_W_value_check extends base_test;

    function new();
        super.new();
    endfunction
    
    bit[7:0] data;
    virtual task run_scenario();
        wait(dut_vif.presetn == 1);
        write (8'h00, 8'hff);
        read(8'h00, data);
        if (data != 8'h1f) error_cnt ++;
        write (8'h01, 8'hff);
        read(8'h01, data);
        if (data != 8'h02) error_cnt ++;
        write (8'h02, 8'hff);
        read(8'h02, data);
        if (data != 8'hff) error_cnt ++;
        write (8'h03, 8'hff);
        read(8'h03, data);
        if (data != 8'h03) error_cnt ++;
        $display("%d", error_cnt);
    endtask

endclass
