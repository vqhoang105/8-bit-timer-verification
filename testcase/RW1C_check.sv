class RW1C_check extends base_test;

    function new();
        super.new();
    endfunction
    
    bit[7:0] data;
    virtual task run_scenario();
        wait(dut_vif.presetn == 1);
        //count up with overflow
        write (8'h02, 8'd250);
        write (8'h00, 8'b00000100);
        write (8'h03, 8'b00000001);
        write (8'h00, 8'b00000001);
        #45ns;
        read  (8'h01, data);
        write (8'h01, 8'b00000001);
        read  (8'h01, data);
        if (data != 8'h00) error_cnt ++;
        //count down with underflow
        write (8'h02, 8'd5);
        write (8'h00, 8'b00000110);
        write (8'h03, 8'b00000010);
        write (8'h00, 8'b00000011);
        #45ns
        read  (8'h01, data);
        write (8'h01, 8'b00000010);
        read  (8'h01, data);
        if (data != 8'h00) error_cnt ++;


    endtask

endclass
