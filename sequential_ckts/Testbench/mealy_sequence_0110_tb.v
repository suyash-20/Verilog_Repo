module mealy_fsm_tb;

reg clk,reset,din;
wire dout;

mealy_fsm DUT(clk,reset,din,dout);


always begin
#2clk = 1'b1;
#2 clk = ~clk;
end

initial begin

@(negedge clk)
reset = 1'b1;
@(negedge clk)
reset = 1'b0;

    @(posedge clk) din <= 0;
    @(posedge clk) din <= 1;
    @(posedge clk) din <= 1;
    @(posedge clk) din <= 0;
    /* 		// Sequence is detected.
    @(posedge clk) din <= 0;
    @(posedge clk) din <= 0;
    @(posedge clk) din <= 1;
    @(posedge clk) din <= 1;
    @(posedge clk) din <= 0;
    @(posedge clk) din <= 1;
    @(posedge clk) din <= 1; 
*/
#20 $finish;

end

initial
$monitor($time,"For input:%0b, Output is %0b",din, dout);

endmodule
