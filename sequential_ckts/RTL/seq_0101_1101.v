module sequence(clk , reset, din, dout);

input clk, reset, din;
output  reg dout;

parameter IDLE = 4'b0000,
          S0 = 4'b0001,
          S1 = 4'b0010,
          S2 = 4'b0011,
          S3 = 4'b0100,
          S4 = 4'b0101,
          S5 = 4'b0110,
          S6 = 4'b0111,
          S7 = 4'b1000;
     
reg [3:0]next_state, state;

always@(posedge clk) begin

if(reset)
state<= IDLE;
else
state<= next_state;
end

always@(*) begin

case(state)

IDLE: begin
      dout = 0;
      if(din==0)
      next_state = S0;
      else
      next_state = S4;
      end
      
S0:   begin
      dout = 0;
      if(din==1)
      next_state = S1;
      else
      next_state = S0;
      end
      
S1:   begin
      if(din==0)
      next_state = S2;
      else
      next_state = S4;
      end
      
S2:   begin
      dout = 0;
      if(din==1)
      next_state = S3;
      else
      next_state = S0;
      end
      
S3:   begin
      dout = 1;
      if(din==1)
      next_state = S7;
      else
      next_state = S5;
      end
      
S4:   begin
      dout = 0;
      if(din==0)
      next_state = S5;
      else
      next_state = S4;
      end
      
S5:   begin
      dout = 0;
      if(din==1)
      next_state = S6;
      else
      next_state = S0;
      end
      
S6:   begin
      dout = 0;
      if(din==1)
      next_state = S7;
      else
      next_state = S2;
      end
      
S7:   begin
      dout = 1;
      if(din==1)
      next_state = S4;
      else
      next_state = S5;
      end
      
    endcase
  end
  
  endmodule
                        
