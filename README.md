

# Assembly CAT 2 README

This repository contains four assembly programs, each focusing on different aspects of control flow, array manipulation, modular programming, and sensor-based control systems. Below are the details for each task, including the purpose of the program, instructions for compilation and execution, and insights or challenges encountered during development.

---

## Task 1: Control Flow and Conditional Logic

### Overview
This program prompts the user to enter a number and classifies it as "POSITIVE," "NEGATIVE," or "ZERO." It uses both conditional and unconditional jumps to manage the control flow effectively.

### Compilation and Execution
1. Assemble the code:
   ```bash
   nasm -f elf32 task1.asm -o task1.o
   ```
2. Link the object file:
   ```bash
   ld -m elf_i386 task1.o -o task1
   ```
3. Run the program:
   ```bash
   ./task1
   ```

### How It Works
1. The program prompts the user for input.
2. It converts the user input (string) to an integer.
3. The program checks if the number is positive, negative, or zero using conditional jumps (`je`, `jg`) and displays the corresponding message.
4. The program then exits.

### Challenges Encountered
- Handling user input and converting from ASCII to integer.
- Efficiently managing branching logic using conditional and unconditional jumps.

### Key Insights
- Conditional jumps allow effective handling of different cases, while unconditional jumps are used to direct flow to different sections of the program.
- Comments in the code explain the purpose and choice of jumps for better readability.

---

## Task 2: Array Manipulation with Looping and Reversal

### Overview
This program accepts an array of integers and reverses it in place without using additional memory to store the reversed array. It simulates user input and displays the reversed array.

### Compilation and Execution
1. Assemble the code:
   ```bash
   nasm -f elf32 task2.asm -o task2.o
   ```
2. Link the object file:
   ```bash
   ld -m elf_i386 task2.o -o task2
   ```
3. Run the program:
   ```bash
   ./task2
   ```

### How It Works
1. The program simulates user input by hardcoding an array of five integers.
2. It uses a loop and two counters (`ecx` for the left index and `ebx` for the right index) to reverse the array in place.
3. The reversed array is displayed by converting each integer to ASCII and printing it.

### Challenges Encountered
- Reversing the array in place required careful index management to avoid overwriting data before swapping.
- Handling the conversion of integers to ASCII for output.

### Key Insights
- In-place array reversal requires managing the indices carefully to avoid data corruption.
- Converting integers to ASCII for display is a key challenge when working with arrays of integers.

---

## Task 3: Modular Program with Subroutines for Factorial Calculation

### Overview
This program calculates the factorial of a user-provided number using a subroutine to perform the calculation. The program demonstrates the use of the stack to preserve registers.

### Compilation and Execution
1. Assemble the code:
   ```bash
   nasm -f elf32 task3.asm -o task3.o
   ```
2. Link the object file:
   ```bash
   ld -m elf_i386 task3.o -o task3
   ```
3. Run the program:
   ```bash
   ./task3
   ```

### How It Works
1. The user inputs a number, and the program calls a subroutine to compute its factorial.
2. The subroutine uses the stack to preserve registers, ensuring that the program's state is maintained during the calculation.
3. The result is placed in a general-purpose register and displayed.

### Challenges Encountered
- Preserving registers during the subroutine call and restoring them after the computation.
- Understanding stack operations and register handling in modular assembly programs.

### Key Insights
- The use of the stack for register preservation demonstrates how to manage program state during function-like subroutine calls.
- Factorial calculation in assembly requires careful handling of recursion and register manipulation.

---

## Task 4: Data Monitoring and Control Using Port-Based Simulation

### Overview
This program simulates a control system that reads a water level sensor value and performs actions based on predefined thresholds. It controls a motor and triggers an alarm depending on the sensor reading.

### Compilation and Execution
1. Assemble the code:
   ```bash
   nasm -f elf32 task4.asm -o task4.o
   ```
2. Link the object file:
   ```bash
   ld -m elf_i386 task4.o -o task4
   ```
3. Run the program:
   ```bash
   ./task4
   ```

### How It Works
1. The program reads a simulated sensor value for the water level.
2. The value is compared against high and moderate thresholds, triggering actions:
   - **High Water Level:** Turns on the alarm and stops the motor.
   - **Moderate Water Level:** Stops the motor and turns off the alarm.
   - **Low Water Level:** Turns on the motor and keeps the alarm off.
3. The program simulates hardware control by manipulating memory locations that represent the motor and alarm statuses.

### Challenges Encountered
- Comparing the sensor value with multiple thresholds and branching accordingly.
- Simulating hardware interaction using memory manipulation instead of actual I/O ports.

### Key Insights
- Conditional jumps allow the program to react to different sensor readings effectively.
- The use of simulated memory locations for hardware control gives insight into how embedded systems interact with peripherals.

---


---

