class reset_on_the_fly_check extends base_test;

    function new();
        super.new();
    endfunction
    
    bit[7:0] data;
    virtual task run_scenario();
        wait(dut_vif.presetn == 1);
        write (8'h02, 8'd250);
        write (8'h00, 8'b00000100);
        write (8'h03, 8'b00000001);
        write (8'h00, 8'b00000011);
        read(8'h02, data); 
        read(8'h03, data); 
        read(8'h00, data);
        #75ns;
        dut_vif.presetn = 0;
        read(8'h02, data);
        if (data != 8'h00) error_cnt ++;
        read(8'h03, data);
        if (data != 8'h00) error_cnt ++;
        read(8'h00, data);
        if (data != 8'h00) error_cnt ++;


    endtask

endclass
