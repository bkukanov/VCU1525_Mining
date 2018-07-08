/*
 * Copyright (c) 2017 Sprocket
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

module blake512 (
	input clk,
	input rst,
	input [607:0] data,
	input [31:0] nonce,
	output [511:0] hash
);

	localparam [63:0] C0 = 64'h243F6A8885A308D3;
	localparam [63:0] C1 = 64'h13198A2E03707344;
	localparam [63:0] C2 = 64'hA4093822299F31D0;
	localparam [63:0] C3 = 64'h082EFA98EC4E6C89;
	localparam [63:0] C4 = 64'h452821E638D01377;
	localparam [63:0] C5 = 64'hBE5466CF34E90C6C;
	localparam [63:0] C6 = 64'hC0AC29B7C97C50DD;
	localparam [63:0] C7 = 64'h3F84D5B5B5470917;
	localparam [63:0] C8 = 64'h9216D5D98979FB1B;
	localparam [63:0] C9 = 64'hD1310BA698DFB5AC;
	localparam [63:0] CA = 64'h2FFD72DBD01ADFB7;
	localparam [63:0] CB = 64'hB8E1AFED6A267E96;
	localparam [63:0] CC = 64'hBA7C9045F12C7F99;
	localparam [63:0] CD = 64'h24A19947B3916CF7;
	localparam [63:0] CE = 64'h0801F2E2858EFC16;
	localparam [63:0] CF = 64'h636920D871574E69;

	wire [1023:0] v1,v2,v3,v4,v5,v6,v7,v8,v9,v10,v11,v12,v13,v14,v15,v16;
	wire [1023:0] t0,t1,t2,t3,t4,t5,t6,t7,t8,t9,t10,t11,t12,t13,t14,t15;

	reg [1023:0] m0_d,m1_d,m2_d,m3_d,m4_d,m5_d,m6_d,m7_d,m8_d,m9_d,m10_d,m11_d,m12_d,m13_d,m14_d,m15_d;
	reg [1023:0] m0_q,m1_q,m2_q,m3_q,m4_q,m5_q,m6_q,m7_q,m8_q,m9_q,m10_q,m11_q,m12_q,m13_q,m14_q,m15_q;

	reg [1023:0] d, v0_d, v0_q;
	reg [511:0] hash_d, hash_q;
	reg [31:0] nonce_d, nonce_q;
	
	assign hash = hash_q;

	// Round 0
	blake_G g0_0 (clk, v0_q[1023:960], v0_q[767:704], v0_q[511:448], v0_q[255:192], m0_q[1023:960], m0_q[959:896], t0[1023:960], t0[767:704], t0[511:448], t0[255:192]);
	blake_G g0_1 (clk, v0_q[959:896], v0_q[703:640], v0_q[447:384], v0_q[191:128], m0_q[895:832], m0_q[831:768], t0[959:896], t0[703:640], t0[447:384], t0[191:128]);
	blake_G g0_2 (clk, v0_q[895:832], v0_q[639:576], v0_q[383:320], v0_q[127:64], m0_q[767:704], m0_q[703:640], t0[895:832], t0[639:576], t0[383:320], t0[127:64]);
	blake_G g0_3 (clk, v0_q[831:768], v0_q[575:512], v0_q[319:256], v0_q[63:0], m0_q[639:576], m0_q[575:512], t0[831:768], t0[575:512], t0[319:256], t0[63:0]);

	blake_G g0_4 (clk, t0[1023:960], t0[703:640], t0[383:320], t0[63:0], m0_q[511:448], m0_q[447:384], v1[1023:960], v1[703:640], v1[383:320], v1[63:0]);
	blake_G g0_5 (clk, t0[959:896], t0[639:576], t0[319:256], t0[255:192], m0_q[383:320], m0_q[319:256], v1[959:896], v1[639:576], v1[319:256], v1[255:192]);
	blake_G g0_6 (clk, t0[895:832], t0[575:512], t0[511:448], t0[191:128], m0_q[255:192], m0_q[191:128], v1[895:832], v1[575:512], v1[511:448], v1[191:128]);
	blake_G g0_7 (clk, t0[831:768], t0[767:704], t0[447:384], t0[127:64], m0_q[127:64], m0_q[63:0], v1[831:768], v1[767:704], v1[447:384], v1[127:64]);

	// Round 1
	blake_G g1_0 (clk, v1[1023:960], v1[767:704], v1[511:448], v1[255:192], m1_q[1023:960], m1_q[959:896], t1[1023:960], t1[767:704], t1[511:448], t1[255:192]);
	blake_G g1_1 (clk, v1[959:896], v1[703:640], v1[447:384], v1[191:128], m1_q[895:832], m1_q[831:768], t1[959:896], t1[703:640], t1[447:384], t1[191:128]);
	blake_G g1_2 (clk, v1[895:832], v1[639:576], v1[383:320], v1[127:64], m1_q[767:704], m1_q[703:640], t1[895:832], t1[639:576], t1[383:320], t1[127:64]);
	blake_G g1_3 (clk, v1[831:768], v1[575:512], v1[319:256], v1[63:0], m1_q[639:576], m1_q[575:512], t1[831:768], t1[575:512], t1[319:256], t1[63:0]);

	blake_G g1_4 (clk, t1[1023:960], t1[703:640], t1[383:320], t1[63:0], m1_q[511:448], m1_q[447:384], v2[1023:960], v2[703:640], v2[383:320], v2[63:0]);
	blake_G g1_5 (clk, t1[959:896], t1[639:576], t1[319:256], t1[255:192], m1_q[383:320], m1_q[319:256], v2[959:896], v2[639:576], v2[319:256], v2[255:192]);
	blake_G g1_6 (clk, t1[895:832], t1[575:512], t1[511:448], t1[191:128], m1_q[255:192], m1_q[191:128], v2[895:832], v2[575:512], v2[511:448], v2[191:128]);
	blake_G g1_7 (clk, t1[831:768], t1[767:704], t1[447:384], t1[127:64], m1_q[127:64], m1_q[63:0], v2[831:768], v2[767:704], v2[447:384], v2[127:64]);

	// Round 2
	blake_G g2_0 (clk, v2[1023:960], v2[767:704], v2[511:448], v2[255:192], m2_q[1023:960], m2_q[959:896], t2[1023:960], t2[767:704], t2[511:448], t2[255:192]);
	blake_G g2_1 (clk, v2[959:896], v2[703:640], v2[447:384], v2[191:128], m2_q[895:832], m2_q[831:768], t2[959:896], t2[703:640], t2[447:384], t2[191:128]);
	blake_G g2_2 (clk, v2[895:832], v2[639:576], v2[383:320], v2[127:64], m2_q[767:704], m2_q[703:640], t2[895:832], t2[639:576], t2[383:320], t2[127:64]);
	blake_G g2_3 (clk, v2[831:768], v2[575:512], v2[319:256], v2[63:0], m2_q[639:576], m2_q[575:512], t2[831:768], t2[575:512], t2[319:256], t2[63:0]);

	blake_G g2_4 (clk, t2[1023:960], t2[703:640], t2[383:320], t2[63:0], m2_q[511:448], m2_q[447:384], v3[1023:960], v3[703:640], v3[383:320], v3[63:0]);
	blake_G g2_5 (clk, t2[959:896], t2[639:576], t2[319:256], t2[255:192], m2_q[383:320], m2_q[319:256], v3[959:896], v3[639:576], v3[319:256], v3[255:192]);
	blake_G g2_6 (clk, t2[895:832], t2[575:512], t2[511:448], t2[191:128], m2_q[255:192], m2_q[191:128], v3[895:832], v3[575:512], v3[511:448], v3[191:128]);
	blake_G g2_7 (clk, t2[831:768], t2[767:704], t2[447:384], t2[127:64], m2_q[127:64], m2_q[63:0], v3[831:768], v3[767:704], v3[447:384], v3[127:64]);

	// Round 3
	blake_G g3_0 (clk, v3[1023:960], v3[767:704], v3[511:448], v3[255:192], m3_q[1023:960], m3_q[959:896], t3[1023:960], t3[767:704], t3[511:448], t3[255:192]);
	blake_G g3_1 (clk, v3[959:896], v3[703:640], v3[447:384], v3[191:128], m3_q[895:832], m3_q[831:768], t3[959:896], t3[703:640], t3[447:384], t3[191:128]);
	blake_G g3_2 (clk, v3[895:832], v3[639:576], v3[383:320], v3[127:64], m3_q[767:704], m3_q[703:640], t3[895:832], t3[639:576], t3[383:320], t3[127:64]);
	blake_G g3_3 (clk, v3[831:768], v3[575:512], v3[319:256], v3[63:0], m3_q[639:576], m3_q[575:512], t3[831:768], t3[575:512], t3[319:256], t3[63:0]);

	blake_G g3_4 (clk, t3[1023:960], t3[703:640], t3[383:320], t3[63:0], m3_q[511:448], m3_q[447:384], v4[1023:960], v4[703:640], v4[383:320], v4[63:0]);
	blake_G g3_5 (clk, t3[959:896], t3[639:576], t3[319:256], t3[255:192], m3_q[383:320], m3_q[319:256], v4[959:896], v4[639:576], v4[319:256], v4[255:192]);
	blake_G g3_6 (clk, t3[895:832], t3[575:512], t3[511:448], t3[191:128], m3_q[255:192], m3_q[191:128], v4[895:832], v4[575:512], v4[511:448], v4[191:128]);
	blake_G g3_7 (clk, t3[831:768], t3[767:704], t3[447:384], t3[127:64], m3_q[127:64], m3_q[63:0], v4[831:768], v4[767:704], v4[447:384], v4[127:64]);

	// Round 4
	blake_G g4_0 (clk, v4[1023:960], v4[767:704], v4[511:448], v4[255:192], m4_q[1023:960], m4_q[959:896], t4[1023:960], t4[767:704], t4[511:448], t4[255:192]);
	blake_G g4_1 (clk, v4[959:896], v4[703:640], v4[447:384], v4[191:128], m4_q[895:832], m4_q[831:768], t4[959:896], t4[703:640], t4[447:384], t4[191:128]);
	blake_G g4_2 (clk, v4[895:832], v4[639:576], v4[383:320], v4[127:64], m4_q[767:704], m4_q[703:640], t4[895:832], t4[639:576], t4[383:320], t4[127:64]);
	blake_G g4_3 (clk, v4[831:768], v4[575:512], v4[319:256], v4[63:0], m4_q[639:576], m4_q[575:512], t4[831:768], t4[575:512], t4[319:256], t4[63:0]);

	blake_G g4_4 (clk, t4[1023:960], t4[703:640], t4[383:320], t4[63:0], m4_q[511:448], m4_q[447:384], v5[1023:960], v5[703:640], v5[383:320], v5[63:0]);
	blake_G g4_5 (clk, t4[959:896], t4[639:576], t4[319:256], t4[255:192], m4_q[383:320], m4_q[319:256], v5[959:896], v5[639:576], v5[319:256], v5[255:192]);
	blake_G g4_6 (clk, t4[895:832], t4[575:512], t4[511:448], t4[191:128], m4_q[255:192], m4_q[191:128], v5[895:832], v5[575:512], v5[511:448], v5[191:128]);
	blake_G g4_7 (clk, t4[831:768], t4[767:704], t4[447:384], t4[127:64], m4_q[127:64], m4_q[63:0], v5[831:768], v5[767:704], v5[447:384], v5[127:64]);

	// Round 5
	blake_G g5_0 (clk, v5[1023:960], v5[767:704], v5[511:448], v5[255:192], m5_q[1023:960], m5_q[959:896], t5[1023:960], t5[767:704], t5[511:448], t5[255:192]);
	blake_G g5_1 (clk, v5[959:896], v5[703:640], v5[447:384], v5[191:128], m5_q[895:832], m5_q[831:768], t5[959:896], t5[703:640], t5[447:384], t5[191:128]);
	blake_G g5_2 (clk, v5[895:832], v5[639:576], v5[383:320], v5[127:64], m5_q[767:704], m5_q[703:640], t5[895:832], t5[639:576], t5[383:320], t5[127:64]);
	blake_G g5_3 (clk, v5[831:768], v5[575:512], v5[319:256], v5[63:0], m5_q[639:576], m5_q[575:512], t5[831:768], t5[575:512], t5[319:256], t5[63:0]);

	blake_G g5_4 (clk, t5[1023:960], t5[703:640], t5[383:320], t5[63:0], m5_q[511:448], m5_q[447:384], v6[1023:960], v6[703:640], v6[383:320], v6[63:0]);
	blake_G g5_5 (clk, t5[959:896], t5[639:576], t5[319:256], t5[255:192], m5_q[383:320], m5_q[319:256], v6[959:896], v6[639:576], v6[319:256], v6[255:192]);
	blake_G g5_6 (clk, t5[895:832], t5[575:512], t5[511:448], t5[191:128], m5_q[255:192], m5_q[191:128], v6[895:832], v6[575:512], v6[511:448], v6[191:128]);
	blake_G g5_7 (clk, t5[831:768], t5[767:704], t5[447:384], t5[127:64], m5_q[127:64], m5_q[63:0], v6[831:768], v6[767:704], v6[447:384], v6[127:64]);

	// Round 6
	blake_G g6_0 (clk, v6[1023:960], v6[767:704], v6[511:448], v6[255:192], m6_q[1023:960], m6_q[959:896], t6[1023:960], t6[767:704], t6[511:448], t6[255:192]);
	blake_G g6_1 (clk, v6[959:896], v6[703:640], v6[447:384], v6[191:128], m6_q[895:832], m6_q[831:768], t6[959:896], t6[703:640], t6[447:384], t6[191:128]);
	blake_G g6_2 (clk, v6[895:832], v6[639:576], v6[383:320], v6[127:64], m6_q[767:704], m6_q[703:640], t6[895:832], t6[639:576], t6[383:320], t6[127:64]);
	blake_G g6_3 (clk, v6[831:768], v6[575:512], v6[319:256], v6[63:0], m6_q[639:576], m6_q[575:512], t6[831:768], t6[575:512], t6[319:256], t6[63:0]);

	blake_G g6_4 (clk, t6[1023:960], t6[703:640], t6[383:320], t6[63:0], m6_q[511:448], m6_q[447:384], v7[1023:960], v7[703:640], v7[383:320], v7[63:0]);
	blake_G g6_5 (clk, t6[959:896], t6[639:576], t6[319:256], t6[255:192], m6_q[383:320], m6_q[319:256], v7[959:896], v7[639:576], v7[319:256], v7[255:192]);
	blake_G g6_6 (clk, t6[895:832], t6[575:512], t6[511:448], t6[191:128], m6_q[255:192], m6_q[191:128], v7[895:832], v7[575:512], v7[511:448], v7[191:128]);
	blake_G g6_7 (clk, t6[831:768], t6[767:704], t6[447:384], t6[127:64], m6_q[127:64], m6_q[63:0], v7[831:768], v7[767:704], v7[447:384], v7[127:64]);

	// Round 7
	blake_G g7_0 (clk, v7[1023:960], v7[767:704], v7[511:448], v7[255:192], m7_q[1023:960], m7_q[959:896], t7[1023:960], t7[767:704], t7[511:448], t7[255:192]);
	blake_G g7_1 (clk, v7[959:896], v7[703:640], v7[447:384], v7[191:128], m7_q[895:832], m7_q[831:768], t7[959:896], t7[703:640], t7[447:384], t7[191:128]);
	blake_G g7_2 (clk, v7[895:832], v7[639:576], v7[383:320], v7[127:64], m7_q[767:704], m7_q[703:640], t7[895:832], t7[639:576], t7[383:320], t7[127:64]);
	blake_G g7_3 (clk, v7[831:768], v7[575:512], v7[319:256], v7[63:0], m7_q[639:576], m7_q[575:512], t7[831:768], t7[575:512], t7[319:256], t7[63:0]);

	blake_G g7_4 (clk, t7[1023:960], t7[703:640], t7[383:320], t7[63:0], m7_q[511:448], m7_q[447:384], v8[1023:960], v8[703:640], v8[383:320], v8[63:0]);
	blake_G g7_5 (clk, t7[959:896], t7[639:576], t7[319:256], t7[255:192], m7_q[383:320], m7_q[319:256], v8[959:896], v8[639:576], v8[319:256], v8[255:192]);
	blake_G g7_6 (clk, t7[895:832], t7[575:512], t7[511:448], t7[191:128], m7_q[255:192], m7_q[191:128], v8[895:832], v8[575:512], v8[511:448], v8[191:128]);
	blake_G g7_7 (clk, t7[831:768], t7[767:704], t7[447:384], t7[127:64], m7_q[127:64], m7_q[63:0], v8[831:768], v8[767:704], v8[447:384], v8[127:64]);

	// Round 8
	blake_G g8_0 (clk, v8[1023:960], v8[767:704], v8[511:448], v8[255:192], m8_q[1023:960], m8_q[959:896], t8[1023:960], t8[767:704], t8[511:448], t8[255:192]);
	blake_G g8_1 (clk, v8[959:896], v8[703:640], v8[447:384], v8[191:128], m8_q[895:832], m8_q[831:768], t8[959:896], t8[703:640], t8[447:384], t8[191:128]);
	blake_G g8_2 (clk, v8[895:832], v8[639:576], v8[383:320], v8[127:64], m8_q[767:704], m8_q[703:640], t8[895:832], t8[639:576], t8[383:320], t8[127:64]);
	blake_G g8_3 (clk, v8[831:768], v8[575:512], v8[319:256], v8[63:0], m8_q[639:576], m8_q[575:512], t8[831:768], t8[575:512], t8[319:256], t8[63:0]);

	blake_G g8_4 (clk, t8[1023:960], t8[703:640], t8[383:320], t8[63:0], m8_q[511:448], m8_q[447:384], v9[1023:960], v9[703:640], v9[383:320], v9[63:0]);
	blake_G g8_5 (clk, t8[959:896], t8[639:576], t8[319:256], t8[255:192], m8_q[383:320], m8_q[319:256], v9[959:896], v9[639:576], v9[319:256], v9[255:192]);
	blake_G g8_6 (clk, t8[895:832], t8[575:512], t8[511:448], t8[191:128], m8_q[255:192], m8_q[191:128], v9[895:832], v9[575:512], v9[511:448], v9[191:128]);
	blake_G g8_7 (clk, t8[831:768], t8[767:704], t8[447:384], t8[127:64], m8_q[127:64], m8_q[63:0], v9[831:768], v9[767:704], v9[447:384], v9[127:64]);

	// Round 9
	blake_G g9_0 (clk, v9[1023:960], v9[767:704], v9[511:448], v9[255:192], m9_q[1023:960], m9_q[959:896], t9[1023:960], t9[767:704], t9[511:448], t9[255:192]);
	blake_G g9_1 (clk, v9[959:896], v9[703:640], v9[447:384], v9[191:128], m9_q[895:832], m9_q[831:768], t9[959:896], t9[703:640], t9[447:384], t9[191:128]);
	blake_G g9_2 (clk, v9[895:832], v9[639:576], v9[383:320], v9[127:64], m9_q[767:704], m9_q[703:640], t9[895:832], t9[639:576], t9[383:320], t9[127:64]);
	blake_G g9_3 (clk, v9[831:768], v9[575:512], v9[319:256], v9[63:0], m9_q[639:576], m9_q[575:512], t9[831:768], t9[575:512], t9[319:256], t9[63:0]);

	blake_G g9_4 (clk, t9[1023:960], t9[703:640], t9[383:320], t9[63:0], m9_q[511:448], m9_q[447:384], v10[1023:960], v10[703:640], v10[383:320], v10[63:0]);
	blake_G g9_5 (clk, t9[959:896], t9[639:576], t9[319:256], t9[255:192], m9_q[383:320], m9_q[319:256], v10[959:896], v10[639:576], v10[319:256], v10[255:192]);
	blake_G g9_6 (clk, t9[895:832], t9[575:512], t9[511:448], t9[191:128], m9_q[255:192], m9_q[191:128], v10[895:832], v10[575:512], v10[511:448], v10[191:128]);
	blake_G g9_7 (clk, t9[831:768], t9[767:704], t9[447:384], t9[127:64], m9_q[127:64], m9_q[63:0], v10[831:768], v10[767:704], v10[447:384], v10[127:64]);

	// Round 10
	blake_G g10_0 (clk, v10[1023:960], v10[767:704], v10[511:448], v10[255:192], m10_q[1023:960], m10_q[959:896], t10[1023:960], t10[767:704], t10[511:448], t10[255:192]);
	blake_G g10_1 (clk, v10[959:896], v10[703:640], v10[447:384], v10[191:128], m10_q[895:832], m10_q[831:768], t10[959:896], t10[703:640], t10[447:384], t10[191:128]);
	blake_G g10_2 (clk, v10[895:832], v10[639:576], v10[383:320], v10[127:64], m10_q[767:704], m10_q[703:640], t10[895:832], t10[639:576], t10[383:320], t10[127:64]);
	blake_G g10_3 (clk, v10[831:768], v10[575:512], v10[319:256], v10[63:0], m10_q[639:576], m10_q[575:512], t10[831:768], t10[575:512], t10[319:256], t10[63:0]);

	blake_G g10_4 (clk, t10[1023:960], t10[703:640], t10[383:320], t10[63:0], m10_q[511:448], m10_q[447:384], v11[1023:960], v11[703:640], v11[383:320], v11[63:0]);
	blake_G g10_5 (clk, t10[959:896], t10[639:576], t10[319:256], t10[255:192], m10_q[383:320], m10_q[319:256], v11[959:896], v11[639:576], v11[319:256], v11[255:192]);
	blake_G g10_6 (clk, t10[895:832], t10[575:512], t10[511:448], t10[191:128], m10_q[255:192], m10_q[191:128], v11[895:832], v11[575:512], v11[511:448], v11[191:128]);
	blake_G g10_7 (clk, t10[831:768], t10[767:704], t10[447:384], t10[127:64], m10_q[127:64], m10_q[63:0], v11[831:768], v11[767:704], v11[447:384], v11[127:64]);

	// Round 11
	blake_G g11_0 (clk, v11[1023:960], v11[767:704], v11[511:448], v11[255:192], m11_q[1023:960], m11_q[959:896], t11[1023:960], t11[767:704], t11[511:448], t11[255:192]);
	blake_G g11_1 (clk, v11[959:896], v11[703:640], v11[447:384], v11[191:128], m11_q[895:832], m11_q[831:768], t11[959:896], t11[703:640], t11[447:384], t11[191:128]);
	blake_G g11_2 (clk, v11[895:832], v11[639:576], v11[383:320], v11[127:64], m11_q[767:704], m11_q[703:640], t11[895:832], t11[639:576], t11[383:320], t11[127:64]);
	blake_G g11_3 (clk, v11[831:768], v11[575:512], v11[319:256], v11[63:0], m11_q[639:576], m11_q[575:512], t11[831:768], t11[575:512], t11[319:256], t11[63:0]);

	blake_G g11_4 (clk, t11[1023:960], t11[703:640], t11[383:320], t11[63:0], m11_q[511:448], m11_q[447:384], v12[1023:960], v12[703:640], v12[383:320], v12[63:0]);
	blake_G g11_5 (clk, t11[959:896], t11[639:576], t11[319:256], t11[255:192], m11_q[383:320], m11_q[319:256], v12[959:896], v12[639:576], v12[319:256], v12[255:192]);
	blake_G g11_6 (clk, t11[895:832], t11[575:512], t11[511:448], t11[191:128], m11_q[255:192], m11_q[191:128], v12[895:832], v12[575:512], v12[511:448], v12[191:128]);
	blake_G g11_7 (clk, t11[831:768], t11[767:704], t11[447:384], t11[127:64], m11_q[127:64], m11_q[63:0], v12[831:768], v12[767:704], v12[447:384], v12[127:64]);

	// Round 12
	blake_G g12_0 (clk, v12[1023:960], v12[767:704], v12[511:448], v12[255:192], m12_q[1023:960], m12_q[959:896], t12[1023:960], t12[767:704], t12[511:448], t12[255:192]);
	blake_G g12_1 (clk, v12[959:896], v12[703:640], v12[447:384], v12[191:128], m12_q[895:832], m12_q[831:768], t12[959:896], t12[703:640], t12[447:384], t12[191:128]);
	blake_G g12_2 (clk, v12[895:832], v12[639:576], v12[383:320], v12[127:64], m12_q[767:704], m12_q[703:640], t12[895:832], t12[639:576], t12[383:320], t12[127:64]);
	blake_G g12_3 (clk, v12[831:768], v12[575:512], v12[319:256], v12[63:0], m12_q[639:576], m12_q[575:512], t12[831:768], t12[575:512], t12[319:256], t12[63:0]);

	blake_G g12_4 (clk, t12[1023:960], t12[703:640], t12[383:320], t12[63:0], m12_q[511:448], m12_q[447:384], v13[1023:960], v13[703:640], v13[383:320], v13[63:0]);
	blake_G g12_5 (clk, t12[959:896], t12[639:576], t12[319:256], t12[255:192], m12_q[383:320], m12_q[319:256], v13[959:896], v13[639:576], v13[319:256], v13[255:192]);
	blake_G g12_6 (clk, t12[895:832], t12[575:512], t12[511:448], t12[191:128], m12_q[255:192], m12_q[191:128], v13[895:832], v13[575:512], v13[511:448], v13[191:128]);
	blake_G g12_7 (clk, t12[831:768], t12[767:704], t12[447:384], t12[127:64], m12_q[127:64], m12_q[63:0], v13[831:768], v13[767:704], v13[447:384], v13[127:64]);

	// Round 13
	blake_G g13_0 (clk, v13[1023:960], v13[767:704], v13[511:448], v13[255:192], m13_q[1023:960], m13_q[959:896], t13[1023:960], t13[767:704], t13[511:448], t13[255:192]);
	blake_G g13_1 (clk, v13[959:896], v13[703:640], v13[447:384], v13[191:128], m13_q[895:832], m13_q[831:768], t13[959:896], t13[703:640], t13[447:384], t13[191:128]);
	blake_G g13_2 (clk, v13[895:832], v13[639:576], v13[383:320], v13[127:64], m13_q[767:704], m13_q[703:640], t13[895:832], t13[639:576], t13[383:320], t13[127:64]);
	blake_G g13_3 (clk, v13[831:768], v13[575:512], v13[319:256], v13[63:0], m13_q[639:576], m13_q[575:512], t13[831:768], t13[575:512], t13[319:256], t13[63:0]);

	blake_G g13_4 (clk, t13[1023:960], t13[703:640], t13[383:320], t13[63:0], m13_q[511:448], m13_q[447:384], v14[1023:960], v14[703:640], v14[383:320], v14[63:0]);
	blake_G g13_5 (clk, t13[959:896], t13[639:576], t13[319:256], t13[255:192], m13_q[383:320], m13_q[319:256], v14[959:896], v14[639:576], v14[319:256], v14[255:192]);
	blake_G g13_6 (clk, t13[895:832], t13[575:512], t13[511:448], t13[191:128], m13_q[255:192], m13_q[191:128], v14[895:832], v14[575:512], v14[511:448], v14[191:128]);
	blake_G g13_7 (clk, t13[831:768], t13[767:704], t13[447:384], t13[127:64], m13_q[127:64], m13_q[63:0], v14[831:768], v14[767:704], v14[447:384], v14[127:64]);

	// Round 14
	blake_G g14_0 (clk, v14[1023:960], v14[767:704], v14[511:448], v14[255:192], m14_q[1023:960], m14_q[959:896], t14[1023:960], t14[767:704], t14[511:448], t14[255:192]);
	blake_G g14_1 (clk, v14[959:896], v14[703:640], v14[447:384], v14[191:128], m14_q[895:832], m14_q[831:768], t14[959:896], t14[703:640], t14[447:384], t14[191:128]);
	blake_G g14_2 (clk, v14[895:832], v14[639:576], v14[383:320], v14[127:64], m14_q[767:704], m14_q[703:640], t14[895:832], t14[639:576], t14[383:320], t14[127:64]);
	blake_G g14_3 (clk, v14[831:768], v14[575:512], v14[319:256], v14[63:0], m14_q[639:576], m14_q[575:512], t14[831:768], t14[575:512], t14[319:256], t14[63:0]);

	blake_G g14_4 (clk, t14[1023:960], t14[703:640], t14[383:320], t14[63:0], m14_q[511:448], m14_q[447:384], v15[1023:960], v15[703:640], v15[383:320], v15[63:0]);
	blake_G g14_5 (clk, t14[959:896], t14[639:576], t14[319:256], t14[255:192], m14_q[383:320], m14_q[319:256], v15[959:896], v15[639:576], v15[319:256], v15[255:192]);
	blake_G g14_6 (clk, t14[895:832], t14[575:512], t14[511:448], t14[191:128], m14_q[255:192], m14_q[191:128], v15[895:832], v15[575:512], v15[511:448], v15[191:128]);
	blake_G g14_7 (clk, t14[831:768], t14[767:704], t14[447:384], t14[127:64], m14_q[127:64], m14_q[63:0], v15[831:768], v15[767:704], v15[447:384], v15[127:64]);

	// Round 15
	blake_G g15_0 (clk, v15[1023:960], v15[767:704], v15[511:448], v15[255:192], m15_q[1023:960], m15_q[959:896], t15[1023:960], t15[767:704], t15[511:448], t15[255:192]);
	blake_G g15_1 (clk, v15[959:896], v15[703:640], v15[447:384], v15[191:128], m15_q[895:832], m15_q[831:768], t15[959:896], t15[703:640], t15[447:384], t15[191:128]);
	blake_G g15_2 (clk, v15[895:832], v15[639:576], v15[383:320], v15[127:64], m15_q[767:704], m15_q[703:640], t15[895:832], t15[639:576], t15[383:320], t15[127:64]);
	blake_G g15_3 (clk, v15[831:768], v15[575:512], v15[319:256], v15[63:0], m15_q[639:576], m15_q[575:512], t15[831:768], t15[575:512], t15[319:256], t15[63:0]);

	blake_G g15_4 (clk, t15[1023:960], t15[703:640], t15[383:320], t15[63:0], m15_q[511:448], m15_q[447:384], v16[1023:960], v16[703:640], v16[383:320], v16[63:0]);
	blake_G g15_5 (clk, t15[959:896], t15[639:576], t15[319:256], t15[255:192], m15_q[383:320], m15_q[319:256], v16[959:896], v16[639:576], v16[319:256], v16[255:192]);
	blake_G g15_6 (clk, t15[895:832], t15[575:512], t15[511:448], t15[191:128], m15_q[255:192], m15_q[191:128], v16[895:832], v16[575:512], v16[511:448], v16[191:128]);
	blake_G g15_7 (clk, t15[831:768], t15[767:704], t15[447:384], t15[127:64], m15_q[127:64], m15_q[63:0], v16[831:768], v16[767:704], v16[447:384], v16[127:64]);

	always @ (*) begin

		if (rst) begin

//			v0_d <= 1024'h08C9BCF367E6096A3BA7CA8485AE67BB2BF894FE72F36E3CF1361D5F3AF54FA5D182E6AD7F520E511F6C3E2B8C68059B6BBD41FBABD9831F79217E1319CDE05BD308A385886A3F24447370032E8A1913D0319F29223809A4896C4EEC98FA2E08F711D038E6212845EC0EE934CF6654BEDD507CC9B729ACC0170947B5B5D5843F;
			v0_d <= 1024'h6A09E667F3BCC908BB67AE8584CAA73B3C6EF372FE94F82BA54FF53A5F1D36F1510E527FADE682D19B05688C2B3E6C1F1F83D9ABFB41BD6B5BE0CD19137E2179243F6A8885A308D313198A2E03707344A4093822299F31D0082EFA98EC4E6C89452821E638D011F7BE5466CF34E90EECC0AC29B7C97C50DD3F84D5B5B5470917;

//			m0_d <= 1024'hFDDD0F6B00000007857E79622467F75B3918D739D2A7F3C70001E0ECED991A0CB0F9500E000000001C4E621811CFEDFABDA6DA974B31AC23ECBB26F7361C73FC5A4F6B39708C877A752DED031B09CD11000000000000008000000000000000000000000000000000010000000000000000000000000000008002000000000000;

			m0_d <= { d[1023:960]^ C1, d[959:896]^ C0, d[895:832]^ C3, d[831:768]^ C2, d[767:704]^ C5, d[703:640]^ C4, d[639:576]^ C7, d[575:512]^ C6, d[511:448]^ C9, d[447:384]^ C8, d[383:320]^ CB, d[319:256]^ CA, d[255:192]^ CD, d[191:128]^ CC, d[127:64]^ CF, d[63:0]^ CE };
			m1_d <= { d[127:64]^ CA, d[383:320]^ CE, d[767:704]^ C8, d[511:448]^ C4, d[447:384]^ CF, d[63:0]^ C9, d[191:128]^ C6, d[639:576]^ CD, d[959:896]^ CC, d[255:192]^ C1, d[1023:960]^ C2, d[895:832]^ C0, d[319:256]^ C7, d[575:512]^ CB, d[703:640]^ C3, d[831:768]^ C5 };
			m2_d <= { d[319:256]^ C8, d[511:448]^ CB, d[255:192]^ C0, d[1023:960]^ CC, d[703:640]^ C2, d[895:832]^ C5, d[63:0]^ CD, d[191:128]^ CF, d[383:320]^ CE, d[127:64]^ CA, d[831:768]^ C6, d[639:576]^ C3, d[575:512]^ C1, d[959:896]^ C7, d[447:384]^ C4, d[767:704]^ C9 };
			m3_d <= { d[575:512]^ C9, d[447:384]^ C7, d[831:768]^ C1, d[959:896]^ C3, d[191:128]^ CC, d[255:192]^ CD, d[319:256]^ CE, d[127:64]^ CB, d[895:832]^ C6, d[639:576]^ C2, d[703:640]^ CA, d[383:320]^ C5, d[767:704]^ C0, d[1023:960]^ C4, d[63:0]^ C8, d[511:448]^ CF };
			m4_d <= { d[447:384]^ C0, d[1023:960]^ C9, d[703:640]^ C7, d[575:512]^ C5, d[895:832]^ C4, d[767:704]^ C2, d[383:320]^ CF, d[63:0]^ CA, d[127:64]^ C1, d[959:896]^ CE, d[319:256]^ CC, d[255:192]^ CB, d[639:576]^ C8, d[511:448]^ C6, d[831:768]^ CD, d[191:128]^ C3 };
			m5_d <= { d[895:832]^ CC, d[255:192]^ C2, d[639:576]^ CA, d[383:320]^ C6, d[1023:960]^ CB, d[319:256]^ C0, d[511:448]^ C3, d[831:768]^ C8, d[767:704]^ CD, d[191:128]^ C4, d[575:512]^ C5, d[703:640]^ C7, d[63:0]^ CE, d[127:64]^ CF, d[959:896]^ C9, d[447:384]^ C1 };
			m6_d <= { d[255:192]^ C5, d[703:640]^ CC, d[959:896]^ CF, d[63:0]^ C1, d[127:64]^ CD, d[191:128]^ CE, d[767:704]^ CA, d[383:320]^ C4, d[1023:960]^ C7, d[575:512]^ C0, d[639:576]^ C3, d[831:768]^ C6, d[447:384]^ C2, d[895:832]^ C9, d[511:448]^ CB, d[319:256]^ C8 };
			m7_d <= { d[191:128]^ CB, d[319:256]^ CD, d[575:512]^ CE, d[127:64]^ C7, d[255:192]^ C1, d[959:896]^ CC, d[831:768]^ C9, d[447:384]^ C3, d[703:640]^ C0, d[1023:960]^ C5, d[63:0]^ C4, d[767:704]^ CF, d[511:448]^ C6, d[639:576]^ C8, d[895:832]^ CA, d[383:320]^ C2 };
			m8_d <= { d[639:576]^ CF, d[63:0]^ C6, d[127:64]^ C9, d[447:384]^ CE, d[319:256]^ C3, d[831:768]^ CB, d[1023:960]^ C8, d[511:448]^ C0, d[255:192]^ C2, d[895:832]^ CC, d[191:128]^ C7, d[575:512]^ CD, d[959:896]^ C4, d[767:704]^ C1, d[383:320]^ C5, d[703:640]^ CA };
			m9_d <= { d[383:320]^ C2, d[895:832]^ CA, d[511:448]^ C4, d[767:704]^ C8, d[575:512]^ C6, d[639:576]^ C7, d[959:896]^ C5, d[703:640]^ C1, d[63:0]^ CB, d[319:256]^ CF, d[447:384]^ CE, d[127:64]^ C9, d[831:768]^ CC, d[255:192]^ C3, d[191:128]^ C0, d[1023:960]^ CD };
			m10_d <= { d[1023:960]^ C1, d[959:896]^ C0, d[895:832]^ C3, d[831:768]^ C2, d[767:704]^ C5, d[703:640]^ C4, d[639:576]^ C7, d[575:512]^ C6, d[511:448]^ C9, d[447:384]^ C8, d[383:320]^ CB, d[319:256]^ CA, d[255:192]^ CD, d[191:128]^ CC, d[127:64]^ CF, d[63:0]^ CE };
			m11_d <= { d[127:64]^ CA, d[383:320]^ CE, d[767:704]^ C8, d[511:448]^ C4, d[447:384]^ CF, d[63:0]^ C9, d[191:128]^ C6, d[639:576]^ CD, d[959:896]^ CC, d[255:192]^ C1, d[1023:960]^ C2, d[895:832]^ C0, d[319:256]^ C7, d[575:512]^ CB, d[703:640]^ C3, d[831:768]^ C5 };
			m12_d <= { d[319:256]^ C8, d[511:448]^ CB, d[255:192]^ C0, d[1023:960]^ CC, d[703:640]^ C2, d[895:832]^ C5, d[63:0]^ CD, d[191:128]^ CF, d[383:320]^ CE, d[127:64]^ CA, d[831:768]^ C6, d[639:576]^ C3, d[575:512]^ C1, d[959:896]^ C7, d[447:384]^ C4, d[767:704]^ C9 };
			m13_d <= { d[575:512]^ C9, d[447:384]^ C7, d[831:768]^ C1, d[959:896]^ C3, d[191:128]^ CC, d[255:192]^ CD, d[319:256]^ CE, d[127:64]^ CB, d[895:832]^ C6, d[639:576]^ C2, d[703:640]^ CA, d[383:320]^ C5, d[767:704]^ C0, d[1023:960]^ C4, d[63:0]^ C8, d[511:448]^ CF };
			m14_d <= { d[447:384]^ C0, d[1023:960]^ C9, d[703:640]^ C7, d[575:512]^ C5, d[895:832]^ C4, d[767:704]^ C2, d[383:320]^ CF, d[63:0]^ CA, d[127:64]^ C1, d[959:896]^ CE, d[319:256]^ CC, d[255:192]^ CB, d[639:576]^ C8, d[511:448]^ C6, d[831:768]^ CD, d[191:128]^ C3 };
			m15_d <= { d[895:832]^ CC, d[255:192]^ C2, d[639:576]^ CA, d[383:320]^ C6, d[1023:960]^ CB, d[319:256]^ C0, d[511:448]^ C3, d[831:768]^ C8, d[767:704]^ CD, d[191:128]^ C4, d[575:512]^ C5, d[703:640]^ C7, d[63:0]^ CE, d[127:64]^ CF, d[959:896]^ C9, d[447:384]^ C1 };

		end

		else begin

			v0_d <= v0_q;

			m0_d <= { m0_q[1023:416],  nonce_q           ^ 32'h8979FB1B, m0_q[383:0] };
			m1_d <= { m1_q[1023:736], (nonce_q - 32'd1) ^ 32'h71574E69, m1_q[703:0] };
			m2_d <= { m2_q[1023: 96], (nonce_q - 32'd7) ^ 32'h38D01377, m2_q[ 63:0] };
			m3_d <= { m3_q[1023:928], (nonce_q - 32'd10) ^ 32'hB5470917, m3_q[895:0] };
			m4_d <= { m4_q[1023:992], (nonce_q - 32'd13) ^ 32'h85A308D3, m4_q[959:0] };
			m5_d <= { m5_q[1023: 32], (nonce_q - 32'd20) ^ 32'h03707344 };
			m6_d <= { m6_q[1023:224], (nonce_q - 32'd23) ^ 32'h299F31D0, m6_q[191:0] };
			m7_d <= { m7_q[1023:544], (nonce_q - 32'd26) ^ 32'hEC4E6C89, m7_q[511:0] };
			m8_d <= { m8_q[1023:800], (nonce_q - 32'd30) ^ 32'h858EFC16, m8_q[767:0] };
			m9_d <= { m9_q[1023:352], (nonce_q - 32'd35) ^ 32'h858EFC16, m9_q[319:0] };
			m10_d <= { m10_q[1023:416], (nonce_q - 32'd40) ^ 32'h8979FB1B, m10_q[383:0] };
			m11_d <= { m11_q[1023:736], (nonce_q - 32'd41) ^ 32'h71574E69, m11_q[703:0] };
			m12_d <= { m12_q[1023: 96], (nonce_q - 32'd47) ^ 32'h38D01377, m12_q[ 63:0] };
			m13_d <= { m13_q[1023:928], (nonce_q - 32'd50) ^ 32'hB5470917, m13_q[895:0] };
			m14_d <= { m14_q[1023:992], (nonce_q - 32'd53) ^ 32'h85A308D3, m14_q[959:0] };
			m15_d <= { m15_q[1023: 32], (nonce_q - 32'd60) ^ 32'h03707344 };

//			m0_d <= { m0_q[1023:416], 32'h03ED2D75 ^ 32'h8979FB1B, m0_q[383:0] };
//			m1_d <= { m1_q[1023:736], 32'h03ED2D75 ^ 32'h71574E69, m1_q[703:0] };
//			m2_d <= { m2_q[1023: 96], 32'h03ED2D75 ^ 32'h38D01377, m2_q[ 63:0] };
//			m3_d <= { m3_q[1023:928], 32'h03ED2D75 ^ 32'hB5470917, m3_q[895:0] };
//			m4_d <= { m4_q[1023:992], 32'h03ED2D75 ^ 32'h85A308D3, m4_q[959:0] };
//			m5_d <= { m5_q[1023: 32], 32'h03ED2D75 ^ 32'h03707344 };
//			m6_d <= { m6_q[1023:224], 32'h03ED2D75 ^ 32'h299F31D0, m6_q[191:0] };
//			m7_d <= { m7_q[1023:544], 32'h03ED2D75 ^ 32'hEC4E6C89, m7_q[511:0] };
//			m8_d <= { m8_q[1023:800], 32'h03ED2D75 ^ 32'h858EFC16, m8_q[767:0] };
//			m9_d <= { m9_q[1023:352], 32'h03ED2D75 ^ 32'h858EFC16, m9_q[319:0] };
//			m10_d <= { m10_q[1023:416], 32'h03ED2D75 ^ 32'h8979FB1B, m10_q[383:0] };
//			m11_d <= { m11_q[1023:736], 32'h03ED2D75 ^ 32'h71574E69, m11_q[703:0] };
//			m12_d <= { m12_q[1023: 96], 32'h03ED2D75 ^ 32'h38D01377, m12_q[ 63:0] };
//			m13_d <= { m13_q[1023:928], 32'h03ED2D75 ^ 32'hB5470917, m13_q[895:0] };
//			m14_d <= { m14_q[1023:992], 32'h03ED2D75 ^ 32'h85A308D3, m14_q[959:0] };
//			m15_d <= { m15_q[1023: 32], 32'h03ED2D75 ^ 32'h03707344 };

		end
		
		hash_d[511:448] <= 64'h6A09E667F3BCC908 ^ v16[1023:960] ^ v16[511:448];
		hash_d[447:384] <= 64'hBB67AE8584CAA73B ^ v16[959:896] ^ v16[447:384];
		hash_d[383:320] <= 64'h3C6EF372FE94F82B ^ v16[895:832] ^ v16[383:320];
		hash_d[319:256] <= 64'hA54FF53A5F1D36F1 ^ v16[831:768] ^ v16[319:256];
		hash_d[255:192] <= 64'h510E527FADE682D1 ^ v16[767:704] ^ v16[255:192];
		hash_d[191:128] <= 64'h9B05688C2B3E6C1F ^ v16[703:640] ^ v16[191:128];
		hash_d[127: 64] <= 64'h1F83D9ABFB41BD6B ^ v16[639:576] ^ v16[127: 64];
		hash_d[ 63:  0] <= 64'h5BE0CD19137E2179 ^ v16[575:512] ^ v16[ 63:  0];
		
		nonce_d <= nonce;
		
	end

	always @ (posedge clk) begin

//		d <= { data, nonce, 384'h000000000000008000000000000000000000000000000000010000000000000000000000000000008002000000000000 };
		d <= { data, nonce, 384'h800000000000000000000000000000000000000000000000000000000000000100000000000000000000000000000280 };

		nonce_q <= nonce_d;
		hash_q <= hash_d;

		v0_q <= v0_d;
		
		m0_q <= m0_d;
		m1_q <= m1_d;
		m2_q <= m2_d;
		m3_q <= m3_d;
		m4_q <= m4_d;
		m5_q <= m5_d;
		m6_q <= m6_d;
		m7_q <= m7_d;
		m8_q <= m8_d;
		m9_q <= m9_d;
		m10_q <= m10_d;
		m11_q <= m11_d;
		m12_q <= m12_d;
		m13_q <= m13_d;
		m14_q <= m14_d;
		m15_q <= m15_d;


//		$display("v1: %x", v1);
//		$display("v2: %x", v2);
//		$display("v3: %x", v3);
//		$display("v4: %x", v4);
//		$display("v5: %x", v5);
//		$display("v6: %x", v6);
//		$display("v7: %x", v7);
//		$display("v8: %x", v8);
//		$display("v9: %x", v9);
//		$display("v10: %x", v10);
//		$display("v11: %x", v11);
//		$display("v12: %x", v12);
//		$display("v13: %x", v13);
//		$display("v14: %x", v14);

		
	end

endmodule


module blake_G (
	input clk,
	input [63:0] a,
	input [63:0] b,
	input [63:0] c,
	input [63:0] d,
	input [63:0] m0,
	input [63:0] m1,
	output [63:0] a_out,
	output [63:0] b_out,
	output [63:0] c_out,
	output [63:0] d_out
);

	reg [63:0] a0_d, a0_q, a1_d, a1_q;
	reg [63:0] b0_d, b0_q, b1_d, b1_q;
	reg [63:0] c0_d, c0_q, c1_d, c1_q;
	reg [63:0] d0_d, d0_q, d1_d, d1_q;
	reg [63:0] t1, t2, t3, t4;
	
	assign a_out = a1_q;
	assign b_out = b1_q;
	assign c_out = c1_q;
	assign d_out = d1_q;
	
	reg [31:0] mx;

	always @ (*) begin

//		a0_d = (a ^ b ^ m0) + ({(a[62:0] & b[62:0]) | (a[62:0] & m0[62:0]) | (b[62:0] & m0[62:0]), 1'b0});
		a0_d = a + b + m0;
		t1 = d ^ a0_d;
		d0_d = { t1[31:0] , t1[63:32] };
		c0_d = c + d0_d;
		t2 = b ^ c0_d;
		b0_d = { t2[24:0] , t2[63:25] };

//		a1_d <= (a0_q ^ b0_q ^ m1) + ({(a0_q[62:0] & b0_q[62:0]) | (a0_q[62:0] & m1[62:0]) | (b0_q[62:0] & m1[62:0]), 1'b0});
		a1_d = a0_q + b0_q + m1;
		t3 = d0_q ^ a1_d;
		d1_d = { t3[15:0] , t3[63:16] };
		c1_d = c0_q + d1_d;
		t4 = b0_q ^ c1_d;
		b1_d = { t4[10:0] , t4[63:11] };

	end

	always @ (posedge clk) begin

		a0_q <= a0_d;
		b0_q <= b0_d;
		c0_q <= c0_d;
		d0_q <= d0_d;

		a1_q <= a1_d;
		b1_q <= b1_d;
		c1_q <= c1_d;
		d1_q <= d1_d;
		
		mx <= m1;

	end

endmodule
