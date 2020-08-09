//SEQUENCE DETECTOR(1011) FSM CODING STYLE #1
module sequence(clk, reset, din, dout);

input clk, reset, din;
output dout;

parameter IDLE = 5'b00001,
          S1 = 5'b00010,
          S2 = 5'b00100,
          S3 = 5'b01000,
          S4 = 5'b10000;
          
reg [4:0]next_state, state;

//PRESENT STATE LOGIC (SEQUENTIAL)
always@(posedge clk) begin

if(reset)
state<= IDLE;
else
state<= next_state;

end

always@(*) begin
case(state)

IDLE: begin
      if(din==1)
      next_state = S1;
      else
      next_state = IDLE;
      end
      
S1:   begin
      if(din==0)
      next_state = S2;
      else
      next_state = S1;
      end
      
S2:   begin
      if(din==1)
      next_state = S3;
      else
      next_state = IDLE;
      end
      
S3:   begin
      if(din==1)
      next_state = S4;
      else
      next_state = S2;
      end
      
S4:   begin
      if(din==1)
      next_state = S1;
      else
      next_state = S2;
      end

      
endcase

end

assign dout = (state==S4) ? 1:0;

endmodule

          
