class count_up_with_out_data_change_divide_at_the_middle_test extends base_test;


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
        repeat(10) begin
        #5ns;
        end
        read  (8'h01, data);
        if (data != 8'h00) error_cnt ++;
        #5ns;
        if (dut_vif.interrupt != 0) error_cnt ++;
        #1300ns;
        //change divide 2
        write (8'h00, 8'b00001001);
        repeat(256) begin
        #10ns;
        end
        read (8'h01, data);
        if (data != 8'h01) error_cnt ++;
        //overflow disbale
        write (8'h01, 8'b00000001);
        read (8'h01, data);
        if (data != 0) error_cnt ++;
        #15ns;
        if (dut_vif.interrupt != 0) error_cnt ++;
        endtask
endclass
