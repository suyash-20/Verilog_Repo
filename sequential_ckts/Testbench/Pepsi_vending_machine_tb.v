module vending_fsm_tb;

reg [1:0]din;
reg clock,reset;
wire p; 
wire[3:0]c1,c2;

integer i;

vending_fsm DUT(din,clock,reset,p,c1,c2);

always begin
#2clock = 1'b1;
#2 clock = ~clock;
end

initial begin

@(negedge clock)
reset = 1'b1;
@(negedge clock)
reset = 1'b0;

din = 2'b00;
#1;
din = 2'b01;
#1;
din = 2'b00;
#1;
din = 2'b00;
#5;
din = 2'b10;

#20 $finish;
end

initial
$monitor($time,"For input coins:%b, Pepsi delivered:%b",din, p);

endmodule
