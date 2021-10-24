module router_fifo(clock, resetn, soft_reset, write_enb, read_enb, lfd_state, data_in,data_out, full, empty);

  input clock, resetn, soft_reset, write_enb, read_enb, lfd_state;
  input [7:0]data_in;
  output full, empty;
  output reg [7:0]data_out;
  reg [4:0] wr_addr, rd_addr;
  reg[6:0] count;

  reg lfd_state_1;

  parameter depth= 16;
  parameter width=9;

  reg[(width-1):0]mem[(depth-1):0];
  integer i;


  //-----------------  WRITE  -------------------//

  always @(posedge clock) begin
    if(~resetn)
    lfd_state_1 <= 0;
    else
    lfd_state_1 <= lfd_state ;
  end


  always@(posedge clock) begin
    if(~resetn)begin
      for(i=0;i<depth;i=i+1)
        mem[i]<=0;
    end
    
    else if(soft_reset) begin
      for(i=0;i<depth;i=i+1)
        mem[i]<=0;
    end
      
    else if(write_enb && ~full)begin
      {mem[wr_addr[3:0]][8],mem[wr_addr[3:0]][7:0]}<= {lfd_state_1, data_in};
      end 	   
        
  end


  //-----------------  READ  -------------------//



  always@(posedge clock)begin

    if(~resetn)begin
      data_out<= 0;
    end


    else if(soft_reset)begin
      data_out<= 8'dz;
    end

    else if(read_enb && ~empty)
      data_out<= mem[rd_addr[3:0]];
    
    else if(count== 0) //&& data_out != 0)
      data_out<= 8'bz;
    else 
      data_out<= data_out;
    
  end

  //-----------------  COUNTER  -------------------//

  always@(posedge clock) begin 
    if(~resetn)
      count<=0;
    else
    begin
    if(read_enb && ~empty)
      begin
        if(mem[rd_addr[3:0]][8])
        count<= mem[rd_addr[3:0]][7:2]+1'b1;   
        
        else if(count!=0)
        count<=(count-1);
        else
          count<= count;      
      end
    end
  end

  //-----------------  WRITE/READ POINTER  -------------------//

  always@(posedge clock)
    begin
      if(~resetn)begin
        wr_addr<= 1'd0;
        rd_addr<=1'd0;
      end
  
      else if((write_enb && ~full) || (read_enb && ~empty))begin
        if(write_enb && ~full)
          wr_addr<=wr_addr+1;
        //else 
          //wr_addr<= wr_addr;

        if(read_enb && ~empty)
          rd_addr<=rd_addr+1;
      end
    end
    
  assign full= ((wr_addr[4]!=rd_addr[4]) && (wr_addr[3:0]==rd_addr[3:0]));
  assign empty= (wr_addr==rd_addr);


endmodule
