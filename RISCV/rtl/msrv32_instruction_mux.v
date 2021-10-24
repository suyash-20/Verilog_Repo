module msrv32_instruction_mux (input flush_in, input [31:0] ms_riscv32_mp_instr_in, output [6:0] opcode_out, func7_out, output[2:0] func3_out, output [4:0] rs1_addr_out,rs2_addr_out,rd_addr_out, output [11:0] csr_addr_out, output [31:7] instr_out);

reg [31:0] instr_mux;
reg [31:0] flush_temp = 32'h00000013;


assign opcode_out = flush_in ? flush_temp[6:0] : ms_riscv32_mp_instr_in[6:0] ;

assign func3_out = flush_in ? flush_temp[14:12] : ms_riscv32_mp_instr_in[14:12];

assign func7_out = flush_in ? flush_temp[31:25] : ms_riscv32_mp_instr_in[31:25];

assign csr_addr_out = flush_in ? flush_temp[31:20] : ms_riscv32_mp_instr_in[31:20];

assign rs1_addr_out = flush_in ? flush_temp[24:20] : ms_riscv32_mp_instr_in[19:15];

assign rs2_addr_out = flush_in ? flush_temp[24:20] : ms_riscv32_mp_instr_in[24:20];

assign rd_addr_out = flush_in ? flush_temp[11:7] : ms_riscv32_mp_instr_in[11:7];

assign instr_out = flush_in ? flush_temp[31:7] : ms_riscv32_mp_instr_in[31:7];

endmodule
