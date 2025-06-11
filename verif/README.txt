📝 How to Initialize & run a test
1.Create a file named instructions.txt & data.tst in the same directory as the assembler.py script.

Instructions must be written in RISC-V assembly. Refer to assembler.py for supported formats.
2.Open your terminal and execute the following command:

python3 assembler.py
A file named testbench.sv should be generated in the same directory as the script.

🧪 How to Test Your Program with the Testbench
1.Create a new project in ModelSim.

2.Add all the files from the design folder to the project.

3.Include the testbench file testbench.sv in the project.

In the project directory, ensure that you have the following files:

compile_verilog
runtb_top
instruction.mif
data.mif
Adjust the file paths in the scripts accordingly.

