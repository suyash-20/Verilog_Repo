module dff_tb;

reg d, clk, set, rst;
wire q;

dff DU(q, d, clk, set, rst);

always begin
  #2clk=1'b1;
  #2clk=1'b0;
end
  
  
initial begin
  @(negedge clk)
  rst = 1;
  @(negedge clk)
  rst = 0;
  
  #5;
  @(posedge clk)d = 1;
  @(posedge clk)d = 0;
  @(posedge clk)d = 0;
  @(posedge clk)d = 1;
  
  
  
#50 $finish;

end
initial 
  $monitor("for input d:%b, output is:%b",d,q);

initial 
begin
  $dumpfile("dff.vcd");
$dumpvars();
end

endmodule
