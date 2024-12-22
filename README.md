# Verilog-Project
The idea that has been selected for this project is a fully functioning digital clock. It will be
implemented on the DE-10 Lite FPGA board, and will have multiple functionalities. 

This includes: 

● The ability to set the current time in 24-hour format.

● A stopwatch with a pause and reset function. 

● A countdown timer with the ability to set the starting time. It will also allow the user to pause and reset the timer. 

● The ability to set an alarm, turn the alarm on, and turn the alarm off. 

In addition, all of the LEDs on the DE-10 Lite will also flash when the alarm time is reached to increase
the alert system. An indicator light will also be turned on if the alarm is turned on.
This project will utilize the switches, LEDs, and seven-segment displays provided on the
DE-10 Lite board.

The main approach for this project primarily relied on creating logic of incrementing and
decrementing the values correctly on the seven segment display. When incrementing, the
values on the display should increment correctly, and have the correct behaviour. For
example, changing from 59 seconds (00:00:59) to 1 minute (00:01:00) or changing from
9:59:59 to 10:00:00. When decrementing, the values on the display should decrement
correctly, and changing the values accordingly. For example, changing the value from 1 hour
(1:00:00) to 59 minutes and 59 seconds (00:59:59).
