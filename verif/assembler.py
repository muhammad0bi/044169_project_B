"""
Author: Nathalia Barbosa (@nathaliafab)
Date: 2023-06-16

modifed : omar sharafi, 09/01/2025

This script translates instructions from a given file into a format readable by the instruction memory.
(It basically functions as an assembler.)

> The instructions to be translated are stored in a file named "instructions.txt"
> The translated instructions will be written to a file named "instruction.mif"

The instructions MUST follow the following formats, with one instruction per line:

<instruction> <register>,<register>,<register>
<instruction> <register>,<register>,<immediate>
<instruction> <register>,<offset>(<register>)
<instruction> <register>,<immediate>

~ Otherwise, it won't work. ;)

Example of a valid instruction file (content delimited by ```):
```
sub x6,x6,x1
addi x1,x0,8
lw x9,0(x0)
auipc x6,3
```
"""

import os

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

def parse_mif_to_32bit_blocks(file_name):
    try:
        with open(file_name, "r") as file:
            lines = file.readlines()
        if not lines:
            raise Exception("Empty file or no instructions found.")
    except Exception as e:
        print(f"Error reading instructions from '{file_name}': {e}")
        exit(1)

    # Find where 'BEGIN' starts the actual data
    data_lines = []
    begin_found = False
    for line in lines:
        stripped = line.strip()
        if not begin_found:
            if stripped.upper() == "BEGIN":
                begin_found = True
            continue

        # Skip empty or invalid lines
        if ":" in stripped and ";" in stripped:
            try:
                data = stripped.split(":")[1].strip().strip(";")
                if len(data) == 8 and all(bit in "01" for bit in data):
                    data_lines.append(data)
            except IndexError:
                continue

    # Group every 4 lines, reversed, into 32-bit blocks
    blocks = []
    for i in range(0, len(data_lines), 4):
        group = data_lines[i:i+4]
        if len(group) == 4:
            blocks.append(''.join(reversed(group)))

    return blocks

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

# Function to create the SV test_bench file
# added by omar sharafi, 09/01/2025
# Function to create the SV test_bench file
def create_sv_testbench(instructions, data, output_file):
    with open(output_file, "w") as file:
        # Write header
        file.write("`timescale 1ns / 1ps\n\n")
        file.write("module test_bench;\n\n")
        file.write("  // Clock and reset signal declaration\n")
        file.write("  logic tb_clk, reset, enable_load_ex_mem, enable_halt; // External memory loading enable\n\n")
        file.write("  logic [8:0]  InstExMemAddress; // Initialize instruction memory unit\n")
        file.write("  logic [31:0] InstExMemData1;\n")
        file.write("  logic [31:0] InstExMemData2;\n\n")
        file.write("  logic [8:0]  DataExMemAddress; // Initialize data memory unit\n")
        file.write("  logic [31:0] DataExMemData1;\n")
        file.write("  logic [31:0] DataExMemData2;\n")
        file.write("  logic [4:0]  DebugSel;\n")
        file.write("  logic [31:0] DebugOutput;\n")
        file.write("  localparam CLKPERIOD = 10;\n")
        file.write("  localparam CLKDELAY = CLKPERIOD / 2;\n")
        file.write("  localparam NUM_CYCLES = 50;\n\n")
        file.write("  riscv riscV (\n")
        file.write("      .clk(tb_clk),\n")
        file.write("      .reset(reset),\n")
        file.write("      .enable_load_ex_mem(enable_load_ex_mem),\n")
        file.write("      .enable_halt(enable_halt), // enable debug\n")
        file.write("      .DataExMemAddress(DataExMemAddress),\n")
        file.write("      .DataExMemData1(DataExMemData1),\n")
        file.write("      .DataExMemData2(DataExMemData2),\n")
        file.write("      .InstExMemAddress(InstExMemAddress),\n")
        file.write("      .InstExMemData1(InstExMemData1),\n")
        file.write("      .InstExMemData2(InstExMemData2),\n")
        file.write("      .DebugSel(DebugSel),\n")
        file.write("      .DebugOutput(DebugOutput)\n")
        file.write("  );\n\n")
        file.write("  initial begin\n")
        file.write("    tb_clk = 0;\n")
        file.write("    reset  = 1;\n")
        file.write("    enable_halt  = 0;\n")
        file.write("        DebugSel = 5'b11010;\n")
        
        # Write the instruction & data loading logic
        instr_i = 0
        data_i = 0
        address = 0
        while instr_i < len(instructions) or data_i < len(data):
            file.write("    @(posedge tb_clk);\n")
            file.write("    reset = 0;\n")
            file.write("    enable_load_ex_mem = 1'b1;\n")

            if instr_i < len(instructions):
                file.write(f"    InstExMemAddress = 9'b{bin(address)[2:].zfill(9)};\n")
                instr1 = translate_instruction(instructions[instr_i])
                file.write(f"    InstExMemData1 = 32'b{instr1};\n")
            if instr_i + 1 < len(instructions):
                instr2 = translate_instruction(instructions[instr_i + 1])
                file.write(f"    InstExMemData2 = 32'b{instr2};\n")
            instr_i += 2

            if data_i < len(data):
                file.write(f"    DataExMemAddress = 9'b{bin(address)[2:].zfill(9)};\n")
                file.write(f"    DataExMemData1 = 32'b{data[data_i]};\n")
            if data_i + 1 < len(data):
                file.write(f"    DataExMemData2 = 32'b{data[data_i + 1]};\n")
            data_i += 2

            file.write("    #(CLKPERIOD);\n")
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
    instructions_input_file = "instructions.txt"
    data_input_file = "data.mif"
    output_file = "test_bench.sv"

    instructions = read_file(instructions_input_file)
    data = parse_mif_to_32bit_blocks(data_input_file)
    create_sv_testbench(instructions, data, output_file)
    print(f"test_bench.sv file '{output_file}' created successfully.")
    print(len(data))
    print(len(instructions))

if __name__ == "__main__":
    main()


