# E8004 - Project Work - EPEE-06 A small scale lab setup for investigating grid converter control
The repository is for the course ELEC-E8004 - Project Work

# To do List:
- Software:
  - ~~Simulating the basic model using "Control of Electric Drives and Power Converters Course" assignment-2 as reference.~~
  - ~~Simulating a single grid forming converter with L filter.~~
  - ~~Simulating parallel connection.~~
  - ~~Simulating Power Synchronization Control (PSC) model.~~
  - ~~Simulating Reference Feedforward Power Synchronization Control (RFPSC) model.~~
  - ~~Discretization of theta value, using discrete highpass filter and lowpass filter, using a single memory block.~~
  - ~~Designing a lowpass filter for pcc voltage measurement.~~
  - Grid power measurement for plotting and comparison.
  - Generating MATLAB plots for the final report.
  - Implementing an overcurrent protection block on the simulation models.
  - Adding grid voltage into simulation models.
  - Checking the gains and parameters for PSC/RFPSC (for peak-value scaled space vectors, specifically K and kappa).
  - Creating single simulation model where different control methods can be called via .m-files.
  - Implementing software functionality to prevent integrator windup in the control.
  
- Hardware:
  - ~~Setting up the initial setup (connecting the filter inductances, grid inductances and passive load resistances to converter, microcontroller and DC supply).~~
  - ~~Setting up parallel connection.~~
  - ~~Testing both converters.~~
  - ~~Making a voltage divider circuit to measure pcc voltage and have live plotting.~~
  - ~~Using a potentiometer for reference active power control.~~
  - Adding a button for enabling/disabling inverter output and/or resetting software protection.
  - Checking bi-directionality of converters, feeding one converter with another.
 
- Interface:
  - ~~Figuring out simulink blocks for interfacing with the microcontroller.~~
  - ~~Figuring out ADC pins for measurement.~~
  - ~~Scaling measured voltages and currents for feedback.~~
  - Importing measured data from Simulink for plotting.

 - Extensions:
   - Connecting the setup to regatron for studying behavior.
   - Making a seperate inductor switching circuit to test the system with different inductance values.
   - Testing the setup with one converter acting as the source, and the other acting as the load.
   - Studying centralized grid control (may be Synchronous Power Control)??
  
 
