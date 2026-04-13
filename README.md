# 📘 4-bit Carry Look-Ahead (CLA) Adder – Verilog

## 🔹 Overview

This project implements a **4-bit Carry Look-Ahead (CLA) Adder** in Verilog along with its testbench.
The CLA adder improves addition speed by reducing carry propagation delay compared to ripple carry adders.

---

## 🔹 Features

* 4-bit parallel addition
* Fast carry computation using:

  * Generate (G)
  * Propagate (P)
* Supports input carry (`carry_i`)
* Produces:

  * 4-bit sum (`sum_o`)
  * Carry-out (`carry_o`)

---

## 🔹 Module Description

### 📌 Inputs

* `a_i [3:0]` → First 4-bit operand
* `b_i [3:0]` → Second 4-bit operand
* `carry_i` → Input carry

### 📌 Outputs

* `sum_o [3:0]` → Result of addition
* `carry_o` → Final carry output

---

## 🔹 Working Principle

The CLA adder uses:

* **Generate (G):**

  ```
  G[i] = A[i] & B[i]
  ```

* **Propagate (P):**

  ```
  P[i] = A[i] ^ B[i]
  ```

* **Carry Equations:**

  ```
  C1 = G0 + P0·C0
  C2 = G1 + P1·G0 + P1·P0·C0
  C3 = G2 + P2·G1 + P2·P1·G0 + P2·P1·P0·C0
  ```

This allows all carries to be computed in parallel, reducing delay.

---

## 🔹 Testbench Details

The testbench (`tb_claAdder`) verifies functionality using multiple test cases:

| Test Case | A  | B  | Carry In | Description            |
| --------- | -- | -- | -------- | ---------------------- |
| 1         | 0  | 0  | 0        | All zeros              |
| 2         | 5  | 7  | 0        | Normal addition        |
| 3         | 7  | 7  | 1        | Addition with carry    |
| 4         | 8  | 8  | 0        | Overflow without carry |
| 5         | 8  | 8  | 1        | Overflow with carry    |
| 6         | 15 | 15 | 1        | Maximum input          |

---

## 🔹 Simulation

### ▶️ Tools

* ModelSim / QuestaSim
* Xilinx Vivado
* Icarus Verilog + GTKWave

### ▶️ Run (Icarus Verilog Example)

```bash
iverilog -o claAdder.vvp claAdder.v tb_claAdder.v
vvp claAdder.vvp
gtkwave claAdder.vcd
```

---

## 🔹 Output

* Console output using `$monitor`
* Waveform dump file:

  ```
  claAdder.vcd
  ```

---

## 🔹 Sample Output Format

```
Time: 5 | A: 5, B: 7, Carry_input: 0 | Sum: 12, Carry_output: 0
```

---

## 🔹 Applications

* High-speed ALUs
* Digital processors
* Arithmetic units in FPGA/ASIC designs

---

## 🔹 File Structure

```
├── claAdder.v        # CLA Adder Design
├── tb_claAdder.v     # Testbench
├── claAdder.vcd      # Waveform output (generated)
└── README.txt        # Documentation
```
