module router_reg(clock, resetn, pkt_valid, data_in, fifo_full,
		  detect_add, ld_state, laf_state,full_state, lfd_state, rst_int_reg,
		  err, parity_done, low_packet_valid, dout);


    input clock, resetn, pkt_valid, fifo_full, detect_add,
        ld_state, laf_state,full_state, lfd_state, rst_int_reg;

    input [7:0] data_in;


    output reg err, parity_done, low_packet_valid;
    output reg [7:0] dout;

    reg [7:0] header_reg, full_reg, parity_reg, packet_parity;


                    
    ////////////////RESET AND PARITY DONE\\\\\\\\\\\\\\\\\\

    always@(posedge clock)    
    begin
        if(~resetn)
            begin
            //dout<= 8'd0;
            //err<= 1'd0;
            parity_done<= 1'd0;
            //low_pkt_valid<= 1'd0;
            end
        else
            begin
            if((ld_state && ~fifo_full && ~pkt_valid) || (laf_state && low_packet_valid && ~parity_done))
            parity_done<=1'd1;
                else if(detect_add)
            parity_done<= 1'd0;
            end
    end


    ///////////////LOW PACKET VALID\\\\\\\\\\\\\\\\\\\\

    always@(posedge clock)
    begin
        if(~resetn)
            low_packet_valid<= 1'd0;
        else if(~pkt_valid && ld_state)
            low_packet_valid<= 1'd1;
        else if(rst_int_reg)
            low_packet_valid<= 1'd0;
    end


    //////////////////////HEADER BYTE LOGIC\\\\\\\\\\\\\\\\\\\\\

    always@(posedge clock)
    begin

        if(~resetn)
            begin
            dout<= 0;
            header_reg<= 8'd0;
            full_reg<= 8'd0;
            end

        else if(detect_add && pkt_valid)
            header_reg<= data_in;

        else if(lfd_state)
            dout<= header_reg;
            
        else if(ld_state && (~fifo_full))
            dout<= data_in;

        else if(ld_state && fifo_full)
            full_reg<= data_in;

        else if(laf_state)
            dout<= full_reg;

    end
        

    ////////////////PARITY CALC\\\\\\\\\\\\\\\\\\\\\
    always@(posedge clock)
    begin
        if(~resetn)
            parity_reg<= 8'd0;
        else if(detect_add)
        parity_reg<=0;
        else if(lfd_state && pkt_valid)
            parity_reg<= parity_reg ^ header_reg;
        else if(full_state==0 && ld_state && pkt_valid)
            parity_reg<= parity_reg ^ data_in; 
    end

    ////////////////////////ERR\\\\\\\\\\\\\\\\\\\\\\\\

    always@(posedge clock)
    begin
        if(~resetn)
            err<=1'd0;
        else
            
            if(parity_done)
            begin
                if(packet_parity == parity_reg)
                err<= 1'd0;
                else 
                err<= 1'd1;
            end
            else 
            err<=1'd0;
        
    end


    /////////////////////PACKET_PARITY\\\\\\\\\\\\\\\\\\\\\\\\\

    always@(posedge clock)
    begin
        if(~resetn)
            packet_parity<= 8'd0;
        else if(detect_add)
        packet_parity<=0;
        else if((~fifo_full && ~pkt_valid) || (~parity_done && low_packet_valid))
            packet_parity<= data_in;
    end

endmodule
