module hexto7segment(x,y);

          input[1:0] x;
			 reg[6:0] z;
			 output[6:0] y;
always @*
case (x)
2'b00 :      	//Hexadecimal P
z = 7'b0001100;
2'b01 :    		//Hexadecimal A
z = 7'b0001000;
2'b11 :  		// Hexadecimal S
z = 7'b0010010; 
2'b10 :  		// Hexadecimal S
z = 7'b0010010; 
endcase

assign y = z;
 
endmodule
