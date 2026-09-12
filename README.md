# AXI4-Lite Master – UVM Verification

## Overview

This project implements an AXI4-Lite master in SystemVerilog and
verifies its functionality using a UVM-based verification environment.

The verification environment includes constrained-random stimulus,
functional coverage, SystemVerilog Assertions (SVA), monitoring,
scoreboarding, and protocol-level checking.

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
