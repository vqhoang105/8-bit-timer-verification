class count_down_rand_nod_interrupt_test extends base_test;

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
        write (8'h03, 8'b00000010);
        write (8'h00, 8'b00000100);
        write (8'h00, 8'b00000011);
        read  (8'h01, data);
        repeat(tmp) begin
        #5ns;
        end
        read  (8'h01, data);
        if (data != 8'h02) error_cnt ++;
        #15ns;
        if (dut_vif.interrupt != 1) error_cnt ++;
        write (8'h03, 8'b00000000);
        repeat(tmp) begin
        #5ns;
        end
        read (8'h03, data);
        if (data != 0) error_cnt ++;
        #15ns;
        if (dut_vif.interrupt != 0) error_cnt ++;
        write (8'h03, 8'b00000010);

 


        endtask
endclass
