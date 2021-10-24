module msrv32_imm_generator(input [31:7] instr_in,input [2:0] imm_type_in, output reg [31:0] imm_out);

always@(*)
begin
	case(imm_type_in)
	
	3'd0,3'd1,3'd7	:	imm_out = {{20{instr_in[31]}}, instr_in[31:20]}; /// I-type
	
	3'd2			:  	imm_out = {{20{instr_in[31]}},instr_in[31:25],instr_in[11:7]};/// S-type
	
	3'd3			:  	imm_out = {{20{instr_in[31]}},instr_in[7],instr_in[30:25],instr_in[11:8],1'b0};///	B-type
	
	3'd4			:	imm_out = {instr_in[31:12],12'h000};///	U-type
		
	3'd5			:	imm_out = {{12{instr_in[31]}}, instr_in [19:12], instr_in[20], instr_in[30:21],1'b0};/// J-type
		
	3'd6			:	imm_out = {27'b0, instr_in[19:15]};///	csr_type
	
	endcase
end

endmodule
	
	