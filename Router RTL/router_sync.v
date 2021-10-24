module router_sync(clock, resetn, data_in,
		 detect_add, full_0,full_1,full_2,
		empty_0,empty_1,empty_2, write_enb_reg,
		read_enb_0,read_enb_1,read_enb_2,write_enb,
		fifo_full, vld_out_0,vld_out_1,vld_out_2,
		soft_reset_0,soft_reset_1,soft_reset_2);

    input clock, resetn,detect_add,
        full_0,full_1,full_2,
        empty_0,empty_1,empty_2, write_enb_reg,
        read_enb_0,read_enb_1,read_enb_2;

    input [1:0]data_in;

    reg [1:0]data_temp;
    reg [4:0] count0, count1, count2;

    output reg fifo_full,soft_reset_0,soft_reset_1,soft_reset_2;
    output vld_out_0,vld_out_1,vld_out_2;

    output reg [2:0] write_enb;



    //////////////////BYTE ADDRESS BLOCK\\\\\\\\\\\\\\\\\\\\\\\\

    always@(posedge clock)
    begin
        if(~resetn)
            begin
            //write_enb<= 3'b0;
            data_temp<=0;
            end
        else if(detect_add)
            data_temp<= data_in;
    end

    //////////////////FIFO_FULL BLOCK\\\\\\\\\\\\\\\\\\\\\\\\\\\\


    always@(*)

    begin
        case(data_temp)
            2'b00:  begin
                    fifo_full= full_0;
                    if(write_enb_reg)
                    write_enb= 3'b001;
                    else
                    write_enb= 0;
                end


            2'b01:  begin
                    fifo_full= full_1;
                    if(write_enb_reg)
                    write_enb= 3'b010;
                    else
                    write_enb= 0;
                end


            2'b10:  begin
                    fifo_full= full_2;
                    if(write_enb_reg)
                    write_enb= 3'b100;
                    else
                    write_enb= 0;
                end


            2'b11:  begin
                    fifo_full= 0;	      
                    write_enb= 0;
                end

        endcase
    end


    /*
    always @ (*)
    begin

    if(~resetn)
    fifo_full = 0 ;

    else
    begin
    case(data_temp)

    2'b00 : fifo_full = full_0 ;
    2'b01 : fifo_full = full_1 ;
    2'b10 : fifo_full = full_2 ;
    default : fifo_full = 0 ;

    endcase
    end
    end

    //....................................write enable logic


    always @ *

    begin

    if(~resetn)

    write_enb = 0 ;

    else
    if(write_enb_reg)
    begin
    case (data_temp)
    2'b00 : write_enb = 3'b001;
    2'b01 : write_enb = 3'b010;
    2'b10 : write_enb = 3'b100;
    default : write_enb = 3'b000;
    endcase
    end
    else
    write_enb = 0 ;

    end
    */

    ////////////////// VLD_OUT BLOCK\\\\\\\\\\\\\\\\\\\\\\

    assign vld_out_0 = ~empty_0; 
    assign vld_out_1 = ~empty_1;
    assign vld_out_2 = ~empty_2; 

    //////////////////SOFT_RESET BLOCK\\\\\\\\\\\\\\\\\\\\\\


    always@(posedge clock)       //  00

    begin
        if(~resetn)
            begin
            count0<= 0;
            soft_reset_0<= 0;
            end

        else if(vld_out_0)
            begin
            if(~read_enb_0)
            begin
                if(count0==29)
                begin
                soft_reset_0<=1'b1;
                count0<=0;
            end
                else
                begin
                count0<=count0+1;
                soft_reset_0 <= 1'b0;
                end
            end
        else
                begin
                count0<= 0;
                soft_reset_0<= 1'b0;
                end

        end
    end


    always@(posedge clock)       // 01

    begin
        if(~resetn)
            begin
            count1<= 0;
            soft_reset_1<= 0;
            end

        else if(vld_out_1)
            begin
            if(~read_enb_1)
                begin
                if(count1==29)
            begin

                soft_reset_1<=1'b1;
                count1<=0;
            end
                else
                begin
                count1<=count1+1;
                soft_reset_1<= 1'b0;
                end
            end
                else
                begin
                count1<= 0;
                soft_reset_1<= 1'b0;
                end
        end
    end



    always@(posedge clock)       // 02
    begin
        if(~resetn)begin
            count2<= 0;
            soft_reset_2<= 0;
        end

        else if(vld_out_2) begin
            if(~read_enb_2) begin
                if(count2==29) begin
                    soft_reset_2<=1'b1;
                    count2<=0;
                end
                else begin
                    count2<=count2+1;
                    soft_reset_2 <= 1'b0;
                end

            end
            
            else begin
                count2<= 0;
                soft_reset_2<= 1'b0;
            end
        end
    end

endmodule