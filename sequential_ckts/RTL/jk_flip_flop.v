`include "include.v"
module jk_flip_flop(clk,reset, j,k,q);

input clk,reset,j,k;
output reg q;

always@(posedge clk) begin

if(reset)
q<=0;

else
begin

case({j,k})

`HOLD: q<=q;
`RESET: q<=0;
`SET: q<=1;
`TOGGLE: q<=~q;

endcase
end

end

endmodule
