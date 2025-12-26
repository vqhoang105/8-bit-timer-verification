class count_up_rand_d4_interrupt_test extends base_test;

    function new();
        super.new();
    endfunction
    
    bit[7:0] data;
    bit[7:0] tmp;
    virtual task run_scenario();
        wait(dut_vif.presetn == 1);
        //count up with overflow
        tmp = $urandom_range (0,256);
        write (8'h02, tmp);
        write (8'h03, 8'b00000001);
        write (8'h00, 8'b00000100);
        write (8'h00, 8'b00010001);
        read  (8'h01, data);
        repeat(256-tmp) begin
        #20ns;
        end
        read  (8'h01, data);
        if (data != 8'h01) error_cnt ++;
        $display("%d", error_cnt);
        #45ns;
        if (dut_vif.interrupt != 1) error_cnt ++;
        write (8'h03, 8'b00000000);
        repeat(256-tmp) begin
        #20ns;
        end
        #45ns;
        if (dut_vif.interrupt != 0) error_cnt ++;
        write (8'h03, 8'b00000001);
        endtask

endclass
