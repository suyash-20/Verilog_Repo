`define DATA_WIDTH 8

interface router_if(input bit clock);

    logic [`DATA_WIDTH-1 : 0] data_in;
    logic read;
    logic write;
    logic resetn;
    logic read_enb;
    logic vld_out;
    logic pkt_valid;
    logic err;
    logic busy;
    logic [`DATA_WIDTH-1:0] data_out;
    //bit clock;


    //assign clock = clock;


    //------------------MODPORT AND CLOCKING BLOCK-----------------------

    clocking write_driver_cb @(posedge clock);
        default input #1 output #1;
        output resetn;
        output pkt_valid;
        output data_in;

        input err;
        input busy;

    endclocking

    clocking write_monitor_cb @(negedge clock);
        default input #1 output #1;
        input resetn;
        input pkt_valid;
        input data_in;

        input err;
        input busy;

    endclocking


    clocking read_driver_cb @(posedge clock);
        default input #1 output #1;
        output read_enb;

        input vld_out;


    endclocking


    clocking read_monitor_cb @(negedge clock);
        default input #1 output #1;
        input read_enb;
        input data_out;

    endclocking

    modport WDR_MP (clocking write_driver_cb);
    modport RDR_MP (clocking read_driver_cb);
    modport WMON_MP (clocking write_monitor_cb);
    modport RMON_MP (clocking read_monitor_cb);

endinterface


//----------------ASSERTIONS------------------//



