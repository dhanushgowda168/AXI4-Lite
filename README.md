# AXI4-Lite Master – UVM Verification

## Overview

This project develops a SystemVerilog/UVM-based verification environment for an AXI4-Lite, including constrained-random stimulus, functional coverage, SystemVerilog assertions, monitoring, and scoreboard-based checking.

## RTL Design

The AXI4-Lite implements:

- Read address channel
- Read data channel
- Write address channel
- Write data channel
- Write response channel
- VALID-READY handshake mechanism
- Reset handling
- Parameterized address and data widths

## UVM Verification Environment

The testbench consists of:
- Sequence Item
- Sequence
- Sequencer
- Driver
- Monitor
- Agent
- Scoreboard
- Environment
- Test

## Verification Features
- Constrained-random transaction generation
- Functional coverage
- SystemVerilog Assertions
- Scoreboard-based checking
- AXI4-Lite read/write transaction verification

## Results
Functional coverage: **95.33%**

## Tools
- SystemVerilog
- UVM
- Cadence Xcelium

## Repository Structure

rtl/          RTL implementation
tb/           UVM verification environment
assertions/   SystemVerilog assertions
coverage/     Functional coverage
