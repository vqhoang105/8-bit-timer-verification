class def_val_reg_test extends base_test;
    function new();
        super.new();
    endfunction
    
    bit[7:0] data;
    virtual task run_scenario();
        wait(dut_vif.presetn == 1);
        read(8'h00, data);
        if (data != 0 ) error_cnt ++; 
        read(8'h01, data);
        if (data != 0 ) error_cnt ++;
        read(8'h02, data);
        if (data != 0 ) error_cnt ++;
        read(8'h03, data);
        if (data != 0 ) error_cnt ++;
    endtask

endclass
