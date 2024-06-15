# E8004 - Project Work - EPEE-06 A small scale lab setup for investigating grid converter control
The repository is for the course ELEC-E8004 - Project Work

# Abstract

Grid-connected converters play an increasingly important role in modern power systems. Understanding their operation is important for renewable energy integration and attaining carbon-free electricity generation. The project aimed to participate in this endeavour by assembling a small-scale, low voltage test setup consisting of two converters connected in parallel. State-of-the-art control methods, chosen according to the hardware configuration, were implemented to examine the system's performance in different grid conditions. 

The project began with the formulation of a circuit diagram, based on which simulation models were subsequently developed. Then, a hardware setup was assembled, comprising components like a DC power supply, filter inductors, circuit breakers for overcurrent protection and passive resistive loads. The converters, combined with microcontrollers, act as the central control unit for the system. Software versions of the control methods were developed in MATLAB/Simulink and uploaded to the microcontrollers, which then control the converters. Real-time measurements were obtained from the setup through serial communication between the host machine and the microcontrollers. 

Control methods for grid-connected converters can be classified into grid-following (GFL) and grid-forming (GFM). Given the utilization of L-filters in the setup, suitable control methods from both categories were chosen and deployed to the converter units, to study how they operate when connected in parallel. Experimental results were obtained, showcasing the characteristics of different control methods during connection to an existing grid, power reference tracking, islanded mode operation, and common grid faults such as grid voltage drops and frequency fluctuations.

# To do List:
- Software:
  - ~~Simulating the basic model using "Control of Electric Drives and Power Converters Course" assignment-2 as reference.~~
  - ~~Simulating a single grid forming converter with L filter.~~
  - ~~Simulating parallel connection.~~
  - ~~Simulating Power Synchronization Control (PSC) model.~~
  - ~~Simulating Reference Feedforward Power Synchronization Control (RFPSC) model.~~
  - ~~Discretization of theta value, using discrete highpass filter and lowpass filter, using a single memory block.~~
  - ~~Designing a lowpass filter for pcc voltage measurement.~~
  - ~~Implementing an overcurrent protection block on the simulation models.~~
  - ~~Checking the gains and parameters for PSC/RFPSC (for peak-value scaled space vectors, specifically K and kappa).~~
  - ~~Implementing software functionality to prevent integrator windup in the control.~~
  - ~~Grid power measurement for plotting and comparison.~~
  - ~~Generating MATLAB plots for the final report.~~
  - ~~Fix parallel simultion PCC voltage equation~~
  - ~~GFL simulation~~
  - ~~PSC simulation~~
  - ~~Simulation results for final report~~
  - ~~Cleaning up of simulation models~~
  
- Hardware:
  - ~~Setting up the initial setup (connecting the filter inductances, grid inductances and passive load resistances to converter, microcontroller and DC supply).~~
  - ~~Setting up parallel connection.~~
  - ~~Testing both converters.~~
  - ~~Making a voltage divider circuit to measure pcc voltage and have live plotting.~~
  - ~~Using a potentiometer for reference active power control.~~
  - ~~Adding a button for enabling/disabling inverter output and/or resetting software protection.~~
  - ~~Checking bi-directionality of converters, feeding one converter with another.~~
  - ~~GFL hw model~~
  - ~~Cleaning up of hw models~~
 
- Interface:
  - ~~Figuring out simulink blocks for interfacing with the microcontroller.~~
  - ~~Figuring out ADC pins for measurement.~~
  - ~~Scaling measured voltages and currents for feedback.~~
  - ~~Importing measured data from Simulink for plotting.~~
 
- Final report/gala:
  - ~~Getting results from different scenarios (simulation and hw)~~
  - ~~Schematic of microcontroller/inverter wiring, including PCC voltage measurement~~
  - ~~Reviewing the final report document~~.
 
- Misc:
  - ~~Pushing all lates files to repo and cleaning up old files~~

 - Extensions:
   - Adding grid voltage into simulation models (added to single converter simulations).
   - ~~Connecting the setup to regatron for studying behavior.~~
   - More test scenarios with regatron
   - Making a seperate inductor switching circuit to test the system with different inductance values.
   - Testing the setup with one converter acting as the source, and the other acting as the load.
   - Studying centralized grid control (may be Synchronous Power Control)??
  
 
