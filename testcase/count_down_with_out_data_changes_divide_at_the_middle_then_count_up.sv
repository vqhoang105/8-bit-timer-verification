class count_down_with_out_data_changes_divide_at_the_middle_then_count_up extends base_test;

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
        write (8'h00, 8'b00000011);
        read  (8'h01, data);
        repeat(255) begin
        #5ns;
        end
        read  (8'h01, data);
        if (data != 8'h02) error_cnt ++;
        #5ns;
        if (dut_vif.interrupt != 1) error_cnt ++;
        write (8'h00, 8'b00001001);
        repeat(256) begin
        #10ns;
        end
        read (8'h01, data);
        if (data != 8'h03) error_cnt ++;
        //overflow disbale
        write (8'h01, 8'b00000011);
        read (8'h01, data);
        if (data != 0) error_cnt ++;
        #15ns;
        if (dut_vif.interrupt != 0) error_cnt ++;
        endtask
endclass
