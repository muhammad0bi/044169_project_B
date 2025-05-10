import os

BITS_IN_CHUNK = 32

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

# Function to convert an instruction to binary
# Here, we'll assume the translate_instruction function is available from the previous script
# You should define or import it if necessary.
def translate_instruction(instruction):
    # Placeholder for binary translation logic
    # Replace this with the real implementation
    return "0" * 32  # Dummy 32-bit binary string

# Function to create the SV testbench file
def create_sv_testbench(instructions, output_file):
    with open(output_file, "w") as file:
        # Write header
        file.write("`timescale 1ns / 1ps\n\n")
        file.write("module tb_top;\n\n")
        file.write("  // Clock and reset signal declaration\n")
        file.write("  logic tb_clk, reset, enable_load_ex_mem; // External memory loading enable\n\n")
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
        file.write("      .enable_half(enable_half), // enable debug\n")
        file.write("      .DataExMemAddress(DataExMemAddress),\n")
        file.write("      .DataExMemData1(DataExMemData1),\n")
        file.write("      .DataExMemData2(DataExMemData2),\n")
        file.write("      .InstExMemAddress(InstExMemAddress),\n")
        file.write("      .InstExMemData1(InstExMemData1),\n")
        file.write("      .InstExMemData2(InstExMemData2),\n")
        file.write("      .DebugSel(DebugSel),\n")
        file.write("      .DebugOutput(DebugOutput),\n")
        file.write("  );\n\n")
        file.write("  initial begin\n")
        file.write("    tb_clk = 0;\n")
        file.write("    reset  = 1;\n")
        file.write("    enable_half  = 0;\n")
        
        # Write the instruction loading logic
        address = 0
        for i in range(0, len(instructions), 2):
            file.write("    @(posedge tb_clk);\n")
            file.write("    reset = 0;\n")
            file.write("    enable_load_ex_mem = 1'b1;\n")
            file.write(f"    InstExMemAddress = 9'b{bin(address)[2:].zfill(9)};\n")
            instr1 = translate_instruction(instructions[i])
            file.write(f"    InstExMemData1 = 32'b{instr1};\n")
            if i + 1 < len(instructions):
                instr2 = translate_instruction(instructions[i + 1])
                file.write(f"    InstExMemData2 = 32'b{instr2};\n")
            else:
                file.write("    InstExMemData2 = 32'b0;\n")
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
    input_file = "instructions.txt"
    output_file = "testbench.sv"

    instructions = read_file(input_file)
    create_sv_testbench(instructions, output_file)
    print(f"Testbench file '{output_file}' created successfully.")

if __name__ == "__main__":
    main()
