class count_down_with_rand_divde_then_changes_rand_divide extends base_test;

    function new();
        super.new();
    endfunction
    
    bit[7:0] data;
    packet pkt = new(); 
    bit [7:0] tmp;
    bit[7:0] tmp1;
    virtual task run_scenario();
        if(pkt.randomize())
        tmp  = pkt.clockd;
        tmp1 = pkt.clockd1;
        wait(dut_vif.presetn == 1);
        write (8'h02, 8'd255);
        write (8'h03, 8'b00000010);
        write (8'h00, 8'b00000100);
        write (8'h00, tmp);
        read  (8'h01, data);
        if (tmp == 8'b00000011) begin
            #1285ns;                                                
            read  (8'h01, data);                                                  
            if (data != 8'h02) error_cnt ++;                                         
                #1000ns;                                                        
            if (dut_vif.interrupt != 1) error_cnt ++;
        end else if (tmp == 8'b00011011) begin
            #10400ns;                
            read  (8'h01, data);                                                   
            if (data != 8'h02) error_cnt ++;                                         
                 #1000ns;                                                                    
            if (dut_vif.interrupt != 1) error_cnt ++; 
        end else if(tmp == 8'b00001011) begin
            #2600ns;                                                                
            read  (8'h01, data);                                                    
            if (data != 8'h02) error_cnt ++;                                          
                #1000ns;                                                                  
            if (dut_vif.interrupt != 1) error_cnt ++; 
        end else if(tmp == 8'b00010011) begin
            #5500ns;                                                      
            read  (8'h01, data);                                                      
            if (data != 8'h02) error_cnt ++;                                          
                #1000ns;                                                                    
            if (dut_vif.interrupt != 1) error_cnt ++;      
        end
        //change divide 2
        write (8'h00, tmp1);
        if (tmp1 == 8'b00000011) begin
            #1285ns;
             read  (8'h01, data);
             if (data != 8'h02) error_cnt ++;
                 #1000ns;
             if (dut_vif.interrupt != 1) error_cnt ++;
        end else if (tmp1 == 8'b00011011) begin
             #10400ns;            
             read  (8'h01, data);     
             if (data != 8'h02) error_cnt ++;                                       
                  #1000ns;                                                             
             if (dut_vif.interrupt != 1) error_cnt ++;                                   
        end else if(tmp1 == 8'b00001011) begin
            #2600ns;           
            read  (8'h01, data);
             if (data != 8'h02) error_cnt ++;                                        
                 #1000ns;                                                              
             if (dut_vif.interrupt != 1) error_cnt ++;                                 
        end else if(tmp1 == 8'b00010011) begin
             #5500ns;           
             read  (8'h01, data);
             if (data != 8'h02) error_cnt ++;
                 #1000ns;                     
             if (dut_vif.interrupt != 1) error_cnt ++;
        end

        endtask
endclass
