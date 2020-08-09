module jk_flip_flop_tb;

reg clk,reset,j,k;
wire q;

jk_flip_flop DUT(clk,reset,j,k,q);

always begin
#2 clk = 1'b1;
#2 clk = ~clk;
end

initial begin
@(negedge clk)
reset = 1'b1;
@(negedge clk)
reset = 1'b0;
#2;

//can opt for a FOR LOOP as well, this is just for simplicity.

{j,k} = 2'b00;
#5;
{j,k} = 2'b01;
#5;
{j,k} = 2'b10;
#5;
{j,k} = 2'b11;

#50 $finish;

end

initial 
$monitor("FOR j:%b and k:%b, the output is q:%b", j,k,q);

endmodule

