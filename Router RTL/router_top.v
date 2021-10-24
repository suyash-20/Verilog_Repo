module router_top(data_in, pkt_valid, clock, resetn, read_enb_0, read_enb_1, read_enb_2,data_out_0, data_out_1, data_out_2, vld_out_0, vld_out_1, vld_out_2, err, busy);

    input [7:0] data_in;
    input  pkt_valid, clock, resetn, read_enb_0, read_enb_1, read_enb_2;
    output [7:0] data_out_0, data_out_1, data_out_2;
    output vld_out_0, vld_out_1, vld_out_2, err, busy;

    wire[2:0] write_enb;
    wire [7:0] dout;
    wire lfd_state, soft_reset, read_enb, full, empty;

    wire [7:0]data_out[2:0];

    /*
    genvar i;

    generate

    for(i=0; i< 3; i=i+1)
    begin : block1

    fifo fifo_gen(.clock(clock), .resetn(resetn), .soft_reset(soft_reset[i]),.write_enb(write_enb[i]),.read_enb(read_enb[i]), .lfd_state(lfd_state), .data_in(dout), .data_out(data_out[i]), .full(full[i]), .empty(empty[i]));

    end

    endgenerate
    */
    
    router_fifo fifo_0(.clock(clock), .resetn(resetn), .soft_reset(soft_reset_0),.write_enb(write_enb[0]),.read_enb(read_enb_0), .lfd_state(lfd_state), .data_in(dout), .data_out(data_out_0), .full(full_0), .empty(empty_0));

    router_fifo fifo_1(.clock(clock), .resetn(resetn), .soft_reset(soft_reset_1),.write_enb(write_enb[1]), .read_enb(read_enb_1), .lfd_state(lfd_state), .data_in(dout), .data_out(data_out_1), .full(full_1), .empty(empty_1));

    router_fifo fifo_2(.clock(clock), .resetn(resetn), .soft_reset(soft_reset_2),.write_enb(write_enb[2]), .read_enb(read_enb_2), .lfd_state(lfd_state), .data_in(dout), .data_out(data_out_2), .full(full_2), .empty(empty_2));


    router_sync synch(.clock(clock), .resetn(resetn),.data_in(data_in[1:0]),.detect_add(detect_add),.full_0(full_0),.full_1(full_1),.full_2(full_2),.empty_0(empty_0),.empty_1(empty_1),.empty_2(empty_2),.write_enb_reg(write_enb_reg),.read_enb_0(read_enb_0),.read_enb_1(read_enb_1),.read_enb_2(read_enb_2),.write_enb(write_enb),.fifo_full(fifo_full),.vld_out_0(vld_out_0),.vld_out_1(vld_out_1),.vld_out_2(vld_out_2),.soft_reset_0(soft_reset_0),.soft_reset_1(soft_reset_1),.soft_reset_2(soft_reset_2));

    router_reg register(.clock(clock),.resetn(resetn),.pkt_valid(pkt_valid),.data_in(data_in),.fifo_full(fifo_full),.detect_add(detect_add),.ld_state(ld_state),.laf_state(laf_state),.full_state(full_state),.lfd_state(lfd_state),.rst_int_reg(rst_int_reg),.err(err),.parity_done(parity_done),.low_packet_valid(low_packet_valid),. dout(dout));

    router_fsm fsm_(.clock(clock),.resetn(resetn),.pkt_valid(pkt_valid),.data_in(data_in[1:0]),.fifo_full(fifo_full),.fifo_empty_0(empty_0),.fifo_empty_1(empty_1),.fifo_empty_2(empty_2),.soft_reset_0(soft_reset_0),.soft_reset_1(soft_reset_1),.soft_reset_2(soft_reset_2),.parity_done(parity_done),.low_packet_valid(low_packet_valid),.write_enb_reg(write_enb_reg),.detect_add(detect_add),.ld_state(ld_state),.laf_state(laf_state),.lfd_state(lfd_state),.full_state(full_state),.rst_int_reg(rst_int_reg),.busy(busy));

endmodule




