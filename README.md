# AstroTinker Bot Project

![AstroTinker Bot](link-to-bot-image)
![Arena](link-to-arena-image)

## Overview

The AstroTinker Bot project is a comprehensive initiative aimed at constructing a fully functional robot using an FPGA (Field Programmable Gate Array) as its core. The project involves the design, implementation, and testing of a sophisticated CPU architecture using Verilog HDL to leverage the parallel processing capabilities of FPGAs. The AstroTinker Bot is equipped with sensors and actuators for navigation and interaction within an arena, including the ability to perceive its environment and manipulate objects from an electronics warehouse. Wireless communication is utilized for information exchange with a central hub.

## Project Structure

### 1. Introduction
The purpose of the AstroTinker Bot project is to create a robot that demonstrates the power and versatility of FPGAs in robotics and parallel processing. This project encompasses:
- **Design and construction of hardware**
- **Programming of control algorithms in Verilog HDL**
- **Integration of sensors and actuators**
- **Setting up wireless communication for data exchange**

### 2. Hardware Components
The AstroTinker Bot requires a variety of hardware components to function effectively:
- **FPGA Board:** Central processing unit for the robot.
- **Motors and Wheels:** For movement and navigation.
- **Sensors:** Ultrasonic and line follower sensors for environmental perception.
- **Actuators:** For tasks such as object manipulation.
- **Communication Modules:** Bluetooth modules for wireless data exchange.
- **Power Supply:** Batteries and connectors.
- **Additional Components:** Motor drivers, level shifters, etc.

### 3. Software Components
The software aspect of the project includes:
- **Verilog HDL:** For designing the CPU architecture and implementing control logic.
- **Control Algorithms:** For autonomous navigation and object manipulation.
- **Communication Protocols:** For reliable communication with the central hub.

### 4. Implementation Steps
The implementation of the AstroTinker Bot follows a structured approach:

1. **FPGA Setup:**
   - Configure the FPGA development board.
   - Install necessary software tools.

2. **Verilog Programming:**
   - Write and test the CPU architecture and control logic in Verilog HDL.

3. **Sensor Integration:**
   - Connect and calibrate sensors for accurate environmental perception.

4. **Actuator Control:**
   - Implement and test motor control algorithms for precise movement and manipulation.

5. **Wireless Communication:**
   - Set up and test the wireless communication modules for data exchange.

6. **System Integration:**
   - Combine all components and perform comprehensive testing to ensure seamless operation.

### 5. Testing and Validation
Testing and validation are critical components of the project:
- **Unit Testing:** Conduct tests on individual components such as sensors, actuators, and communication modules.
- **Integration Testing:** Verify the interactions between different components to confirm they work together as expected.
- **Performance Evaluation:** Assess the robot's capabilities in various scenarios within the arena, ensuring it meets the project requirements and performs reliably under different conditions.

### 6. Usage
To use the AstroTinker Bot:
1. **Initialization:** Power on the FPGA and initialize the system.
2. **Operation:** Use the control algorithms to navigate the arena, perceive the environment, and manipulate objects.
3. **Communication:** Monitor and control the robot through the wireless communication interface, ensuring real-time interaction with the central hub.



### 11. RISC-V CPU Design for Path Planning
In this task, teams need to design a RISC-V CPU capable of executing the developed path planning algorithm from the previous task:
- **Data Memory Interaction:**
  - Read the start and end points from the data memory.
  - Compute a path connecting the start and end points.
  - Write the node points connecting the start and end points back to the data memory.

- **Module Instantiation Approach:**
  - Create Verilog modules for each functional block.
  - Instantiate these modules within the CPU module to provide modularity and a structured, scalable design.

- **RTL Simulation:**
  - Run the RTL simulation once the CPU implementation for the path planning algorithm is ready.
  - Check the ModelSim simulation window for required messages and error checking.

## Conclusion
The AstroTinker Bot project is a testament to the capabilities of FPGAs in robotics, offering a practical application of parallel processing and control logic. By participating in this project, teams gain valuable experience in hardware design, programming, and system integration, paving the way for future innovations in the field of robotics.
