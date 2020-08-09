module dff(q, d, clk, set, rst);
  
input d, clk, set, rst;
output reg q;

always @(posedge clk)

if (rst)
q <= 0;
else if (set)
q <= 1;
else
q <= d;  //IF WE DONT MENTION THIS ELSE CONDITION< WE WILL ENCOUNTER A LATCH
  
endmodule
