import os

BITS_IN_CHUNK = 32

BITS_IN_CHUNK = 32

INSTRUCTION = {
 "lui": {
  "format": "U",
  "opcode": "0110111",
  "funct3": "",
  "funct7": ""
 },
 "auipc": {
  "format": "U",
  "opcode": "0010111",
  "funct3": "",
  "funct7": ""
 },
 "jal": {
  "format": "J",
  "opcode": "1101111",
  "funct3": "",
  "funct7": ""
 },
 "jalr": {
  "format": "I",
  "opcode": "1100111",
  "funct3": "000",
  "funct7": ""
 },
 "beq": {
  "format": "B",
  "opcode": "1100011",
  "funct3": "000",
  "funct7": ""
 },
 "bne": {
  "format": "B",
  "opcode": "1100011",
  "funct3": "001",
  "funct7": ""
 },
 "blt": {
  "format": "B",
  "opcode": "1100011",
  "funct3": "100",
  "funct7": ""
 },
 "bge": {
  "format": "B",
  "opcode": "1100011",
  "funct3": "101",
  "funct7": ""
 },
 "bltu": {
  "format": "B",
  "opcode": "1100011",
  "funct3": "110",
  "funct7": ""
 },
 "bgeu": {
  "format": "B",
  "opcode": "1100011",
  "funct3": "111",
  "funct7": ""
 },
 "lb": {
  "format": "I",
  "opcode": "0000011",
  "funct3": "000",
  "funct7": ""
 },
 "lh": {
  "format": "I",
  "opcode": "0000011",
  "funct3": "001",
  "funct7": ""
 },
 "lw": {
  "format": "I",
  "opcode": "0000011",
  "funct3": "010",
  "funct7": ""
 },
 "lbu": {
  "format": "I",
  "opcode": "0000011",
  "funct3": "100",
  "funct7": ""
 },
 "lhu": {
  "format": "I",
  "opcode": "0000011",
  "funct3": "101",
  "funct7": ""
 },
 "sb": {
  "format": "S",
  "opcode": "0100011",
  "funct3": "000",
  "funct7": ""
 },
 "sh": {
  "format": "S",
  "opcode": "0100011",
  "funct3": "001",
  "funct7": ""
 },
 "sw": {
  "format": "S",
  "opcode": "0100011",
  "funct3": "010",
  "funct7": ""
 },
 "addi": {
  "format": "I",
  "opcode": "0010011",
  "funct3": "000",
  "funct7": ""
 },
 "slti": {
  "format": "I",
  "opcode": "0010011",
  "funct3": "010",
  "funct7": ""
 },
 "sltiu": {
  "format": "I",
  "opcode": "0010011",
  "funct3": "011",
  "funct7": ""
 },
 "xori": {
  "format": "I",
  "opcode": "0010011",
  "funct3": "100",
  "funct7": ""
 },
 "ori": {
  "format": "I",
  "opcode": "0010011",
  "funct3": "110",
  "funct7": ""
 },
 "andi": {
  "format": "I",
  "opcode": "0010011",
  "funct3": "111",
  "funct7": ""
 },
 "slli": {
  "format": "I",
  "opcode": "0010011",
  "funct3": "001",
  "funct7": "0000000"
 },
 "srli": {
  "format": "I",
  "opcode": "0010011",
  "funct3": "101",
  "funct7": "0000000"
 },
 "srai": {
  "format": "I",
  "opcode": "0010011",
  "funct3": "101",
  "funct7": "0100000"
 },
 "add": {
  "format": "R",
  "opcode": "0110011",
  "funct3": "000",
  "funct7": "0000000"
 },
 "sub": {
  "format": "R",
  "opcode": "0110011",
  "funct3": "000",
  "funct7": "0100000"
 },
 "sll": {
  "format": "R",
  "opcode": "0110011",
  "funct3": "001",
  "funct7": "0000000"
 },
 "slt": {
  "format": "R",
  "opcode": "0110011",
  "funct3": "010",
  "funct7": "0000000"
 },
 "sltu": {
  "format": "R",
  "opcode": "0110011",
  "funct3": "011",
  "funct7": "0000000"
 },
 "xor": {
  "format": "R",
  "opcode": "0110011",
  "funct3": "100",
  "funct7": "0000000"
 },
 "srl": {
  "format": "R",
  "opcode": "0110011",
  "funct3": "101",
  "funct7": "0000000"
 },
 "sra": {
  "format": "R",
  "opcode": "0110011",
  "funct3": "101",
  "funct7": "0100000"
 },
 "or": {
  "format": "R",
  "opcode": "0110011",
  "funct3": "110",
  "funct7": "0000000"
 },
 "and": {
  "format": "R",
  "opcode": "0110011",
  "funct3": "111",
  "funct7": "0000000"
 },
}


# Function to read instructions from a file
def read_file(file_name):
    try:
        with open(file_name, "r") as file:
            instructions = file.readlines()
        if not instructions:
            raise Exception("Empty file or no instructions found.")
    except Exception as e:
        print(f"Error reading instructions from '{file_name}': {e}")
        exit(1)

    return [instr.strip() for instr in instructions if instr.strip()]


# writes 8-bit chunks of the instructions to the file ({index}: {chunk}		-- {instruction})
def write_instruction(file_name, index, chunk, instr):
	if (int(index) % 4 != 0):
		instr = ""
	else:
		instr = f"\t-- {instr.rstrip()}"

	with open(file_name, "a") as file:
		file.write(f"{index}: {chunk};{instr}\n")
		if (int(index) % 4 == 3):
			file.write("\n")


# appends a final "END;" string to the file
def end_file(file_name):
	with open(file_name, "a") as file:
		file.write("END;")

def negative_to_twos_complement(negative_binary):
	abs_binary = negative_binary
	ones_complement = ''.join('1' if bit == '0' else '0' for bit in abs_binary)

	twos_complement = ''
	carry = 1

	for bit in reversed(ones_complement):
		if carry == 1:
			if bit == '0':
				twos_complement = '1' + twos_complement
				carry = 0
			else:
				twos_complement = '0' + twos_complement
				carry = 1
		else:
			twos_complement = bit + twos_complement

	return twos_complement

# converts a decimal value to a signed binary value (sign bit is the first bit)
def sbin(value):
	binary = bin(int(value))

	if (binary[0] == '-'):
		return '1' + negative_to_twos_complement(binary[3:])

	else:
		return '0' + binary[2:]


# pads a binary value with 0s or 1s to a certain length (same as zfill() but extends the sign bit)
def sfill(value, length):
	if (len(value) < length):
		if (value[0] == '1'):
			return (length - len(value)) * '1' + value
		else:
			return (length - len(value)) * '0' + value
	else:
		return value


def check_register(register):
	if (register[0] != "x" or int(register[1:]) < 0 or int(register[1:]) > 31):
		raise Exception("Invalid register.")


def check_instruction(instruction):
	if (instruction not in INSTRUCTION):
		raise Exception("Instruction not found.")


def check_immediate(immediate, length):
	if (int(immediate) > 2**(length - 1) - 1 or int(immediate) < -2**(length - 1) + 1):
		raise Exception("Immediate value out of range.")


# Function to convert an instruction to binary
# translates an instruction to binary (assembly to machine code)
def translate_instruction(instruction):
	try:
		instr = instruction.split(" ")[0]

		check_instruction(instr)

		opcode = INSTRUCTION[instr]["opcode"]
		funct3 = INSTRUCTION[instr]["funct3"]
		funct7 = INSTRUCTION[instr]["funct7"]

		if (INSTRUCTION[instr]["format"] not in ["S", "B"]):
			rd = instruction.split(" ")[1].split(",")[0]

			check_register(rd)

			rd = bin(int(rd[1:]))[2:].zfill(5)

		if (INSTRUCTION[instr]["format"] == "U"):
			imm = instruction.split(" ")[1].split(",")[1]

			check_immediate(imm, 20)

			imm = sfill(sbin(imm)[0:20], 20)

			binary = imm + rd + opcode

		elif (INSTRUCTION[instr]["format"] == "J"):
			imm = instruction.split(" ")[1].split(",")[1]

			check_immediate(imm, 20)

			imm = sfill(sbin(imm)[0:20], 21)
			imm = imm[::-1]

			bit20 = imm[20]
			bit10to1 = (imm[1:11])[::-1]
			bit11 = imm[11]
			bit19to12 = (imm[12:20])[::-1]

			imm = sfill((bit20 + bit10to1 + bit11 + bit19to12), 20)

			binary = imm + rd + opcode

		elif (
		  INSTRUCTION[instr]["format"] == "I"
		  and instr not in ["lw", "lb", "lh", "lbu", "lhu", "slli", "srli", "srai"]):
			rs1 = instruction.split(" ")[1].split(",")[1]

			check_register(rs1)

			rs1 = bin(int(rs1[1:]))[2:].zfill(5)

			imm = instruction.split(" ")[1].split(",")[2]

			check_immediate(imm, 12)

			imm = sfill(sbin(imm)[0:12], 12)

			binary = imm + rs1 + funct3 + rd + opcode

		elif (INSTRUCTION[instr]["format"] == "B"):
			rs1 = instruction.split(" ")[1].split(",")[0]
			rs2 = instruction.split(" ")[1].split(",")[1]

			check_register(rs1)
			check_register(rs2)

			rs1 = bin(int(rs1[1:]))[2:].zfill(5)
			rs2 = bin(int(rs2[1:]))[2:].zfill(5)

			imm = instruction.split(" ")[1].split(",")[2]

			check_immediate(imm, 12)

			imm = sfill(sbin(imm)[0:12], 13)
			imm = imm[::-1]

			bit12 = imm[12]
			bit10to5 = (imm[5:11])[::-1]
			bit4to1 = (imm[1:5])[::-1]
			bit11 = imm[11]

			binary = sfill((bit12 + bit10to5), 7) + rs2 + rs1 + funct3 + sfill(
			 (bit4to1 + bit11), 5) + opcode

		elif (instr in ["lb", "lh", "lw", "lbu", "lhu"]):
			rs1 = instruction.split(" ")[1].split(",")[1]
			rs1 = rs1.split("(")[1].split(")")[0]

			check_register(rs1)

			rs1 = bin(int(rs1[1:]))[2:].zfill(5)

			imm = instruction.split(" ")[1].split(",")[1]
			imm = imm.split("(")[0]

			check_immediate(imm, 12)

			imm = sfill(sbin(imm)[0:12], 12)

			binary = imm + rs1 + funct3 + rd + opcode

		elif (INSTRUCTION[instr]["format"] == "S"):
			rs2 = instruction.split(" ")[1].split(",")[0]
			rs1 = instruction.split(" ")[1].split(",")[1]
			rs1 = rs1.split("(")[1].split(")")[0]

			check_register(rs1)
			check_register(rs2)

			rs2 = bin(int(rs2[1:]))[2:].zfill(5)
			rs1 = bin(int(rs1[1:]))[2:].zfill(5)

			imm = instruction.split(" ")[1].split(",")[1]
			imm = imm.split("(")[0]

			check_immediate(imm, 12)

			imm = sfill(sbin(imm)[0:12], 12)
			imm = imm[::-1]

			bit11to5 = (imm[5:12])[::-1]
			bit4to0 = (imm[0:5])[::-1]

			binary = sfill(bit11to5, 7) + rs2 + rs1 + funct3 + sfill(bit4to0, 5) + opcode

		elif (INSTRUCTION[instr]["format"] == "R"):
			rs1 = instruction.split(" ")[1].split(",")[1]
			rs2 = instruction.split(" ")[1].split(",")[2]

			check_register(rs1)
			check_register(rs2)

			rs1 = bin(int(rs1[1:]))[2:].zfill(5)
			rs2 = bin(int(rs2[1:]))[2:].zfill(5)

			binary = funct7 + rs2 + rs1 + funct3 + rd + opcode

		elif (instr in ["slli", "srli", "srai"]):
			rs1 = instruction.split(" ")[1].split(",")[1]

			check_register(rs1)

			rs1 = bin(int(rs1[1:]))[2:].zfill(5)

			shamt = instruction.split(" ")[1].split(",")[2]
			shamt = sfill(sbin(shamt)[0:6], 5)

			binary = funct7 + shamt + rs1 + funct3 + rd + opcode

	except Exception as e:
		print(f"Error translating instruction '{instruction.rstrip()}': {e}")
		return None

	return binary

# Parses a .mif file for data memory and returns list of (address, data1, data2)
def parse_data_mif(file_path):
    with open(file_path, "r") as f:
        lines = [line.strip() for line in f if ':' in line and ';' in line]

    data_bytes = []
    for line in lines:
        _, val = line.split(':')
        val = val.strip().strip(';')
        data_bytes.append(val)

    blocks = []
    for i in range(0, len(data_bytes), 8):
        chunk = data_bytes[i:i+8]
        if len(chunk) < 8:
            continue
        data1 = ''.join(chunk[3::-1])
        data2 = ''.join(chunk[7:3:-1])
        blocks.append((i, data1, data2))
    return blocks


# Function to create the SV testbench file
def create_sv_testbench(instructions, output_file):
    data_mem_blocks = parse_data_mif("data.mif")
    with open(output_file, "w") as file:
        # Write header
        file.write("`timescale 1ns / 1ps\n\n")
        file.write("module tb_top;\n\n")
        file.write("  // Clock and reset signal declaration\n")
        file.write("  logic tb_clk, reset, enable_load_ex_mem; // External memory loading enable\n\n")
        file.write("  logic [8:0] InstExMemAddress; // Initialize instruction memory unit\n")
        file.write("  logic [31:0] InstExMemData1;\n")
        file.write("  logic [31:0] InstExMemData2;\n\n")
        file.write("  logic [8:0] DataExMemAddress; // Initialize data memory unit\n")
        file.write("  logic [31:0] DataExMemData1;\n")
        file.write("  logic [31:0] DataExMemData2;\n")
        file.write("  logic [31:0] tb_WB_Data;\n")
        file.write("  logic [31:0] reg_data;\n")
        file.write("  logic [4:0] reg_num;\n")
        file.write("  logic reg_write_sig; // Initialize data memory unit\n")
        file.write("  logic rd;\n")
        file.write("  logic wr;\n")
        file.write("  logic [8:0] addr; // Initialize data memory unit\n")
        file.write("  logic [31:0] wr_data;\n")
        file.write("  logic [31:0] rd_data;\n\n")
        file.write("  localparam CLKPERIOD = 10;\n")
        file.write("  localparam CLKDELAY = CLKPERIOD / 2;\n")
        file.write("  localparam NUM_CYCLES = 50;\n\n")
        file.write("  riscv riscV (\n")
        file.write("      .clk(tb_clk),\n")
        file.write("      .reset(reset),\n")
        file.write("      .enable_load_ex_mem(enable_load_ex_mem),\n")
        file.write("      .DataExMemAddress(DataExMemAddress),\n")
        file.write("      .DataExMemData1(DataExMemData1),\n")
        file.write("      .DataExMemData2(DataExMemData2),\n")
        file.write("      .InstExMemAddress(InstExMemAddress),\n")
        file.write("      .InstExMemData1(InstExMemData1),\n")
        file.write("      .InstExMemData2(InstExMemData2),\n")
        file.write("      .WB_Data(WB_Data),\n")
        file.write("      .reg_num(reg_num),\n")
        file.write("      .reg_data(reg_data),\n")
        file.write("      .reg_write_sig(reg_write_sig),\n")
        file.write("      .wr(wr),\n")
        file.write("      .rd(rd),\n")
        file.write("      .addr(addr),\n")
        file.write("      .wr_data(wr_data),\n")
        file.write("      .rd_data(rd_data)\n");
        file.write("  );\n\n")
        file.write("  initial begin\n")
        file.write("    tb_clk = 0;\n")
        file.write("    reset  = 1;\n")
        
        # Write the instruction & mem loading logic
        address = 0
        max_cycles = max(len(instructions), len(data_mem_blocks) * 2)
        for i in range(0, max_cycles, 2):
            file.write("    @(posedge tb_clk);\n")
            file.write(f"    InstExMemAddress = 9'b{bin(address)[2:].zfill(9)};\n")
            instr1 = translate_instruction(instructions[i]) if i < len(instructions) else '0'*32
            instr2 = translate_instruction(instructions[i+1]) if i+1 < len(instructions) else '0'*32
            file.write(f"    InstExMemData1 = 32'b{instr1};\n")
            file.write(f"    InstExMemData2 = 32'b{instr2};\n")

            if i//2 < len(data_mem_blocks):
                data_addr, data1, data2 = data_mem_blocks[i//2]
                file.write(f"    DataExMemAddress = 9'd{data_addr};\n")
                file.write(f"    DataExMemData1 = 32'b{data1};\n")
                file.write(f"    DataExMemData2 = 32'b{data2};\n")
            file.write("    #(CLKPERIOD);\n\n")
            address += 8

        file.write("    reset  = 1;\n")
        file.write("    #(CLKPERIOD);\n")
        file.write("    reset  = 0;\n")
        file.write("    enable_load_ex_mem = 1'b0;\n")
        file.write(f"    #(CLKPERIOD * NUM_CYCLES);\n\n")
        file.write("    $stop;\n")
        file.write("  end\n\n")

        # Clock generator
        file.write("  always begin\n")
        file.write("    #(CLKDELAY) tb_clk = ~tb_clk;\n")
        file.write("  end\n\n")
        file.write("endmodule\n")

# Main function to execute the script
def main():
    input_file = "instructions.txt"
    output_file = "testbench.sv"

    instructions = read_file(input_file)
    create_sv_testbench(instructions, output_file)
    print(f"Testbench file '{output_file}' created successfully.")

if __name__ == "__main__":
    main()
