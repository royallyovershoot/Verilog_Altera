module EX1(SW,KEY,LEDR);

input [9:0] SW;
input [0:3] KEY;
output [7:0] LEDR;
wire [7:0] Q;
parameter m=7;
mux1 firstmx(1,0,SW[8],out_1);
mux2dff firstdff(SW[m-0],out_1,SW[9],KEY[0],LEDR[m-7]);

mux1 firstmx1(LEDR[0],0,SW[8],out_11);
mux2dff firstdff1(SW[m-1],out_11,SW[9],KEY[0],LEDR[m-6]);


mux1 firstmx2(1,LEDR[m-6],SW[8],out_2);
mux2dff firstdff2(SW[m-2],out_2,SW[9],KEY[0],LEDR[m-5]);

mux1 firstmx3(1,LEDR[m-5],SW[8],out_3);
mux2dff firstdff3(SW[m-3],out_3,SW[9],KEY[0],LEDR[m-4]);

mux1 firstmx4(1,LEDR[m-4],SW[8],out_4);
mux2dff firstdff4(SW[m-4],out_4,SW[9],KEY[0],LEDR[m-3]);

mux1 firstmx5(1,LEDR[m-3],SW[8],out_5);
mux2dff firstdff5(SW[m-5],out_5,SW[9],KEY[0],LEDR[m-2]);

mux1 firstmx6(1,LEDR[m-2],SW[8],out_6);
mux2dff firstdff6(SW[m-6],out_6,SW[9],KEY[0],LEDR[m-1]);

mux1 firstmx7(1,LEDR[m-1],SW[8],out_7);
mux2dff firstdff7(SW[m-7],out_7,SW[9],KEY[0],LEDR[m-0]);

endmodule

module mux1(in1,in2,select,out_1);
input in1,in2,select;
output  out_1;
assign out_1=select?in1:in2;
endmodule


module mux2dff(in1,in2,select,clk,out_2);
parameter n=0;
input [n:0] in1;
input in2,select,clk;
output reg [n:0] out_2;
wire temp=in1[0];
wire temp2=in1[n];

always @(posedge clk)
if (select == in2)
begin 
	out_2=in1[n:0]>>1;
	out_2[n]=temp;
	end
else if(select & in2)
begin
	out_2=in1[n:0]<<1;
	out_2[0]=temp2;
end
else if(~(select | in2))
out_2<=in1;

endmodule

 




