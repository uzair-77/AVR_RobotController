
# AVR Motor Control with Sensors and LEDs

This repository contains a C code implementation for an AVR microcontroller-based control system, designed to manage motor operations and sensor interactions for a robotic car. The code leverages various peripherals such as LEDs, a buzzer, and external interrupts to create a responsive and interactive robotic car.

## Project Description

The project demonstrates how to use AVR microcontroller features to control a robotic car with motor and sensor integration. The code provides functionalities for detecting obstacles, controlling motor movement, and providing visual and auditory feedback through LEDs and a buzzer.

### Key Features

- **Motor Control**: Directs the movement of the robotic car using external motor drivers connected to specific AVR I/O pins.
- **Sensor Integration**: Uses external sensors to detect obstacles and influence the behavior of the car.
- **LED Indicators**: Provides visual feedback on the state of the car using LEDs.
- **Buzzer Alerts**: Emits sound signals to indicate specific events or conditions.
- **Interrupt Handling**: Utilizes external interrupts to respond promptly to obstacle detection.

### Hardware Connections

- **LEDs**: Connected to PORTC pins (PC0 - PC3) to indicate different states of the car.
- **Buzzer**: Connected to PD0 to produce sound alerts.
- **Motors**: Controlled via PD1 and PD4 for movement.
- **Sensors**: Connected to PD2 and PC4 for obstacle detection.

### Code Overview

1. **Initialization**:
   - Configures PORTC for LED outputs and sets initial states.
   - Configures PORTD for motor control and sensor inputs.
   - Sets up external interrupts for obstacle detection (INT0).

2. **Main Loop**:
   - Monitors the state of SENSOR3 (PC4). If not pressed, it moves the car forward and lights up LEDs.
   - If SENSOR3 is pressed, it stops the car, activates the buzzer, and performs a 90-degree turn.

3. **Interrupt Service Routine for INT0**:
   - Activates when an obstacle is detected by SENSOR1 (PD2).
   - Stops the car, toggles LEDs, and emits buzzer sounds to alert the user.
   - Re-enables the interrupt for continuous detection.

### Behavior of the Robotic Car

1. **Normal Operation**:
   - **Forward Movement**: When SENSOR3 (PC4) is not pressed, the car moves forward, indicated by LEDs 1 and 2 being lit.
   - **Obstacle Handling**: When SENSOR3 is pressed, the car stops, moves backward briefly, and performs a 90-degree right turn. LEDs 3 and 4 light up during this process.

2. **Obstacle Detection**:
   - **Interrupt Triggered**: If an obstacle is detected by SENSOR1 (PD2), the car stops, LEDs flash, and the buzzer sounds to signal the presence of an obstacle.
   - **Post-Detection Actions**: The car resumes forward movement after a short delay and obstacle alert sequence.

### Hardware Setup

To set up this code on an AVR32 microcontroller:

1. **Connect Motors**:
   - Connect the motor driver inputs to PD1 and PD4.

2. **Connect LEDs**:
   - Connect LEDs to PORTC pins (PC0 - PC3) with appropriate current-limiting resistors.

3. **Connect Sensors**:
   - Connect obstacle sensors to PD2 and PC4.

4. **Connect Buzzer**:
   - Connect the buzzer to PD0.

5. **Compile and Upload**:
   - Compile the code using an AVR-compatible compiler.
   - Upload the binary to the AVR32 microcontroller using an appropriate programmer.
   - 

### Explanation of Robotic Car Movement

When this code is fed into an AVR32 microcontroller, the robotic car will:

1. **Move Forward**: When no obstacle is detected (SENSOR3 is not pressed), the car moves forward with LEDs 1 and 2 indicating its movement.
2. **Handle Obstacles**: When SENSOR3 is pressed, the car stops, moves backward for a short duration, then performs a 90-degree right turn. During this time, LEDs 3 and 4 light up, and the buzzer emits a sound.
3. **Respond to Obstacle Detection**: If an obstacle is detected by SENSOR1, the car will stop, LEDs will flash, and the buzzer will sound to alert the presence of an obstacle. The car will then resume its movement after handling the obstacle.

This code provides a basic framework for controlling a robotic car using an AVR microcontroller, demonstrating fundamental concepts in embedded systems and robotics.


### License

This repository is licensed under the MIT License. See the [LICENSE](LICENSE) file for more details.
