📝 How to Initialize & run a test
1.Create a file named instructions.txt in the same directory as the assembler.py script.

Instructions must be written in RISC-V assembly. Refer to assembler.py for supported formats.

🧪 How to Test Your Program with the Testbench
1.Create a new project in innovus.

2.Add all the files from the Design folder to the project.

In the project directory, ensure that you have the following files:

run_sim.sh
Memories:
dpram4096x8.v
dpram2048x32_CB.v
Adjust the file paths in the scripts accordingly.

4.Execute the following command in your terminal:

./run_sim.sh
A file named testbench.sv should be generated in the same directory as the script run_sim.sh & the innovus app opens.

5.Open simulation window in innovus app and run the simulation to see results.
