module part2(SW,KEY,LEDR,HEX3,HEX2,HEX1,HEX0);
		
		input[17:0] SW;
		input[0:0] KEY;
		output[17:0] LEDR;
		output[6:0]	HEX3,HEX2,HEX1,HEX0;
		
		wire[15:0] product;
		reg[7:0] A,B;
		
		always @(posedge KEY[0])
		begin
			if ( SW[8])
			 A <= SW[7:0];
			else if ( SW[9])
			B <= SW[7:0];
		end	
		
		assign product = A*B;
		
		hexto7segment H3(product[15:12],HEX3);
		hexto7segment H2(product[11:8],HEX2);
		hexto7segment H1(product[7:4],HEX1);
		hexto7segment H0(product[3:0],HEX0);
		
		assign LEDR = product;

endmodule 