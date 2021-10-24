module msrv32_branch_unit (input [31:0]rs1_in,rs2_in,input [6:2] opcode_in,input [2:0] func3_in,output reg branch_taken_out);

always@(*)
begin
	if(opcode_in == 5'b11000)
	begin
		/*if(
			((func3_in == 3'b000)&&(rs1_in==rs2_in))	||
			((func3_in == 3'b001)&&(rs1_in!=rs2_in))	||
			((func3_in == 3'b100)&&(rs1_in[31]^rs2_in)&&(rs1_in[30:0]<rs2_in[30:0]))		|| // rs1 signed
			((func3_in == 3'b101)&&(rs1_in[31]^rs2_in)&&(rs1_in[30:0]>=rs2_in[30:0]))	|| // rs2 signed
			((func3_in == 3'b110)&&(rs1_in<rs2_in))		|| // rs1 unsigned
			((func3_in == 3'b111)&&(rs1_in>=rs2_in))	   // rs2 unsigned
			)
			begin
				branch_taken_out = 1;
			end
		else
			branch_taken_out = 0;
		*/
		
		case(func3_in)
			
			3'b000 : if(rs1_in==rs2_in)
						begin
							branch_taken_out = 1;
						end
					else
						begin
							branch_taken_out = 0;
						end
			3'b001 : if(rs1_in!=rs2_in)
						begin
							branch_taken_out = 1;
						end
					else
						begin
							branch_taken_out = 0;
						end
			3'b100 :if(((rs1_in[31]^rs2_in[31]))&&(rs1_in[30:0]<rs2_in[30:0]))
						begin
							branch_taken_out = 1;
						end
					else
						begin
							branch_taken_out = 0;
						end
			3'b101 : if(((rs1_in[31]^rs2_in[31]))&&(rs1_in[30:0]>=rs2_in[30:0]))
						begin
							branch_taken_out = 1;
						end
					else
						begin
							branch_taken_out = 0;
						end
			3'b110 : if(rs1_in<rs2_in)
						begin
							branch_taken_out = 1;
						end
					else
						begin
							branch_taken_out = 0;
						end
			3'b111 : if(rs1_in>=rs2_in)
						begin
							branch_taken_out = 1;
						end
					else
						begin
							branch_taken_out = 0;
						end
		endcase
	end
	else if(opcode_in == 5'b11011)
		begin
			branch_taken_out = 1;
		end
	else if(opcode_in == 5'b11001)
	begin
		if(func3_in == 3'b000)
			branch_taken_out = 1;
	end
	else	
		begin
			branch_taken_out = 0;
		end
	
end

/// bt = (x[31]^y[31]) ? x[31] : (x[30:0]<y[30:0]);
endmodule