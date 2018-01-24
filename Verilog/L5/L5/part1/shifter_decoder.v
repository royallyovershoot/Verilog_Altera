module shifter_decoder(a,h3,h2,h1,h0);

		input[1:0] a;
		output[6:0] h3,h2,h1,h0;
		reg[1:0] h33,h22,h11,h00;
		
		always @*
		case(a)
		2'b00:
		begin
		h33 = 2'b00;
		h22 = 2'b01;
		h11 = 2'b11;
		h00 = 2'b10;
		end
		2'b01:
		begin
		h33 = 2'b10;
		h22 = 2'b00;
		h11 = 2'b01;
		h00 = 2'b11;
		end
		2'b10:
		begin
		h33 = 2'b11;
		h22 = 2'b10;
		h11 = 2'b00;
		h00 = 2'b01;
		end
		2'b11:
		begin
		h33 = 2'b01;
		h22 = 2'b11;
		h11 = 2'b10;
		h00 = 2'b00;
		end
		endcase
		
		hexto7segment H3(h33,h3);
		hexto7segment H2(h22,h2);
		hexto7segment H1(h11,h1);
		hexto7segment H0(h00,h0);
		
		

endmodule
