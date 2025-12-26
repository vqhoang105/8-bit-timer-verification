class count_up_rand_then_change_to_count_down_interrupt_test extends base_test;

    function new();
        super.new();
    endfunction
    
    bit[7:0] data;
    bit[7:0] tmp;
    virtual task run_scenario();
        wait(dut_vif.presetn == 1);
        //count up with overflow
        tmp = $urandom_range (0,255);
        write (8'h02, tmp);
        write (8'h03, 8'b00000001);
        write (8'h00, 8'b00000100);
        write (8'h00, 8'b00000001);
        read  (8'h01, data);
        #5ns;
        write (8'h00, 8'b00000000);
        write (8'h03, 8'b00000010);
        write (8'h00, 8'b00000011);
        read  (8'h01, data);
        repeat(tmp+1) begin
        #5ns;
        end
        #150ns;
        read (8'h01, data);
        if (data[1] != 1'b1) error_cnt ++;
        $display("%d", error_cnt);
        #100ns;
        if (dut_vif.interrupt !=1) error_cnt ++;
        $display("%d", error_cnt);
        endtask

endclass
