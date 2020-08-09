//SEQUENCE DETECTOR(0110) FSM CODING STYLE #3
module mealy_fsm(clk,reset,din,dout);

input clk,reset,din;
output reg dout;

parameter IDLE=3'b001,
          S1=3'b010,
          S2=3'b011,
          S3=3'b100;
          
reg[2:0]next_state, state;

always@(posedge clk) begin
if(reset)
state<=IDLE;
else
state<=next_state;
end

always@(*) begin
    next_state=IDLE;
    
    case(state)
    
    IDLE: begin
          if(din==0)
          next_state=S1;
          else
          next_state=IDLE;
          end
          
     S1:  begin
          if(din==1)
          next_state=S2;
          else
          next_state=S1;
          end
          
     S2:  begin
          if(din==1)
          next_state=S3;
          else
          next_state=S1;
          end
          
     S3:  begin
          if(din==0)
          next_state=S1;
          else
          next_state=IDLE;
          end
          
   endcase
   
  end
  
always@(posedge clk) begin

    if(reset)
        dout<=0;
    
    else
        begin
           // dout<=0;
            case(state)
            
                IDLE: dout<=0;
                S1:   dout<=0;
                S2:   dout<=0;
                S3:   dout<=1;
                
             endcase
         end
    end
    
 endmodule
    
