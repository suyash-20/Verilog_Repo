module router_fsm(clock,resetn,pkt_valid,data_in,fifo_full,
		  fifo_empty_0,fifo_empty_1,fifo_empty_2,
		  soft_reset_0, soft_reset_1, soft_reset_2,
		  parity_done, low_packet_valid,
		  write_enb_reg, detect_add, ld_state,
		  laf_state, lfd_state, full_state, rst_int_reg, busy);


    input clock,resetn,pkt_valid,fifo_full,
        fifo_empty_0,fifo_empty_1,fifo_empty_2,
        soft_reset_0, soft_reset_1, soft_reset_2,
        parity_done, low_packet_valid;
        
    input [1:0]data_in;

    output write_enb_reg, detect_add, ld_state,
        laf_state, lfd_state, full_state,
        rst_int_reg, busy; 


    parameter DECODE_ADDRESS = 8'd1,
        LOAD_FIRST_DATA = 8'd2,
        LOAD_DATA = 8'd4,
        FIFO_FULL_STATE = 8'd8,
        LOAD_AFTER_FULL = 8'd16,
        CHECK_PARITY_ERROR = 8'd32,
        LOAD_PARITY = 8'd64,
        WAIT_TILL_EMPTY = 8'd128;

    reg[7:0] state, next_state;

    always@(posedge clock)
    begin
        if(~resetn)
        state<= DECODE_ADDRESS;
        else if(soft_reset_0 || soft_reset_1 || soft_reset_2)
            state<= DECODE_ADDRESS;
        else
        state<= next_state;
    end


    always@(*)
    begin
        next_state = DECODE_ADDRESS;

        case(state)
        
            DECODE_ADDRESS: if((pkt_valid&&(data_in[1:0]==0)&&fifo_empty_0) || (pkt_valid&&(data_in[1:0]==1)&&fifo_empty_1) || (pkt_valid&&(data_in[1:0]==2)&&fifo_empty_2))
                        
                        next_state= LOAD_FIRST_DATA;
                    else if((pkt_valid&&(data_in[1:0]==0)&&~fifo_empty_0) || (pkt_valid&&(data_in[1:0]==1)&&~fifo_empty_1) || (pkt_valid&&(data_in[1:0]==2)&&~fifo_empty_2))
                        next_state= WAIT_TILL_EMPTY;

                    else
                        next_state= DECODE_ADDRESS;

            LOAD_FIRST_DATA: next_state= LOAD_DATA;

            LOAD_DATA: if((~fifo_full) && (~pkt_valid))
                    next_state= LOAD_PARITY;
                    else if(fifo_full)
                    next_state= FIFO_FULL_STATE;
                    else 
                        next_state= LOAD_DATA;
            
            FIFO_FULL_STATE: if(~fifo_full)
                        next_state= LOAD_AFTER_FULL;

                    else
                        next_state= FIFO_FULL_STATE;

            LOAD_AFTER_FULL: if(parity_done)
                    next_state= DECODE_ADDRESS;

                    else if(~parity_done && low_packet_valid)
                    next_state= LOAD_PARITY;
                    else if(~parity_done && ~low_packet_valid)
                    next_state= LOAD_DATA;
                    else 
                    next_state= LOAD_AFTER_FULL;


            
            LOAD_PARITY: next_state= CHECK_PARITY_ERROR;

            CHECK_PARITY_ERROR: if(fifo_full)
                        next_state= FIFO_FULL_STATE;
                        else
                        next_state= DECODE_ADDRESS;

            
            WAIT_TILL_EMPTY: if(fifo_empty_0 ||
                        fifo_empty_1||
                        fifo_empty_2)

                        next_state= LOAD_FIRST_DATA;
                    
                    else if(~(fifo_empty_0)||
                        ~(fifo_empty_1) ||
                        ~(fifo_empty_2))

                        next_state= WAIT_TILL_EMPTY;
                    else 
                    next_state= WAIT_TILL_EMPTY;
        endcase
    
    end

    assign detect_add = (state== DECODE_ADDRESS)?1:0;
    assign lfd_state = (state== LOAD_FIRST_DATA)?1:0;
    assign ld_state= (state== LOAD_DATA)?1:0;
    assign busy= ((state== LOAD_FIRST_DATA)||(state== LOAD_PARITY) || (state== FIFO_FULL_STATE) || (state== LOAD_AFTER_FULL) || (state== WAIT_TILL_EMPTY) || (state== CHECK_PARITY_ERROR))?1:0;
    assign write_enb_reg= (state== LOAD_PARITY)||(state== LOAD_DATA) || (state== LOAD_AFTER_FULL);
    assign full_state= (state== FIFO_FULL_STATE)?1:0;
    assign laf_state= (state== LOAD_AFTER_FULL)?1:0;
    assign rst_int_reg= (state== CHECK_PARITY_ERROR);

endmodule


