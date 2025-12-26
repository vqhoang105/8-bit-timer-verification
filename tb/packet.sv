class packet;
    typedef enum bit {READ=0,WRITE=1} transfer_enum;

    bit[7:0] addr;
    bit[7:0] data;
    transfer_enum transfer;
    
    rand bit[7:0] clock1;
    rand bit[7:0] clock;
    rand bit[7:0] clockd;
    rand bit[7:0] clockd1;

    constraint clock6 {clock1 inside {8'b00000001, 8'b00001001, 8'b00010001, 8'b00011001};}
    constraint clock8 {clockd inside {8'b00000011, 8'b00001011, 8'b00010011, 8'b00011011};}

    constraint clock7 {
    if (clock1 == 8'b00000001){
       clock inside {8'b00001001,8'b00010001, 8'b00011001};
    }    
    else if (clock1 == 8'b00001001){
     clock inside {8'b00000001,8'b00010001, 8'b00011001};
    }
    else if (clock1 == 8'b00010001){
     clock inside {8'b00001001,8'b00000001, 8'b00011001};
    }
    else if (clock1 == 8'b00011001){
     clock inside {8'b00001001,8'b00010001, 8'b00000001};
    }
  }
    
     constraint clock9 {
     if (clockd == 8'b00000011){
        clockd1 inside {8'b00001011,8'b00010011, 8'b00011011};
     }
     else if (clockd == 8'b00001001){
        clockd1 inside {8'b00000011,8'b00010011, 8'b00011011};
     }
     else if (clockd == 8'b00010011){
         clockd1 inside {8'b00001011,8'b00000011, 8'b00011011};
     }
     else if (clockd == 8'b00011001){
      clockd1 inside {8'b00001011,8'b00010011, 8'b00000011};
     }
  }

    function new();
    endfunction

endclass
