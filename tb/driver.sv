class driver;
    mailbox #(packet) s2d_mb;
    event done;    
    virtual dut_if dut_vif;

    function new(mailbox #(packet) s2d_mb, virtual dut_if dut_vif);
        this.s2d_mb = s2d_mb;
        this.dut_vif = dut_vif;
    endfunction

    task run;
        packet pkt;
        while (1) begin
            s2d_mb.get(pkt);
            $display ("#%0t: [Driver] Get packet from stimulus", $time);
            @(posedge dut_vif.pclk);
            dut_vif.paddr   = pkt.addr;
            dut_vif.pwdata  = pkt.data;
            dut_vif.pwrite  = pkt.transfer;
            dut_vif.psel    = 1'b1;
            @(posedge dut_vif.pclk);
            dut_vif.penable = 1'b1;
            @(posedge dut_vif.pclk);
            dut_vif.paddr   = 2'b00;;
            dut_vif.pwdata  = 8'h00;
            dut_vif.pwrite  = 1'b0;
            dut_vif.psel    = 1'b0;
            dut_vif.penable = 1'b0;
            -> done;
        end
    endtask

endclass
