module Lab7 (CLOCK_50, KEY, SW, LEDR, HEX7, HEX6, HEX5, HEX4, HEX3, HEX2, HEX1, HEX0);
  input CLOCK_50;
  input [3:0] KEY;
  input [2:0] SW;
  output reg [17:0] LEDR;
  output [0:6] HEX7, HEX6, HEX5, HEX4, HEX3, HEX2, HEX1, HEX0;
parameter [14:0] Q 14'b11011010110000, R=14'b10110100000000,S=14'b10101000000000,T=14'b11000000000000,U=14'b10101100000000,V=14'101010110000000,W14'101101100000000, X=14'110101011000000;
  wire [25:0] HALFSEC;
  wire HALFPULSE;
  wire [3:0] INDEX;

  wire reset;

  reg half;
  reg [13:0] SIGNAL;



  // generate half second clock
  counter_modk C0 (CLOCK_50, KEY[0], HALFSEC);
  defparam C0.n = 26;
  defparam C0.k = 2;

  // generate half second pulse (full second signal with 50% duty cycle)
  counter_modk C1 (half, KEY[0], HALFPULSE);
  defparam C1.n = 1;
  defparam C1.k = 2;

  always @ (negedge CLOCK_50) begin
    if (HALFSEC == 1)
      half = 1;
    else
      half = 0;
  end

/*
Q 14'b11011010110000
R 14'b10110100000000
S 14'b10101000000000
T 14'b11000000000000
U 14'b10101100000000
V 14'101010110000000
W 14'101101100000000
X 14'110101011000000
*/

  always @ (negedge KEY[1]) begin
    case (SW[2:0])
      0: SIGNAL = 14'b11011010110000; // Q
      1: SIGNAL = 14'b10110100000000; // R
      2: SIGNAL = 14'b10101000000000; // S
      3: SIGNAL = 14'b11000000000000; // T
      4: SIGNAL = 14'b10101100000000; // U
      5: SIGNAL = 14'b10101011000000; // V
      6: SIGNAL = 14'b10110110000000; // W
      7: SIGNAL = 14'b11010101100000; // X
    endcase
  end

  assign reset = KEY[1] && KEY[0];


  counter_modk C2 (HALFPULSE, reset, INDEX);
  defparam C2.n = 4;
  defparam C2.k = 14;

  always begin
    case (INDEX)
      0:LEDR[0] = SIGNAL[13];
      1:LEDR[0] = SIGNAL[12];
      2:LEDR[0] = SIGNAL[11];
      3:LEDR[0] = SIGNAL[10];
      4:LEDR[0] = SIGNAL[9];
      5:LEDR[0] = SIGNAL[8];
      6:LEDR[0] = SIGNAL[7];
      7:LEDR[0] = SIGNAL[6];
      8:LEDR[0] = SIGNAL[5];
      9:LEDR[0] = SIGNAL[4];
      10:LEDR[0] = SIGNAL[3];
      11:LEDR[0] = SIGNAL[2];
      12:LEDR[0] = SIGNAL[1];
      13:LEDR[0] = SIGNAL[0];
    endcase
  end

  /*
  twodigit_b2d_ssd D7 (HOURS, HEX7, HEX6);
  twodigit_b2d_ssd D5 (MINUTES, HEX5, HEX4);
  twodigit_b2d_ssd D3 (SECONDS, HEX3, HEX2);
  assign HEX1 = 7'b1111111;
  assign HEX0 = 7'b1111111;
  */

  //always LEDR[1] = HALFPULSE;
endmodule

module b2d_ssd (X, SSD);
  input [3:0] X;
  output reg [0:6] SSD;

  always begin
    case(X)
      0:SSD=7'b0000001;
      1:SSD=7'b1001111;
      2:SSD=7'b0010010;
      3:SSD=7'b0000110;
      4:SSD=7'b1001100;
      5:SSD=7'b0100100;
      6:SSD=7'b0100000;
      7:SSD=7'b0001111;
      8:SSD=7'b0000000;
      9:SSD=7'b0001100;
    endcase
  end
endmodule

module twodigit_b2d_ssd (X, SSD1, SSD0);
  input [6:0] X;
  output [0:6] SSD1, SSD0;

  reg [3:0] ONES, TENS;

  always begin
    ONES = X % 10;
    TENS = (X - ONES) / 10;
  end

  b2d_ssd B1 (TENS, SSD1);
  b2d_ssd B0 (ONES, SSD0);
endmodule
