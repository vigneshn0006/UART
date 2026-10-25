# UART (Universal Asynchronous Receiver Transmitter) in Verilog HDL

An FSM-based UART designed in Verilog HDL, integrated in Vivado IP Integrator, and debugged on FPGA hardware using ILA and VIO.

## Overview
This project implements full-duplex serial communication using a UART transmitter, receiver, and baud rate generator. Both the transmitter and receiver are built as finite state machines (FSMs). The design was verified through simulation and then debugged in hardware using Vivado's ILA and VIO cores.

## Features
- FSM-based UART transmitter and receiver
- Baud rate generator producing TX and RX enable ticks
- 8-bit parallel data input and output
- Status signals for transmit ready (`rdy`) and receive complete (`done`)
- Custom Verilog testbench for functional verification
- Hardware debugging with ILA (capture) and VIO (drive inputs)

## Architecture

| Module | Description |
|---|---|
| `Baud_rate_gen` | Generates `tx_en` and `rx_en` timing ticks from the system clock |
| `uart_tx` | FSM that serializes 8-bit data (`data_in[7:0]`) onto the `tx` line when `write_en` is asserted |
| `uart_rx` | FSM that samples the `rx` line and outputs `data_out[7:0]` with a `done` flag |
| `ILA` | Captures received data and the `done` signal for on-chip analysis |
| `VIO` | Drives transmit data (`probe_out0[7:0]`) and monitors signals at runtime |

## Signal Description
| Signal | Direction | Description |
|---|---|---|
| `clk` | Input | System clock |
| `rst` | Input | Reset |
| `write_en` | Input | Starts transmission |
| `data_in[7:0]` | Input | Data to transmit |
| `tx` | Output | Serial transmit line |
| `rdy` | Output | Transmitter ready |
| `data_out[7:0]` | Output | Received parallel data |
| `done` | Output | Reception complete |

## Tools Used
- Verilog HDL
- Xilinx Vivado 2025.2 (IP Integrator, Simulation, ILA, VIO)
- FPGA board: _<add your board here>_

## Verification
- Functional verification using a custom Verilog testbench and waveform analysis
- Hardware validation using VIO to send data and ILA to capture the received output

## Project Structure
├── src/ # Verilog source files (baud_rate_gen, uart_tx, uart_rx)
├── constraints/ # XDC file
└── README.md

## Results
Data written through the VIO is transmitted by the TX module, received by the RX module, and observed in the ILA, confirming correct end-to-end operation.

## Future Improvements
- Add parity bit and configurable baud rate
- Add FIFO buffering for TX and RX
- Add a UART-to-AXI interface for Zynq integration
