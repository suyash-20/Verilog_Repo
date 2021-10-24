module msrv32_pc(rst_in,pc_src_in, pc_in, epc_in, trap_address_in, branch_taken_in, iaddr_in, misaligned_instr_out, pc_mux_out, pc_plus_4_out, i_addr_out);

/// ipnut output and other variable declaration

	input rst_in, branch_taken_in;
	input [1:0] pc_src_in;
	input [31:0] pc_in, epc_in, trap_address_in;
	input [30:0] iaddr_in;

	output 				misaligned_instr_out;
	output 		[31:0] 	pc_plus_4_out;
	output reg 	[31:0] 	pc_mux_out;

	wire 		[31:0] 	iaddr_out_in;
	output  	[31:0] 	i_addr_out;
	wire 		[31:0] 	next_pc;

	wire [31:0] BOOT_ADDESS=32'h0;

/// pc_plus_4_out logic ////

assign pc_plus_4_out = pc_in + 32'd4;

/// pc_mux_out logic
/*
always@(*)
begin
	if(rst_in)
		begin
			i_addr_out = BOOT_ADDESS;
		end
	else
		begin
			i_addr_out = pc_mux_out;
		end
end*/

assign i_addr_out = rst_in ? BOOT_ADDESS : pc_mux_out;

//// pc_mux_out logic

always@(*)
begin
	case(pc_src_in)
		2'b00	:	pc_mux_out = BOOT_ADDESS;
		2'b01	:	pc_mux_out = epc_in;
		2'b10	:	pc_mux_out = trap_address_in;
		2'b11	:	pc_mux_out = next_pc;
		default	:	pc_mux_out = next_pc;
	endcase
end
/// next_pc logic
/*
always@(*)
begin
	if(branch_taken_in)
		next_pc = iaddr_out_in;
	else
		next_pc = pc_plus_4_out;
end
*/
assign next_pc = branch_taken_in ? iaddr_out_in : pc_plus_4_out; 

//// concat logic

assign iaddr_out_in = {iaddr_in,1'b0};

/// misaligned_instr_out logic

assign misaligned_instr_out = next_pc[1] && branch_taken_in;

endmodule 
