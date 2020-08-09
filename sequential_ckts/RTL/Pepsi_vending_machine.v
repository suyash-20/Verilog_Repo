/*You are hired by Pepsi to design their next generation Pepsi (Generation Next) machine, the reason being that Pepsi is going to drop the price of their product to a quarter(1/4th of a dollar = 25 cents).  The new machine will accept the industry standard nickel=5 cents, dime=10 cents and quarter=25 cents .  Design a totally synchronous FSM and write the RTL code for the same.  Assume the only inputs to the system are the type of change put in (nickel, dime, or quarter).  Your outputs will be two change amount(Change 1 & Change 2), and a Pepsi release signal that goes high when enough change has been put in. 


Example: If the total = 40 cents then Output : Pepsi = 1, Change 1 = 10 & Change 2 = 5 (Order of change can be interchangeable)
*/

module vending_fsm(input [1:0]din,input clock,reset,output reg p,
                 output reg[3:0]c1,c2);

   parameter IDLE=4'b0000,
		 	 S5=4'b0001,
	         S10=4'b0010,
	 	     S15=4'b0011,
	 	     S20=4'b0100,
	 		 S25=4'b0101,
	 	     S30=4'b0110,
	 		 S35=4'b0111,
	     	 S40=4'b1000,
	 		 S45=4'b1001;

 reg [3:0] next_state, state;

always@(posedge clock)begin
	   if(reset)
	   state<=IDLE;
	  else 
	  state<=next_state;
	end

  always@(*)begin
    
    case (state)
  IDLE: 
		if(din==2'b00)
		next_state=S5;
      	else if(din==2'b01) 
        next_state=S10;
		else if(din==2'b10) 
	    next_state=S25;
		else
	    next_state=IDLE;
			
  S5: 
        if (din==2'b00)
  		 next_state=S10;
		else if(din==2'b01) 
        next_state=S15;
		else if(din==2'b10) 
		next_state=S30;

    	else
    	next_state=IDLE;
			
 S10: 
        if (din==2'b00)
        next_state=S15;
		else if(din==2'b01) 
        next_state=S20;
		else if(din==2'b10) 
		next_state=S35;

        else 
        next_state=IDLE;
			
 S15: 
        if (din==2'b00)
        next_state=S20;
		else if(din==2'b01) 
        next_state=S25;
		else if(din==2'b10) 
	   next_state=S40;

        else 
       next_state=IDLE;
			
S20: 
        if (din==2'b00)
        next_state=S25;
		else if(din==2'b01) 
        next_state=S30;
		else if(din==2'b10) 
		next_state=S45;

        else 
      	next_state=IDLE;
			
		
S25     : next_state=IDLE;
S30     : next_state=IDLE;
S35     : next_state=IDLE;
S40     : next_state=IDLE;
S45     : next_state=IDLE;

default : next_state=IDLE;
    endcase
  end
  

always@(*)
  begin
	p=1'b0; c1=4'd0; c2=4'd0;

    case (state)
		
        IDLE :begin
			p=1'b0; c1=4'd0; c2=4'd0;
			end
		S5 : begin
			p=1'b0; c1=4'd0; c2=4'd0;
			end 
		S10 : begin
			p=1'b0; c1=4'd0; c2=4'd0;
			end 
		S15 : begin
			p=1'b0; c1=4'd0; c2=4'd0;
			end 
		S20 : begin
			p=2'b0; c1=4'd0; c2=4'd0;
			end 
		S25 : begin
			p=1'b1; c1=4'd0; c2=4'd0;
			end 
		S30 : begin
			p=1'b1; c1=4'd5; c2=4'd0;
			end 
		S35 : begin
			p=1'b1; c1=4'd10; c2=4'd0;
			end 
		S40 : begin
			p=1'b1; c1=4'd10; c2=4'd5;
			end 
		S45 : begin
			p=1'b1; c1=4'd10; c2=4'd10;
			end 
		default : begin
			p=1'b0; c1=4'd0; c2=4'd0;
			end 
		endcase
	end
endmodule
