class reserved_register_check extends base_test;

    function new();
        super.new();
    endfunction
    
    bit[7:0] data;
    bit[7:0] tmp;
    virtual task run_scenario();
        wait(dut_vif.presetn == 1);
        tmp =  $urandom_range(8'b00000100, 8'b11111111);
        write (tmp, tmp);
        read(tmp, data);
        if (data != 8'h00) error_cnt ++;
    endtask

endclass
