class count_up_with_out_data_changes_divide_at_the_middle_then_count_down extends base_test;

    function new();
        super.new();
    endfunction
    
    bit[7:0] data;
    virtual task run_scenario();
        wait(dut_vif.presetn == 1);
        write (8'h02, 8'd0);
        write (8'h03, 8'b00000001);
        write (8'h00, 8'b00000100);
        write (8'h00, 8'b00000001);
        read  (8'h01, data);
        repeat(255) begin
        #5ns;
        end
        read  (8'h01, data);
        if (data != 8'h01) error_cnt ++;
        #15ns;
        if (dut_vif.interrupt != 1) error_cnt ++;
        #1300ns;
        //divide 2
        write (8'h00, 8'b00001011);
        repeat(256) begin
        #10ns;
        end
        read (8'h01, data);
        if (data != 8'h03) error_cnt ++;
        //overflow,underflow disbale
        write (8'h01, 8'b00000011);
        read (8'h01, data);
        if (data != 0) error_cnt ++;
        #15ns;
        if (dut_vif.interrupt != 0) error_cnt ++;
        endtask
endclass
