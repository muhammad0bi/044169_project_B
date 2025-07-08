# 📝 How to Initialize the Instruction Memory
Create a file named `instructions.txt` in the verif directory.
Instructions must be written in RISC-V assembly. Refer to [`assembler.py`](assembler.py) for supported formats.

# 📝 How to Initialize the Data Memory
Create/use the file named data.mif in the verif directory.
each line in the file is co-responding to an 8-bit data in a specfic address
refer to the explaination in the top of the `data.mif` file for more info.

🧪 To create test bench only

1.Open your terminal in the verif directory and execute the following command:

	python3 assembler.py

2.A file named test_bench.sv should be generated in the same directory as the script.

🧪 How to Test Your Program with the Testbench

1.Create a new project directory (optional : Create a new project in ModelSim).

2.Add all the files from the Design folder to the project directory.

3.In the project directory, ensure that you have the following files:

	- run_sim.sh
	- instructions.txt
	- data.mif
	- dpram4096x8.v
	- dpram2048x32_CB.v
	- assembler.py

4.Execute the following command in your terminal:
    ```shell
    do ./run_sim.sh
    ```

5.A file named test_bench.sv should be generated in the same directory as the run_sim.sh.
  The compilation and simulation process will commence, and the results will be displayed in the terminal.


