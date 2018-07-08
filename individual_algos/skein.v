/*
 * Copyright (c) 2018 Sprocket
 *
 * This is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Affero General Public License with
 * additional permissions to the one published by the Free Software
 * Foundation, either version 3 of the License, or (at your option)
 * any later version. For more information see LICENSE.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Affero General Public License for more details.
 *
 * You should have received a copy of the GNU Affero General Public License
 * along with this program. If not, see <http://www.gnu.org/licenses/>.
 */

module skein512 (
	input clk,
	input [511:0] data,
	output [511:0] hash
);

	reg [511:0] h00_d, h00_q, h10_d, h10_q;
	reg [511:0] h00,h01,h02,h03,h04,h05,h06,h07,h08,h09,h0A,h0B,h0C,h0D,h0E,h0F,h0G,h0H;
	reg [511:0] h10,h11,h12,h13,h14,h15,h16,h17,h18,h19,h1A,h1B,h1C,h1D,h1E,h1F,h1G,h1H;
	
	reg [511:0] p00_d, p00_q, p10_q;
	reg [511:0] p00,p01,p02,p03,p04,p05,p06,p07,p08,p09,p0A,p0B,p0C,p0D,p0E,p0F,p0G,p0H;
	reg [511:0] p10,p11,p12,p13,p14,p15,p16,p17,p18,p19,p1A,p1B,p1C,p1D,p1E,p1F,p1G,p1H;

	wire [511:0] o00,o01,o02,o03,o04,o05,o06,o07,o08,o09,o0A,o0B,o0C,o0D,o0E,o0F,o0G,o0H;
	wire [511:0] o10,o11,o12,o13,o14,o15,o16,o17,o18,o19,o1A,o1B,o1C,o1D,o1E,o1F,o1G,o1H;
	wire [511:0] ho00,ho01,ho02,ho03,ho04,ho05,ho06,ho07,ho08,ho09,ho0A,ho0B,ho0C,ho0D,ho0E,ho0F,ho0G,ho0H;
	wire [511:0] ho10,ho11,ho12,ho13,ho14,ho15,ho16,ho17,ho18,ho19,ho1A,ho1B,ho1C,ho1D,ho1E,ho1F,ho1G,ho1H;
	
	reg [511:0] hH;
	reg [511:0] oH;
	
	reg [511:0] h_d, h_q;

	reg [511:0] d00,d01,d02,d03,d04,d05,d06,d07,d08,d09;
	reg [511:0] d10,d11,d12,d13,d14,d15,d16,d17,d18,d19;
	reg [511:0] d20,d21,d22,d23,d24,d25,d26,d27,d28,d29;
	reg [511:0] d30,d31,d32,d33,d34,d35,d36,d37,d38,d39;
	reg [511:0] d40,d41,d42,d43,d44,d45,d46,d47,d48,d49;
	reg [511:0] d50,d51,d52,d53,d54,d55,d56,d57,d58,d59;
	reg [511:0] d60,d61,d62,d63,d64,d65,d66,d67,d68,d69;
	reg [511:0] d70,d71,d72,d73,d74,d75,d76,d77,d78,d79;
	reg [511:0] d80,d81,d82,d83,d84,d85,d86,d87,d88,d89;
	reg [511:0] d90,d91,d92,d93,d94,d95,d96,d97,d98,d99;
	reg [511:0] d100,d101,d102,d103,d104,d105,d106,d107,d108,d109;
	reg [511:0] d110,d111,d112,d113,d114,d115,d116,d117,d118,d119;
	reg [511:0] d120,d121,d122,d123,d124,d125,d126,d127,d128,d129;
	reg [511:0] d130,d131,d132,d133,d134,d135,d136,d137,d138,d139;
	reg [511:0] d140,d141,d142,d143,d144,d145,d146,d147,d148,d149;
	reg [511:0] d150,d151,d152,d153,d154,d155,d156,d157,d158,d159;
	
	assign hash = { h_q[455:448],
			h_q[463:456],
			h_q[471:464],
			h_q[479:472],
			h_q[487:480],
			h_q[495:488],
			h_q[503:496],
			h_q[511:504],
			h_q[391:384],
			h_q[399:392],
			h_q[407:400],
			h_q[415:408],
			h_q[423:416],
			h_q[431:424],
			h_q[439:432],
			h_q[447:440],
			h_q[327:320],
			h_q[335:328],
			h_q[343:336],
			h_q[351:344],
			h_q[359:352],
			h_q[367:360],
			h_q[375:368],
			h_q[383:376],
			h_q[263:256],
			h_q[271:264],
			h_q[279:272],
			h_q[287:280],
			h_q[295:288],
			h_q[303:296],
			h_q[311:304],
			h_q[319:312],
			h_q[199:192],
			h_q[207:200],
			h_q[215:208],
			h_q[223:216],
			h_q[231:224],
			h_q[239:232],
			h_q[247:240],
			h_q[255:248],
			h_q[135:128],
			h_q[143:136],
			h_q[151:144],
			h_q[159:152],
			h_q[167:160],
			h_q[175:168],
			h_q[183:176],
			h_q[191:184],
			h_q[71:64],
			h_q[79:72],
			h_q[87:80],
			h_q[95:88],
			h_q[103:96],
			h_q[111:104],
			h_q[119:112],
			h_q[127:120],
			h_q[7:0],
			h_q[15:8],
			h_q[23:16],
			h_q[31:24],
			h_q[39:32],
			h_q[47:40],
			h_q[55:48],
			h_q[63:56]
		};

	skein_round sr00 (clk,  0, p00_q, h00_q, 64'h0000000000000040, 64'hF000000000000000, o00, ho00);
	skein_round sr01 (clk,  1, p01, h01, 64'hF000000000000000, 64'hF000000000000040, o01, ho01);
	skein_round sr02 (clk,  2, p02, h02, 64'hF000000000000040, 64'h0000000000000040, o02, ho02);
	skein_round sr03 (clk,  3, p03, h03, 64'h0000000000000040, 64'hF000000000000000, o03, ho03);
	skein_round sr04 (clk,  4, p04, h04, 64'hF000000000000000, 64'hF000000000000040, o04, ho04);
	skein_round sr05 (clk,  5, p05, h05, 64'hF000000000000040, 64'h0000000000000040, o05, ho05);
	skein_round sr06 (clk,  6, p06, h06, 64'h0000000000000040, 64'hF000000000000000, o06, ho06);
	skein_round sr07 (clk,  7, p07, h07, 64'hF000000000000000, 64'hF000000000000040, o07, ho07);
	skein_round sr08 (clk,  8, p08, h08, 64'hF000000000000040, 64'h0000000000000040, o08, ho08);
	skein_round sr09 (clk,  9, p09, h09, 64'h0000000000000040, 64'hF000000000000000, o09, ho09);
	skein_round sr0A (clk, 10, p0A, h0A, 64'hF000000000000000, 64'hF000000000000040, o0A, ho0A);
	skein_round sr0B (clk, 11, p0B, h0B, 64'hF000000000000040, 64'h0000000000000040, o0B, ho0B);
	skein_round sr0C (clk, 12, p0C, h0C, 64'h0000000000000040, 64'hF000000000000000, o0C, ho0C);
	skein_round sr0D (clk, 13, p0D, h0D, 64'hF000000000000000, 64'hF000000000000040, o0D, ho0D);
	skein_round sr0E (clk, 14, p0E, h0E, 64'hF000000000000040, 64'h0000000000000040, o0E, ho0E);
	skein_round sr0F (clk, 15, p0F, h0F, 64'h0000000000000040, 64'hF000000000000000, o0F, ho0F);
	skein_round sr0G (clk, 16, p0G, h0G, 64'hF000000000000000, 64'hF000000000000040, o0G, ho0G);
	skein_round sr0H (clk, 17, p0H, h0H, 64'hF000000000000040, 64'h0000000000000040, o0H, ho0H);
                                                                                        
	skein_round sr10 (clk,  0, p10_q, h10_q, 64'h0000000000000008, 64'hFF00000000000000, o10, ho10);
	skein_round sr11 (clk,  1, p11, h11, 64'hFF00000000000000, 64'hFF00000000000008, o11, ho11);
	skein_round sr12 (clk,  2, p12, h12, 64'hFF00000000000008, 64'h0000000000000008, o12, ho12);
	skein_round sr13 (clk,  3, p13, h13, 64'h0000000000000008, 64'hFF00000000000000, o13, ho13);
	skein_round sr14 (clk,  4, p14, h14, 64'hFF00000000000000, 64'hFF00000000000008, o14, ho14);
	skein_round sr15 (clk,  5, p15, h15, 64'hFF00000000000008, 64'h0000000000000008, o15, ho15);
	skein_round sr16 (clk,  6, p16, h16, 64'h0000000000000008, 64'hFF00000000000000, o16, ho16);
	skein_round sr17 (clk,  7, p17, h17, 64'hFF00000000000000, 64'hFF00000000000008, o17, ho17);
	skein_round sr18 (clk,  8, p18, h18, 64'hFF00000000000008, 64'h0000000000000008, o18, ho18);
	skein_round sr19 (clk,  9, p19, h19, 64'h0000000000000008, 64'hFF00000000000000, o19, ho19);
	skein_round sr1A (clk, 10, p1A, h1A, 64'hFF00000000000000, 64'hFF00000000000008, o1A, ho1A);
	skein_round sr1B (clk, 11, p1B, h1B, 64'hFF00000000000008, 64'h0000000000000008, o1B, ho1B);
	skein_round sr1C (clk, 12, p1C, h1C, 64'h0000000000000008, 64'hFF00000000000000, o1C, ho1C);
	skein_round sr1D (clk, 13, p1D, h1D, 64'hFF00000000000000, 64'hFF00000000000008, o1D, ho1D);
	skein_round sr1E (clk, 14, p1E, h1E, 64'hFF00000000000008, 64'h0000000000000008, o1E, ho1E);
	skein_round sr1F (clk, 15, p1F, h1F, 64'h0000000000000008, 64'hFF00000000000000, o1F, ho1F);
	skein_round sr1G (clk, 16, p1G, h1G, 64'hFF00000000000000, 64'hFF00000000000008, o1G, ho1G);
	skein_round sr1H (clk, 17, p1H, h1H, 64'hFF00000000000008, 64'h0000000000000008, o1H, ho1H);

	wire [511:0] data_le;

	genvar i;
	generate
		for( i=0; i < 64 ; i = i + 1) begin: BYTE_REVERSE
			assign data_le[i*8 +: 8] = data[(63-i)*8 +: 8];
		end
	endgenerate

	always @ (*) begin

//		p00_d <= data_le;
		p00_d[511:448] <= data_le[ 63:  0];
		p00_d[447:384] <= data_le[127: 64];
		p00_d[383:320] <= data_le[191:128];
		p00_d[319:256] <= data_le[255:192];
		p00_d[255:192] <= data_le[319:256];
		p00_d[191:128] <= data_le[383:320];
		p00_d[127: 64] <= data_le[447:384];
		p00_d[ 63:  0] <= data_le[511:448];
		h00_d <= 512'h4903ADFF749C51CE0D95DE399746DF038FD1934127C79BCE9A255629FF352CB15DB62599DF6CA7B0EABE394CA9D5C3F4991112C71A75B523AE18A40B660FCC33;

		h10_d[511:448] <= d143[ 63:  0] ^ ( o0H[511:448] + ho0H[511:448] );
		h10_d[447:384] <= d143[127: 64] ^ ( o0H[447:384] + ho0H[447:384] );
		h10_d[383:320] <= d143[191:128] ^ ( o0H[383:320] + ho0H[383:320] );
		h10_d[319:256] <= d143[255:192] ^ ( o0H[319:256] + ho0H[319:256] );
		h10_d[255:192] <= d143[319:256] ^ ( o0H[255:192] + ho0H[255:192] );
		h10_d[191:128] <= d143[383:320] ^ ( o0H[191:128] + ho0H[191:128] + 64'h0000000000000040 );
		h10_d[127: 64] <= d143[447:384] ^ ( o0H[127: 64] + ho0H[127: 64] + 64'hF000000000000000 );
		h10_d[ 63:  0] <= d143[511:448] ^ ( o0H[ 63:  0] + ho0H[ 63:  0] + 64'd18);


		h_d[511:448] <= ( o1H[511:448] + ho1H[511:448] );
		h_d[447:384] <= ( o1H[447:384] + ho1H[447:384] );
		h_d[383:320] <= ( o1H[383:320] + ho1H[383:320] );
		h_d[319:256] <= ( o1H[319:256] + ho1H[319:256] );
		h_d[255:192] <= ( o1H[255:192] + ho1H[255:192] );
		h_d[191:128] <= ( o1H[191:128] + ho1H[191:128] + 64'h0000000000000008 );
		h_d[127: 64] <= ( o1H[127: 64] + ho1H[127: 64] + 64'hFF00000000000000 );
		h_d[ 63:  0] <= ( o1H[ 63:  0] + ho1H[ 63:  0] + 64'd18 );
	
	end

	always @ (posedge clk) begin

		h_q <= h_d;

		p0H <= o0G;
		h0H <= ho0G;
		p0G <= o0F;
		h0G <= ho0F;
		p0F <= o0E;
		h0F <= ho0E;
		p0E <= o0D;
		h0E <= ho0D;
		p0D <= o0C;
		h0D <= ho0C;
		p0C <= o0B;
		h0C <= ho0B;
		p0B <= o0A;
		h0B <= ho0A;
		p0A <= o09;
		h0A <= ho09;
		p09 <= o08;
		h09 <= ho08;
		p08 <= o07;
		h08 <= ho07;
		p07 <= o06;
		h07 <= ho06;
		p06 <= o05;
		h06 <= ho05;
		p05 <= o04;
		h05 <= ho04;
		p04 <= o03;
		h04 <= ho03;
		p03 <= o02;
		h03 <= ho02;
		p02 <= o01;
		h02 <= ho01;
		p01 <= o00;
		h01 <= ho00;
		p00_q <= p00_d;
		h00_q <= h00_d;

		p1H <= o1G;
		h1H <= ho1G;
		p1G <= o1F;
		h1G <= ho1F;
		p1F <= o1E;
		h1F <= ho1E;
		p1E <= o1D;
		h1E <= ho1D;
		p1D <= o1C;
		h1D <= ho1C;
		p1C <= o1B;
		h1C <= ho1B;
		p1B <= o1A;
		h1B <= ho1A;
		p1A <= o19;
		h1A <= ho19;
		p19 <= o18;
		h19 <= ho18;
		p18 <= o17;
		h18 <= ho17;
		p17 <= o16;
		h17 <= ho16;
		p16 <= o15;
		h16 <= ho15;
		p15 <= o14;
		h15 <= ho14;
		p14 <= o13;
		h14 <= ho13;
		p13 <= o12;
		h13 <= ho12;
		p12 <= o11;
		h12 <= ho11;
		p11 <= o10;
		h11 <= ho10;
		p10_q <= 512'd0;
		h10_q <= h10_d;

		d00 <= data_le;
		d01 <= d00;
		d02 <= d01;
		d03 <= d02;
		d04 <= d03;
		d05 <= d04;
		d06 <= d05;
		d07 <= d06;
		d08 <= d07;
		d09 <= d08;
		d10 <= d09;
		d11 <= d10;
		d12 <= d11;
		d13 <= d12;
		d14 <= d13;
		d15 <= d14;
		d16 <= d15;
		d17 <= d16;
		d18 <= d17;
		d19 <= d18;
		d20 <= d19;
		d21 <= d20;
		d22 <= d21;
		d23 <= d22;
		d24 <= d23;
		d25 <= d24;
		d26 <= d25;
		d27 <= d26;
		d28 <= d27;
		d29 <= d28;
		d30 <= d29;
		d31 <= d30;
		d32 <= d31;
		d33 <= d32;
		d34 <= d33;
		d35 <= d34;
		d36 <= d35;
		d37 <= d36;
		d38 <= d37;
		d39 <= d38;
		d40 <= d39;
		d41 <= d40;
		d42 <= d41;
		d43 <= d42;
		d44 <= d43;
		d45 <= d44;
		d46 <= d45;
		d47 <= d46;
		d48 <= d47;
		d49 <= d48;
		d50 <= d49;
		d51 <= d50;
		d52 <= d51;
		d53 <= d52;
		d54 <= d53;
		d55 <= d54;
		d56 <= d55;
		d57 <= d56;
		d58 <= d57;
		d59 <= d58;
		d60 <= d59;
		d61 <= d60;
		d62 <= d61;
		d63 <= d62;
		d64 <= d63;
		d65 <= d64;
		d66 <= d65;
		d67 <= d66;
		d68 <= d67;
		d69 <= d68;
		d70 <= d69;
		d71 <= d70;
		d72 <= d71;
		d73 <= d72;
		d74 <= d73;
		d75 <= d74;
		d76 <= d75;
		d77 <= d76;
		d78 <= d77;
		d79 <= d78;
		d80 <= d79;
		d81 <= d80;
		d82 <= d81;
		d83 <= d82;
		d84 <= d83;
		d85 <= d84;
		d86 <= d85;
		d87 <= d86;
		d88 <= d87;
		d89 <= d88;
		d90 <= d89;
		d91 <= d90;
		d92 <= d91;
		d93 <= d92;
		d94 <= d93;
		d95 <= d94;
		d96 <= d95;
		d97 <= d96;
		d98 <= d97;
		d99 <= d98;
		d100 <= d99;
		d101 <= d100;
		d102 <= d101;
		d103 <= d102;
		d104 <= d103;
		d105 <= d104;
		d106 <= d105;
		d107 <= d106;
		d108 <= d107;
		d109 <= d108;
		d110 <= d109;
		d111 <= d110;
		d112 <= d111;
		d113 <= d112;
		d114 <= d113;
		d115 <= d114;
		d116 <= d115;
		d117 <= d116;
		d118 <= d117;
		d119 <= d118;
		d120 <= d119;
		d121 <= d120;
		d122 <= d121;
		d123 <= d122;
		d124 <= d123;
		d125 <= d124;
		d126 <= d125;
		d127 <= d126;
		d128 <= d127;
		d129 <= d128;
		d130 <= d129;
		d131 <= d130;
		d132 <= d131;
		d133 <= d132;
		d134 <= d133;
		d135 <= d134;
		d136 <= d135;
		d137 <= d136;
		d138 <= d137;
		d139 <= d138;
		d140 <= d139;
		d141 <= d140;
		d142 <= d141;
		d143 <= d142;
		d144 <= d143;
		d145 <= d144;
		d146 <= d145;
		d147 <= d146;
		d148 <= d147;
		d149 <= d148;
		d150 <= d149;
		d151 <= d150;
		d152 <= d151;

//		d0 <= d9;
//		d1 <= d0;
//		d2 <= d1;
//		d3 <= d2;
//		d4 <= d3;
//		d5 <= d4;
//		d6 <= d5;
//		d7 <= d6;
//		d8 <= d7;
//		d9 <= d8;

	end

endmodule


module skein512x (
	input clk,
	input [511:0] data,
	output [511:0] hash
);

	reg [511:0] m;
	reg [511:0] d;

	reg [511:0] h00_d, h00_q, h10_d, h10_q;
	reg [511:0] h00,h01,h02,h03,h04,h05,h06,h07,h08,h09,h0A,h0B,h0C,h0D,h0E,h0F,h0G,h0H;
	
	reg [511:0] p00_d, p00_q;
	reg [511:0] p00,p01,p02,p03,p04,p05,p06,p07,p08,p09,p0A,p0B,p0C,p0D,p0E,p0F,p0G,p0H;

	wire [511:0] o00,o01,o02,o03,o04,o05,o06,o07,o08,o09,o0A,o0B,o0C,o0D,o0E,o0F,o0G,o0H;
	wire [511:0] ho00,ho01,ho02,ho03,ho04,ho05,ho06,ho07,ho08,ho09,ho0A,ho0B,ho0C,ho0D,ho0E,ho0F,ho0G,ho0H;
	
	reg [511:0] hH;
	reg [511:0] oH;
	
	reg [511:0] h_d, h_q;
	
	reg [63:0] t0_d, t1_d, t2_d;
	reg [63:0] t0_q, t1_q, t2_q;
	
	reg phase_d = 1'b0, phase_q = 1'b0;
	
	wire [511:0] data_le;
	
	assign data_le = data;

//	genvar i;
//	generate
//		for( i=0; i < 64 ; i = i + 1) begin: BYTE_REVERSE
//			assign data_le[i*8 +: 8] = data[(63-i)*8 +: 8];
//		end
//	endgenerate

	
	assign hash = { h_q[455:448],
			h_q[463:456],
			h_q[471:464],
			h_q[479:472],
			h_q[487:480],
			h_q[495:488],
			h_q[503:496],
			h_q[511:504],
			h_q[391:384],
			h_q[399:392],
			h_q[407:400],
			h_q[415:408],
			h_q[423:416],
			h_q[431:424],
			h_q[439:432],
			h_q[447:440],
			h_q[327:320],
			h_q[335:328],
			h_q[343:336],
			h_q[351:344],
			h_q[359:352],
			h_q[367:360],
			h_q[375:368],
			h_q[383:376],
			h_q[263:256],
			h_q[271:264],
			h_q[279:272],
			h_q[287:280],
			h_q[295:288],
			h_q[303:296],
			h_q[311:304],
			h_q[319:312],
			h_q[199:192],
			h_q[207:200],
			h_q[215:208],
			h_q[223:216],
			h_q[231:224],
			h_q[239:232],
			h_q[247:240],
			h_q[255:248],
			h_q[135:128],
			h_q[143:136],
			h_q[151:144],
			h_q[159:152],
			h_q[167:160],
			h_q[175:168],
			h_q[183:176],
			h_q[191:184],
			h_q[71:64],
			h_q[79:72],
			h_q[87:80],
			h_q[95:88],
			h_q[103:96],
			h_q[111:104],
			h_q[119:112],
			h_q[127:120],
			h_q[7:0],
			h_q[15:8],
			h_q[23:16],
			h_q[31:24],
			h_q[39:32],
			h_q[47:40],
			h_q[55:48],
			h_q[63:56]
		};

	skein_round sr00 (clk,  0, p00_q, h00_q, t0_q, t1_q, o00, ho00);
	skein_round sr01 (clk,  1, p01, h01, t1_q, t2_q, o01, ho01);
	skein_round sr02 (clk,  2, p02, h02, t2_q, t0_q, o02, ho02);
	skein_round sr03 (clk,  3, p03, h03, t0_q, t1_q, o03, ho03);
	skein_round sr04 (clk,  4, p04, h04, t1_q, t2_q, o04, ho04);
	skein_round sr05 (clk,  5, p05, h05, t2_q, t0_q, o05, ho05);
	skein_round sr06 (clk,  6, p06, h06, t0_q, t1_q, o06, ho06);
	skein_round sr07 (clk,  7, p07, h07, t1_q, t2_q, o07, ho07);
	skein_round sr08 (clk,  8, p08, h08, t2_q, t0_q, o08, ho08);
	skein_round sr09 (clk,  9, p09, h09, t0_q, t1_q, o09, ho09);
	skein_round sr0A (clk, 10, p0A, h0A, t1_q, t2_q, o0A, ho0A);
	skein_round sr0B (clk, 11, p0B, h0B, t2_q, t0_q, o0B, ho0B);
	skein_round sr0C (clk, 12, p0C, h0C, t0_q, t1_q, o0C, ho0C);
	skein_round sr0D (clk, 13, p0D, h0D, t1_q, t2_q, o0D, ho0D);
	skein_round sr0E (clk, 14, p0E, h0E, t2_q, t0_q, o0E, ho0E);
	skein_round sr0F (clk, 15, p0F, h0F, t0_q, t1_q, o0F, ho0F);
	skein_round sr0G (clk, 16, p0G, h0G, t1_q, t2_q, o0G, ho0G);
	skein_round sr0H (clk, 17, p0H, h0H, t2_q, t0_q, o0H, ho0H);

	always @ (*) begin

		phase_d <= ~phase_q;

		if ( phase_q ) begin
			p00_d <= data_le;
			h00_d <= m;

			t0_d <= 64'h0000000000000040;
			t1_d <= 64'hf000000000000000;
			t2_d <= 64'hf000000000000040;
			
			h_d <= h_q;

		end
		else begin

			p00_d <= 512'd0;

//			h00_d[511:448] <= data[63:0] ^ ( oH[511:448] + hH[511:448] );
//			h00_d[447:384] <= { nonce2_le, d[95:64] } ^ ( oH[447:384] + hH[447:384] );
//			h00_d[383:320] <= oH[383:320] + hH[383:320];
//			h00_d[319:256] <= oH[319:256] + hH[319:256];
//			h00_d[255:192] <= oH[255:192] + hH[255:192];
////			h00_d[191:128] <= oH[191:128] + hH[191:128] + 64'h0000000000000050;
////			h00_d[127: 64] <= oH[127: 64] + hH[127: 64] + 64'hb000000000000000;
////			h00_d[ 63:  0] <= oH[ 63:  0] + hH[ 63:  0] + 64'd18;
//			h00_d[191:128] <= oH[191:128] + hH[191:128];
//			h00_d[127: 64] <= oH[127: 64] + hH[127: 64];
//			h00_d[ 63:  0] <= oH[ 63:  0] + hH[ 63:  0];

			h00_d[511:448] <= data_le[ 63:  0] ^ ( oH[511:448] + hH[511:448] );
			h00_d[447:384] <= data_le[127: 64] ^ ( oH[447:384] + hH[447:384] );
			h00_d[383:320] <= data_le[191:128] ^ ( oH[383:320] + hH[383:320] );
			h00_d[319:256] <= data_le[255:192] ^ ( oH[319:256] + hH[319:256] );
			h00_d[255:192] <= data_le[319:256] ^ ( oH[255:192] + hH[255:192] );
			h00_d[191:128] <= data_le[383:320] ^ ( oH[191:128] + hH[191:128] );
			h00_d[127: 64] <= data_le[447:384] ^ ( oH[127: 64] + hH[127: 64] );
			h00_d[ 63:  0] <= data_le[511:448] ^ ( oH[ 63:  0] + hH[ 63:  0] );

			t0_d <= 64'h0000000000000008;
			t1_d <= 64'hFF00000000000000;
			t2_d <= 64'hFF00000000000008;

			h_d[511:448] <= ( o0H[511:448] + ho0H[511:448] );
			h_d[447:384] <= ( o0H[447:384] + ho0H[447:384] );
			h_d[383:320] <= ( o0H[383:320] + ho0H[383:320] );
			h_d[319:256] <= ( o0H[319:256] + ho0H[319:256] );
			h_d[255:192] <= ( o0H[255:192] + ho0H[255:192] );
			h_d[191:128] <= ( o0H[191:128] + ho0H[191:128] + 64'h0000000000000008 );
			h_d[127: 64] <= ( o0H[127: 64] + ho0H[127: 64] + 64'hFF00000000000000 );
			h_d[ 63:  0] <= ( o0H[ 63:  0] + ho0H[ 63:  0] + 64'd18 );

		end
	
	end

	always @ (posedge clk) begin
		
		phase_q <= phase_d;
		
		m <= 512'h4903ADFF749C51CE0D95DE399746DF038FD1934127C79BCE9A255629FF352CB15DB62599DF6CA7B0EABE394CA9D5C3F4991112C71A75B523AE18A40B660FCC33;

		d <= data_le;
//		n <= nonce;
		
		t0_q <= t0_d;
		t1_q <= t1_d;
		t2_q <= t2_d;

		h_q <= h_d;

//		hH <= ho0H;
		hH[511:192] <= ho0H[511:192];
		hH[191:128] <= ho0H[191:128] + 64'h0000000000000040;
		hH[127: 64] <= ho0H[127: 64] + 64'hf000000000000000;
		hH[ 63:  0] <= ho0H[ 63:  0] + 64'd18;
		oH <= o0H;

		p0H <= o0G;
		h0H <= ho0G;
		p0G <= o0F;
		h0G <= ho0F;
		p0F <= o0E;
		h0F <= ho0E;
		p0E <= o0D;
		h0E <= ho0D;
		p0D <= o0C;
		h0D <= ho0C;
		p0C <= o0B;
		h0C <= ho0B;
		p0B <= o0A;
		h0B <= ho0A;
		p0A <= o09;
		h0A <= ho09;
		p09 <= o08;
		h09 <= ho08;
		p08 <= o07;
		h08 <= ho07;
		p07 <= o06;
		h07 <= ho06;
		p06 <= o05;
		h06 <= ho05;
		p05 <= o04;
		h05 <= ho04;
		p04 <= o03;
		h04 <= ho03;
		p03 <= o02;
		h03 <= ho02;
		p02 <= o01;
		h02 <= ho01;
		p01 <= o00;
		h01 <= ho00;
		p00_q <= p00_d;
		h00_q <= h00_d;

//		nonce2 <= n - 32'd72;
//		nonce2 <= n;

//		$display("Hash: %x", hash);
		
	end

endmodule

module skein_round (
	input clk,
	input [31:0] round,
	input [511:0] p,
	input [511:0] h,
	input [63:0] t0,
	input [63:0] t1,
	output reg [511:0] po,
	output reg [511:0] ho
);

	reg [511:0] px, hx;
	reg [63:0] t0x, t1x;
	reg [31:0] roundx;
	
	reg [63:0] p0, p1, p2, p3, p4, p5, p6, p7;
	reg [511:0] hx0, hx1, hx2, hx3, hx4;
	reg [511:0] pox;

	wire [511:0] po0, po1, po2, po3, po4;
	
	assign po0 = { p0, p1, p2, p3, p4, p5, p6, p7 };

	skein_round_1 r1 (clk, !roundx[0], po0, po1); 
	skein_round_2 r2 (clk, !roundx[0], po1, po2); 
	skein_round_3 r3 (clk, !roundx[0], po2, po3); 
	skein_round_4 r4 (clk, !roundx[0], po3, po4); 

	always @ (posedge clk) begin
	
		px <= p;
		hx <= h;
		t0x <= t0;
		t1x <= t1;
		roundx <= round;
	
		// Add Key
		p0 <= px[511:448] + hx[511:448];
		p1 <= px[447:384] + hx[447:384];
		p2 <= px[383:320] + hx[383:320];
		p3 <= px[319:256] + hx[319:256];
		p4 <= px[255:192] + hx[255:192];
		p5 <= px[191:128] + hx[191:128] + t0x;
		p6 <= px[127: 64] + hx[127: 64] + t1x;
		p7 <= px[ 63:  0] + hx[ 63:  0] + roundx;

//		p0 <= px[511:448] + hx[511:448] + roundx;
//		p1 <= px[447:384] + hx[447:384] + t1x;
//		p2 <= px[383:320] + hx[383:320] + t0x;
//		p3 <= px[319:256] + hx[319:256];
//		p4 <= px[255:192] + hx[255:192];
//		p5 <= px[191:128] + hx[191:128];
//		p6 <= px[127: 64] + hx[127: 64];
//		p7 <= px[ 63:  0] + hx[ 63:  0];
	
		po <= po4;
		
		ho  <= hx4;
		hx4 <= hx3;
		hx3 <= hx2;
		hx2 <= hx1;
		hx1 <= hx0;
		hx0[511:64] <= hx[447:0];
		hx0[ 63: 0] <= ((hx[511:448] ^ hx[447:384]) ^ (hx[383:320] ^ hx[319:256])) ^ ((hx[255:192] ^ hx[191:128]) ^ (hx[127:64] ^ hx[63:0])) ^ 64'h1BD11BDAA9FC1A22;
		
	end

endmodule

module skein_round_1 (
	input clk,
	input even,
	input [511:0] in,
	output reg [511:0] out
);
	
	wire [63:0] p0, p1, p2, p3, p4, p5, p6, p7;
	wire [63:0] p0x,p1x,p2x,p3x,p4x,p5x,p6x,p7x;
	
	assign p0 = in[511:448];
	assign p1 = in[447:384];
	assign p2 = in[383:320];
	assign p3 = in[319:256];
	assign p4 = in[255:192];
	assign p5 = in[191:128];
	assign p6 = in[127: 64];
	assign p7 = in[ 63:  0];
	
	assign p0x = p0 + p1;
	assign p1x = (even) ? { p1[17:0], p1[63:18] } : { p1[24:0], p1[63:25] };
	assign p2x = p2 + p3;
	assign p3x = (even) ? { p3[27:0], p3[63:28] } : { p3[33:0], p3[63:34] };
	assign p4x = p4 + p5;
	assign p5x = (even) ? { p5[44:0], p5[63:45] } : { p5[29:0], p5[63:30] };
	assign p6x = p6 + p7;
	assign p7x = (even) ? { p7[26:0], p7[63:27] } : { p7[39:0], p7[63:40] };

	always @ (posedge clk) begin
	
		out[511:448] <= p0x;
		out[447:384] <= p1x ^ p0x;
		out[383:320] <= p2x;
		out[319:256] <= p3x ^ p2x;
		out[255:192] <= p4x;
		out[191:128] <= p5x ^ p4x;
		out[127: 64] <= p6x;
		out[ 63:  0] <= p7x ^ p6x;
		
	end

endmodule

module skein_round_2 (
	input clk,
	input even,
	input [511:0] in,
	output reg [511:0] out
);
	
	wire [63:0] p0, p1, p2, p3, p4, p5, p6, p7;
	wire [63:0] p0x,p1x,p2x,p3x,p4x,p5x,p6x,p7x;
	
	assign p0 = in[511:448];
	assign p1 = in[447:384];
	assign p2 = in[383:320];
	assign p3 = in[319:256];
	assign p4 = in[255:192];
	assign p5 = in[191:128];
	assign p6 = in[127: 64];
	assign p7 = in[ 63:  0];
	
	assign p0x = p0 + p3;
	assign p1x = (even) ? { p1[30:0], p1[63:31] } : { p1[50:0], p1[63:51] };
	assign p2x = p2 + p1;
	assign p3x = (even) ? { p3[21:0], p3[63:22] } : { p3[46:0], p3[63:47] };
	assign p4x = p4 + p7;
	assign p5x = (even) ? { p5[49:0], p5[63:50] } : { p5[53:0], p5[63:54] };
	assign p6x = p6 + p5;
	assign p7x = (even) ? { p7[36:0], p7[63:37] } : { p7[13:0], p7[63:14] };

	always @ (posedge clk) begin
	
		out[511:448] <= p0x;
		out[447:384] <= p1x ^ p2x;
		out[383:320] <= p2x;
		out[319:256] <= p3x ^ p0x;
		out[255:192] <= p4x;
		out[191:128] <= p5x ^ p6x;
		out[127: 64] <= p6x;
		out[ 63:  0] <= p7x ^ p4x;
		
	end

endmodule

module skein_round_3 (
	input clk,
	input even,
	input [511:0] in,
	output reg [511:0] out
);
	
	wire [63:0] p0, p1, p2, p3, p4, p5, p6, p7;
	wire [63:0] p0x,p1x,p2x,p3x,p4x,p5x,p6x,p7x;
	
	assign p0 = in[511:448];
	assign p1 = in[447:384];
	assign p2 = in[383:320];
	assign p3 = in[319:256];
	assign p4 = in[255:192];
	assign p5 = in[191:128];
	assign p6 = in[127: 64];
	assign p7 = in[ 63:  0];
	
	assign p0x = p0 + p5;
	assign p1x = (even) ? { p1[46:0], p1[63:47] } : { p1[38:0], p1[63:39] };
	assign p2x = p2 + p7;
	assign p3x = (even) ? { p3[14:0], p3[63:15] } : { p3[34:0], p3[63:35] };
	assign p4x = p4 + p1;
	assign p5x = (even) ? { p5[27:0], p5[63:28] } : { p5[24:0], p5[63:25] };
	assign p6x = p6 + p3;
	assign p7x = (even) ? { p7[24:0], p7[63:25] } : { p7[20:0], p7[63:21] };

	always @ (posedge clk) begin
	
		out[511:448] <= p0x;
		out[447:384] <= p1x ^ p4x;
		out[383:320] <= p2x;
		out[319:256] <= p3x ^ p6x;
		out[255:192] <= p4x;
		out[191:128] <= p5x ^ p0x;
		out[127: 64] <= p6x;
		out[ 63:  0] <= p7x ^ p2x;
		
	end

endmodule

module skein_round_4 (
	input clk,
	input even,
	input [511:0] in,
	output reg [511:0] out
);
	
	wire [63:0] p0, p1, p2, p3, p4, p5, p6, p7;
	wire [63:0] p0x,p1x,p2x,p3x,p4x,p5x,p6x,p7x;
	
	assign p0 = in[511:448];
	assign p1 = in[447:384];
	assign p2 = in[383:320];
	assign p3 = in[319:256];
	assign p4 = in[255:192];
	assign p5 = in[191:128];
	assign p6 = in[127: 64];
	assign p7 = in[ 63:  0];
	
	assign p0x = p0 + p7;
	assign p1x = (even) ? { p1[19:0], p1[63:20] } : { p1[55:0], p1[63:56] };
	assign p2x = p2 + p5;
	assign p3x = (even) ? { p3[ 7:0], p3[63: 8] } : { p3[41:0], p3[63:42] };
	assign p4x = p4 + p3;
	assign p5x = (even) ? { p5[ 9:0], p5[63:10] } : { p5[ 7:0], p5[63: 8] };
	assign p6x = p6 + p1;
	assign p7x = (even) ? { p7[54:0], p7[63:55] } : { p7[28:0], p7[63:29] };

	always @ (posedge clk) begin
	
		out[511:448] <= p0x;
		out[447:384] <= p1x ^ p6x;
		out[383:320] <= p2x;
		out[319:256] <= p3x ^ p4x;
		out[255:192] <= p4x;
		out[191:128] <= p5x ^ p2x;
		out[127: 64] <= p6x;
		out[ 63:  0] <= p7x ^ p0x;
		
	end

endmodule
