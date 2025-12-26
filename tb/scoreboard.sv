class scoreboard;
    mailbox #(packet) m2s_mb;
    virtual dut_if dut_vif;
    function new(mailbox #(packet) m2s_mb);
        this.m2s_mb = m2s_mb;
    endfunction 
    
    int err_cnt = 0;
    task run();
        packet pkt;
        
        while (1) begin
            m2s_mb.get(pkt);
            $display("#%0t: [Scoreboard] Get packet from monitor: %s : adddr = %b, data = %b", $time, pkt.transfer, pkt.addr, pkt.data);
        end
    endtask
    
    function void report (int error_cnt);
        int total_error = this.err_cnt + error_cnt;

        if (total_error == 0) begin
            $display("#%0t: [Scoreboard] TEST PASSED", $time);
        end else begin 
            $display("#%0t: [Scoreboard] TEST FAILED, number of error: %d", $time, total_error);
        end
    endfunction 

endclass
