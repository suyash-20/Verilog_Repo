module encoder_tb;

reg [3:0] x;
wire [1:0]y;
integer i;

encoder DUV(x,y);

initial begin
x = 1;
#3;
x = 2;
#3;
x = 4;
#3;
x = 8;

#50 $finish;

end
initial 
$monitor("for input x:%b, output is:%b",x,y);

endmodule
