class monitor;
    mailbox #(packet) m2s_mb;
    virtual dut_if dut_vif;

    function new(mailbox #(packet) m2s_mb, virtual dut_if dut_vif);
        this.m2s_mb  = m2s_mb;
        this.dut_vif = dut_vif;
    endfunction

    task run();
        packet pkt;
        while (1) begin
            pkt = new();
            @(posedge dut_vif.penable);
            if (dut_vif.pwrite == 1) begin
                pkt.data     = dut_vif.pwdata;
                pkt.addr     = dut_vif.paddr;
                pkt.transfer = packet::WRITE;
            end else if (dut_vif.pwrite == 0) begin
                pkt.data     = dut_vif.prdata;
                pkt.addr     = dut_vif.paddr;
                pkt.transfer = packet::READ;
            end
    $display("#%0t: [Monitor] Captured APB transaction", $time);
    m2s_mb.put(pkt);
    end
    endtask

endclass

