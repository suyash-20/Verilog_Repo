module encoder(x,y);
input[3:0] x;
output reg[1:0]y;

always @(*)begin
  
case (x)
4'd1: y = 2'b00;
4'd2: y = 2'b01;
4'd4: y = 2'b10;
4'd8: y = 2'b11;

default: y = 2'bxx;


endcase
end

endmodule
