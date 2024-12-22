// Vincent Mai 217990136
// Minhyeok An 217078668

module project(HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, clk, btn, SW, LEDR);

	output[7:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	output[9:0] LEDR;
	input clk;
	input [9:0] SW;
	input [1:0] btn;

	wire top_btn = btn[0];
	wire bot_btn = btn[1];
	
	reg [3:0] sec0;
	reg [3:0] sec1;
	reg [3:0] min0;
	reg [3:0] min1;
	reg [3:0] hr0;
	reg [3:0] hr1;
	
	wire [3:0] s0; 
	wire [3:0] s1;
	wire [3:0] m0; 
	wire [3:0] m1;
	wire [3:0] h0; 
	wire [3:0] h1;
	
	assign s0 = sec0;
	assign s1 = sec1;
	assign m0 = min0;
	assign m1 = min1;
	assign h0 = hr0;
	assign h1 = hr1;
	
	assign stpwtch = SW[0];
	assign timer = SW[1];
	assign secset = SW[2];
	assign minset = SW[3];
	assign hrset = SW[4];
	assign sw5 = SW[5]; // Not used
	assign sw6 = SW[6]; // Not used
	assign alarmset = SW[7];
	assign alarm = SW[8];
	assign clocktime = SW[9];
	
	
	reg [3:0] alarmsec0;
	reg [3:0] alarmsec1;
	reg [3:0] alarmmin0;
	reg [3:0] alarmmin1;
	reg [3:0] alarmhr0;
	reg [3:0] alarmhr1;
	
	reg topval = 0;
	wire top = topval;
	
	reg [9:0] on;
	assign LEDR[9:0] = on;
	

	initial begin
	
		sec0 <= 4'b0000;
		sec1 <= 4'b0000;
		min0 <= 4'b0000;
		min1 <= 4'b0000;
		hr0 <= 4'b0000;
		hr1 <= 4'b0000;
		
	end
	
	always @ (posedge clk) begin
	
	
		// All switches down, blinking LEDs, reset values
		if(~timer & ~stpwtch & ~secset & ~minset & ~hrset & ~alarmset & ~alarm & ~clocktime) begin
			
			on <=~on;
			sec0 <= 4'b0000;
			sec1 <= 4'b0000;
			min0 <= 4'b0000;
			min1 <= 4'b0000;
			hr0 <= 4'b0000;
			hr1 <= 4'b0000;
		
		end
		
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		// Clock
		if (~timer & ~stpwtch & clocktime) begin
		
			// Setting The clock Time
			if (hrset | minset | secset | alarmset) begin
			
				sec0 <= sec0;
				sec1 <= sec1;
				
				min0 <= min0;
				min1 <= min1;
			
				hr0 <= hr0;
				hr1 <= hr1;
				
				// set the hours
				if (hrset & ~minset & ~secset & ~bot_btn) begin
				
					hr0 <= hr0 + 1'b1;
					
					// adds to tens place
					if(hr0 == 4'b1001) begin
					
						hr0 <= 4'b0000;
						hr1 <= hr1 + 1'b1;
					
					end
					
					// set back to 0	
					if(hr0 == 4'b0011 & hr1 == 4'b0010) begin
							
							hr0 <= 4'b0000;
							hr1 <= 4'b0000;
									
					end				
					
				end
				
				// Set the minutes
				if (minset & ~hrset & ~secset & ~bot_btn) begin
				
					min0 <= min0 + 1'b1;
					
					// add to tens place
					if(min0 == 4'b1001) begin
					
						min0 <= 4'b0000;
						min1 <= min1 + 1'b1;
					
					end
					
					// set back to 0	
					if(min0 == 4'b1001 & min1 == 4'b0101) begin
							
							min0 <= 4'b0000;
							min1 <= 4'b0000;
									
					end
				
				end
				
				// Set the seconds
				if (secset & ~minset & ~hrset & ~bot_btn) begin
				
					sec0 <= sec0 + 1'b1;
					
					// add to tens place
					if(sec0 == 4'b1001) begin
					
						sec0 <= 4'b0000;
						sec1 <= sec1 + 1'b1;
					
					end
					
					// set back to 0	
					if(sec0 == 4'b1001 & sec1 == 4'b0101) begin
							
							sec0 <= 4'b0000;
							sec1 <= 4'b0000;
									
					end
				
				end
				
				// Set Alarm Switch is ON
				if (alarmset) begin
				
					// Saving Alarm Time					
					alarmsec0 <= sec0;
					alarmsec1 <= sec1;
					alarmmin0 <= min0;
					alarmmin1 <= min1;
					alarmhr0 <= hr0;
					alarmhr1 <= hr1;
				
				end

			// Display Clock Time
			end else begin
			
				// check If Alarm Time Is Reached and Alarmed is turned ON
				if (alarmmin0 == min0 & alarmmin1 == min1 & alarmhr0 == hr0 & alarmhr1 == hr1 & alarmsec0 == sec0 & alarmsec1 == sec1 & alarm) begin
				
					on <=~on;
				
				// add 1 second
				end else begin 
				
					sec0 <= sec0 + 1'b1;
					
					if (sec0 == 4'b1001) begin
					
					// add 1 to ten's place for seconds
					sec1 <= sec1 + 1'b1;
					sec0 <= 4'b0000;
					
						// add 1 minute
						if(sec0 == 4'b1001 & sec1 == 4'b0101) begin
						
							min0 <= min0 + 1'b1;
							sec1 <= 4'b0000;
							
							if(min0 == 4'b1001) begin
							
								// add 1 to ten's place for minutes
								min1 <= min1 + 1'b1;
								min0 <= 4'b0000;
								
								// add 1 hour
								if(min0 == 4'b1001 & min1 == 4'b0101) begin
								
									hr0 <= hr0 + 1'b1;
									min1 <= 4'b0000;
									
									if(hr0 == 4'b1001) begin
							
										// add 1 to ten's place for minutes
										hr1 <= hr1 + 1'b1;
										hr0 <= 4'b0000;
										
									end
									
									
									// changes from 23:59:59 to 00:00:00
									if(hr0 == 4'b0011 & hr1 == 4'b0010) begin
									
										hr0 <= 4'b0000;
										hr1 <= 4'b0000;
											
									end
									
								end
							
							end
						
						end		
							
					end
				
				end
					
			end
		
		end
		
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		// Stopwatch Mode
		if(stpwtch & ~timer) begin
		
			if(~bot_btn) begin
			
				sec0 <= 4'b0000;
				sec1 <= 4'b0000;
			
				min0 <= 4'b0000;
				min1 <= 4'b0000;
			
				hr0 <= 4'b0000;
				hr1 <= 4'b0000;
			
			end else begin
		
				// Pause
				if (~topval) begin
				
					sec0 <= sec0;
					sec1 <= sec1;
					
					min0 <= min0;
					min1 <= min1;
				
					hr0 <= hr0;
					hr1 <= hr1;
					
				// Display Stopwatch Time, Counting Up
				end else begin
				
					// add 1 second
					sec0 <= sec0 + 1'b1;
					
				
					if (sec0 == 'b1001) begin
						// add 1 to ten's place for seconds
						sec1 <= sec1 + 1'b1;
						sec0 <= 4'b0000;
						
						// add 1 minute
						if(sec0 == 'b1001 & sec1 == 'b0101) begin
						
							min0 <= min0 + 1'b1;
							sec1 <= 4'b0000;
							
							if(min0 == 4'b1001) begin
							
								// add 1 to ten's place for minutes
								min1 <= min1 + 1'b1;
								min0 <= 4'b0000;
								
								// add 1 hour
								if(min0 == 4'b1001 & min1 == 4'b0101) begin
						
									hr0 <= hr0 + 1'b1;
									min1 <= 4'b0000;
									
									if(hr0 == 4'b1001) begin
							
										// add 1 to ten's place for hours
										hr1 <= hr1 + 1'b1;
										hr0 <= 4'b0000;
							
									end
									
									if(hr0 == 4'b1001 & hr1 == 4'b1001) begin
									
										hr0 <= 4'b0000;
										hr1 <= 4'b0000;
									
									end
									
								end
								
							end
						
						end		
							
					end
					
				end
				
			end
			
		end
		
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		// Timer Mode
		if(timer & ~stpwtch) begin
				
			// Setting The Timer Time
			if (hrset | minset | secset) begin
		
				sec0 <= sec0;
				sec1 <= sec1;
			
				min0 <= min0;
				min1 <= min1;
			
				hr0 <= hr0;
				hr1 <= hr1;
			
				// Set the hours
				if (hrset & ~minset & ~secset & ~bot_btn) begin
			
					hr0 <= hr0 + 1'b1;
				
					// add to tens place
					if(hr0 == 4'b1001) begin
				
						hr0 <= 4'b0000;
						hr1 <= hr1 + 1'b1;
				
						// set back to 0	
						if(hr1 == 4'b1001) begin

							hr1 <= 4'b0000;
									
						end
					
					end
										
				end
			
			
				// Set the minutes
				if (minset & ~hrset & ~secset & ~bot_btn) begin
		
					min0 <= min0 + 1'b1;
					
					// adds to tens place
					if(min0 == 4'b1001) begin
				
						min0 <= 4'b0000;
						min1 <= min1 + 1'b1;
					
						// set back to 0	
						if (min1 == 4'b0101) begin

								min1 <= 4'b0000;
								
						end
									
					end
				
				end
					
				// Set the seconds
				if (secset & ~hrset & ~minset & ~bot_btn) begin
				
					sec0 <= sec0 + 1'b1;
					
					// add to tens place
					if(sec0 == 4'b1001) begin
					
						sec0 <= 4'b0000;
						sec1 <= sec1 + 1'b1;
					
						// set back to 0	
						if (sec1 == 4'b0101) begin
						
								sec1 <= 4'b0000;
										
						end
						
					end
			
				end
					
				
			// Display Timer Time, Counting Down
			end else begin
			
				if (~bot_btn) begin
			
					sec0 <= 4'b0000;
					sec1 <= 4'b0000;
				
					min0 <= 4'b0000;
					min1 <= 4'b0000;
				
					hr0 <= 4'b0000;
					hr1 <= 4'b0000;
			
				end else begin
		
					// Pause
					if (~topval) begin
					
						sec0 <= sec0;
						sec1 <= sec1;
						
						min0 <= min0;
						min1 <= min1;
					
						hr0 <= hr0;
						hr1 <= hr1;
						
					end else begin		
					
						// Timer not finished, != 0:00:00
						if (sec0 != 4'b0000 | sec1 != 4'b0000 | min0 != 4'b0000 | min1 != 4'b0000 | hr0 != 4'b0000 | hr1 != 4'b0000) begin	
								
							// changing hours' tens place
							if (hr1 != 4'b0000 & hr0 == 4'b0000 & min1 == 4'b0000 & min0 == 4'b0000 & sec1 == 4'b0000 & sec0 == 4'b0000) begin
							
								hr1 <= hr1 - 1'b1;
								hr0 <= 4'b1001;
								min1 <= 4'b0101;
								min0 <= 4'b1001;
								sec1 <= 4'b0101;
								sec0 <= 4'b1001;
			
							// changing hours
							end else if (hr0 != 4'b0000 & min1 == 4'b0000 & min0 == 4'b0000 & sec1 == 4'b0000 & sec0 == 4'b0000) begin
								
								hr0 <= hr0 - 1'b1;
								
								min1 <= 4'b0101;
								min0 <= 4'b1001;
								sec1 <= 4'b0101;
								sec0 <= 4'b1001;		
							
							// changing minutes' tens place
							end else if (min1 != 4'b0000 & min0 == 4'b0000 & sec1 == 4'b0000 & sec0 == 4'b0000) begin
							
								min1 <= min1 - 1'b1;
								min0 <= 4'b1001;
								sec1 <= 4'b0101;
								sec0 <= 4'b1001;
			
							// changing minutes
							end else if (min0 != 4'b0000 & sec1 == 4'b0000 & sec0 == 4'b0000) begin
								
								min0 <= min0 - 1'b1;
								sec1 <= 4'b0101;
								sec0 <= 4'b1001;
														
							// changing from 1 minute to 59 seconds
							end else if (min0 == 4'b0001 & sec1 == 4'b0000 & sec0 == 4'b0000) begin
							
								min0 <= 4'b0000;
								sec1 <= 4'b0101;
								sec0 <= 4'b1001;
							
							end else if (sec0 == 'b0000) begin
							
								// subtract 1 to ten's place for seconds
								sec1 <= sec1 - 1'b1;
								sec0 <= 4'b1001;		
									
							end else begin
							
								// subtract 1 second
								sec0 <= sec0 - 1'b1;

							end
					
						// Timer finishes, 0:00:00
						end else begin
						
							// flashes LEDs
							on <=~on;						
						
						end
					
					
					end
					
				end
		
			end
				
		end
		
	end
		
	
	
	always @ (posedge top_btn) begin
		topval <= ~topval;
	end
	
	
	outputHex o0(s0[3], s0[2], s0[1], s0[0], alarm, HEX0); // Visual that alarm is set to ON/OFF
	outputHex o1(s1[3], s1[2], s1[1], s1[0], 0, HEX1);
	
	outputHex o2(m0[3], m0[2], m0[1], m0[0], 1, HEX2);
	outputHex o3(m1[3], m1[2], m1[1], m1[0], 0, HEX3);
	
	outputHex o4(h0[3], h0[2], h0[1], h0[0], 1, HEX4);
	outputHex o5(h1[3], h1[2], h1[1], h1[0], 0, HEX5);
	
	
endmodule

