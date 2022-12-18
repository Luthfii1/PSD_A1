# PSD_A1_HandWashAutomatic

This is a project for 'Praktikum Perancangan Sistem Digital'. Our group, PSD - A /1, build an automatic hand wash system with controlled temperature (Hot, Cold, and Normal). The goal of this project is to develop a system that can automatically dispense water with the chosen temperature, counter for how many times the machines has been used, and monitor the duration every 8 seconds of hand washing to ensure adequate hand hygiene.

## Features
- Automatic water dispensing with the control of the temperature
- Timer to monitor hand washing duration
- Counter to show how many times the machine has been used
- LED to show which temperature was chosen
- User-friendly interface

## Requirements
- A water source
- Hand Sensor
- Temperature Button (Hot, Cold, Normal)
- 7-Segment Display for timer and counter

## Usage from Code

Our project uses input in 2-bit (temperature for finite state machine) to determine which temperature what the user want. In addition to that, our project needs to detect whether there is a hand under the faucet to give output that will be shown on 4 7-Segment Display. 1 of 7-Segment Display shows a timer for every 8 seconds and the other 3 shows a counter to determine how many times the machine has been used. Because the output is in 8-bit, our project has a converter to convert 8-bit to BCD. If the user wants to stop washing their hands, they can simply took of their hands from under the faucet so that our sensor system can't detect any hands and the faucet won't deliver water again.

## Implementation in Real Life
- Press the button on the user interface to choose which temperature the user wants
- Place hands under the water dispenser
- Continue to wash hands (8 seconds)
- Step out from the water dispenser
- Dry hands and exit the system

## Video Presentasi Proyek Akhir
https://youtu.be/-HLDXsXVzCk
