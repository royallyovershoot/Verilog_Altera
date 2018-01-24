module part1(CLOCK_50,HEX0,HEX1,HEX2,HEX3);
		
		input	CLOCK_50;
		output[6:0] HEX0,HEX1,HEX2,HEX3;
		reg newClock;
		reg[27:0] counter;
		reg[1:0] Q;
	
		
		
		always @(posedge CLOCK_50)
				begin
			 
					counter <= counter + 1;
					if(counter == 25000000)
					begin
						newClock <= ~newClock;
						counter <= 0;
					end
				end
			
		always @(posedge newClock) 
			begin
			Q <= Q + 1;
			
			end
		
			shifter_decoder S1(Q,HEX3,HEX2,HEX1,HEX0);
			
			
				
		 
				
		

endmodule
