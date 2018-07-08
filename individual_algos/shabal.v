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

module shabal512 (
	input clk,
	input [511:0] data,
	output [511:0] hash
);

	reg phase = 1'b0;

	reg [511:0] h, data_le;

	assign hash = {
		h[487:480],
		h[495:488],
		h[503:496],
		h[511:504],
		h[455:448],
		h[463:456],
		h[471:464],
		h[479:472],
		h[423:416],
		h[431:424],
		h[439:432],
		h[447:440],
		h[391:384],
		h[399:392],
		h[407:400],
		h[415:408],
		h[359:352],
		h[367:360],
		h[375:368],
		h[383:376],
		h[327:320],
		h[335:328],
		h[343:336],
		h[351:344],
		h[295:288],
		h[303:296],
		h[311:304],
		h[319:312],
		h[263:256],
		h[271:264],
		h[279:272],
		h[287:280],
		h[231:224],
		h[239:232],
		h[247:240],
		h[255:248],
		h[199:192],
		h[207:200],
		h[215:208],
		h[223:216],
		h[167:160],
		h[175:168],
		h[183:176],
		h[191:184],
		h[135:128],
		h[143:136],
		h[151:144],
		h[159:152],
		h[103: 96],
		h[111:104],
		h[119:112],
		h[127:120],
		h[ 71: 64],
		h[ 79: 72],
		h[ 87: 80],
		h[ 95: 88],
		h[ 39: 32],
		h[ 47: 40],
		h[ 55: 48],
		h[ 63: 56],
		h[  7:  0],
		h[ 15:  8],
		h[ 23: 16],
		h[ 31: 24]
	};


	always @ ( posedge clk ) begin
	
		data_le <= {
			data[487:480],
			data[495:488],
			data[503:496],
			data[511:504],
			data[455:448],
			data[463:456],
			data[471:464],
			data[479:472],
			data[423:416],
			data[431:424],
			data[439:432],
			data[447:440],
			data[391:384],
			data[399:392],
			data[407:400],
			data[415:408],
			data[359:352],
			data[367:360],
			data[375:368],
			data[383:376],
			data[327:320],
			data[335:328],
			data[343:336],
			data[351:344],
			data[295:288],
			data[303:296],
			data[311:304],
			data[319:312],
			data[263:256],
			data[271:264],
			data[279:272],
			data[287:280],
			data[231:224],
			data[239:232],
			data[247:240],
			data[255:248],
			data[199:192],
			data[207:200],
			data[215:208],
			data[223:216],
			data[167:160],
			data[175:168],
			data[183:176],
			data[191:184],
			data[135:128],
			data[143:136],
			data[151:144],
			data[159:152],
			data[103: 96],
			data[111:104],
			data[119:112],
			data[127:120],
			data[ 71: 64],
			data[ 79: 72],
			data[ 87: 80],
			data[ 95: 88],
			data[ 39: 32],
			data[ 47: 40],
			data[ 55: 48],
			data[ 63: 56],
			data[  7:  0],
			data[ 15:  8],
			data[ 23: 16],
			data[ 31: 24]
		};

//$finish;

	end
	
	wire [383:0] A00, A00_out, A01_out, A02_out;
	wire [511:0] B00_out, B01_out, B02_out;
	wire [511:0] C00_out, C01_out, C02_out;
	wire [511:0] M00_out, M01_out, M02_out;
	wire [511:0] C00;
	
	assign A00 = 384'h20728DFC46C0BD53E782B6995530463271B4EF900EA9E82CDBB930F1FAD06B8BBE0CAE408BD1441076D2ADAC28ACAB7F;
	assign C00 = 512'hD9BF68D158BAD75056028CB28134F359B5D469D8941A8CC2418B2A6E040527807F07D7875194358F3C60D665BE97D79A950C3434AED9A06D2537DC8D7CDB5969;
//	assign M00 = data_le;
	
	reg [383:0] A01, A02, A03, A04, A05;
	reg [511:0] B0X, B00, B01, B02, B03, B04, B05;
	reg [511:0] C01, C02, C03, C04, C05, C05x;
	reg [511:0] M0X, M00, M01, M02, M03, M04, M05;

	// Initial Round
	shabal_round sr00 (clk, A00, B00, C00, M00, A00_out, B00_out, C00_out, M00_out);
	shabal_round sr01 (clk, A01, B01, C01, M01, A01_out, B01_out, C01_out, M01_out);
	shabal_round sr02 (clk, A02, B02, C02, M02, A02_out, B02_out, C02_out, M02_out);

	always @ ( posedge clk ) begin
	
		A01 <= { A00_out[255:0], A00_out[383:256] };
		B01 <= B00_out;
		C01 <= C00_out;
		M01 <= M00_out;

		A02 <= { A01_out[255:0], A01_out[383:256] };
		B02 <= B01_out;
		C02 <= C01_out;
		M02 <= M01_out;

		A03[ 31:  0] <= A02_out[287:256] + C02_out[319:288];
		A03[ 63: 32] <= A02_out[319:288] + C02_out[351:320];
		A03[ 95: 64] <= A02_out[351:320] + C02_out[383:352];
		A03[127: 96] <= A02_out[383:352] + C02_out[415:384];
		A03[159:128] <= A02_out[ 31:  0] + C02_out[447:416];
		A03[191:160] <= A02_out[ 63: 32] + C02_out[479:448];
		A03[223:192] <= A02_out[ 95: 64] + C02_out[511:480];
		A03[255:224] <= A02_out[127: 96] + C02_out[ 31:  0];
		A03[287:256] <= A02_out[159:128] + C02_out[ 63: 32];
		A03[319:288] <= A02_out[191:160] + C02_out[ 95: 64];
		A03[351:320] <= A02_out[223:192] + C02_out[127: 96];
		A03[383:352] <= A02_out[255:224] + C02_out[159:128];
		A04[ 31:  0] <= A03[ 31:  0] + C03[191:160];
		A04[ 63: 32] <= A03[ 63: 32] + C03[223:192];
		A04[ 95: 64] <= A03[ 95: 64] + C03[255:224];
		A04[127: 96] <= A03[127: 96] + C03[287:256];
		A04[159:128] <= A03[159:128] + C03[319:288];
		A04[191:160] <= A03[191:160] + C03[351:320];
		A04[223:192] <= A03[223:192] + C03[383:352];
		A04[255:224] <= A03[255:224] + C03[415:384];
		A04[287:256] <= A03[287:256] + C03[447:416];
		A04[319:288] <= A03[319:288] + C03[479:448];
		A04[351:320] <= A03[351:320] + C03[511:480];
		A04[383:352] <= A03[383:352] + C03[ 31:  0];
		A05[ 31:  0] <= A04[ 31:  0] + C04[ 63: 32];
		A05[ 63: 32] <= A04[ 63: 32] + C04[ 95: 64];
		A05[ 95: 64] <= A04[ 95: 64] + C04[127: 96];
		A05[127: 96] <= A04[127: 96] + C04[159:128];
		A05[159:128] <= A04[159:128] + C04[191:160];
		A05[191:160] <= A04[191:160] + C04[223:192];
		A05[223:192] <= A04[223:192] + C04[255:224];
		A05[255:224] <= A04[255:224] + C04[287:256];
		A05[287:256] <= A04[287:256] + C04[319:288];
		A05[319:288] <= A04[319:288] + C04[351:320];
		A05[351:320] <= A04[351:320] + C04[383:352];
		A05[383:352] <= (A04[383:352] + C04[415:384]) ^ 32'h00000002;
	
		C03 <= C02_out;
		C04 <= C03;
		B03 <= B02_out;
		B04 <= B03;
		
		M03 <= M02_out;
		M04 <= M03;
		M05 <= M04;

		B04[ 31:  0] <= C03[ 31:  0] - M03[ 31:  0];
		B04[ 63: 32] <= C03[ 63: 32] - M03[ 63: 32];
		B04[ 95: 64] <= C03[ 95: 64] - M03[ 95: 64];
		B04[127: 96] <= C03[127: 96] - M03[127: 96];
		B04[159:128] <= C03[159:128] - M03[159:128];
		B04[191:160] <= C03[191:160] - M03[191:160];
		B04[223:192] <= C03[223:192] - M03[223:192];
		B04[255:224] <= C03[255:224] - M03[255:224];
		B04[287:256] <= C03[287:256] - M03[287:256];
		B04[319:288] <= C03[319:288] - M03[319:288];
		B04[351:320] <= C03[351:320] - M03[351:320];
		B04[383:352] <= C03[383:352] - M03[383:352];
		B04[415:384] <= C03[415:384] - M03[415:384];
		B04[447:416] <= C03[447:416] - M03[447:416];
		B04[479:448] <= C03[479:448] - M03[479:448];
		B04[511:480] <= C03[511:480] - M03[511:480];

//		B05[ 31:  0] <= C04[ 31:  0] - M04[ 31:  0];
//		B05[ 63: 32] <= C04[ 63: 32] - M04[ 63: 32];
//		B05[ 95: 64] <= C04[ 95: 64] - M04[ 95: 64];
//		B05[127: 96] <= C04[127: 96] - M04[127: 96];
//		B05[159:128] <= C04[159:128] - M04[159:128];
//		B05[191:160] <= C04[191:160] - M04[191:160];
//		B05[223:192] <= C04[223:192] - M04[223:192];
//		B05[255:224] <= C04[255:224] - M04[255:224];
//		B05[287:256] <= C04[287:256] - M04[287:256];
//		B05[319:288] <= C04[319:288] - M04[319:288];
//		B05[351:320] <= C04[351:320] - M04[351:320];
//		B05[383:352] <= C04[383:352] - M04[383:352];
//		B05[415:384] <= C04[415:384] - M04[415:384];
//		B05[447:416] <= C04[447:416] - M04[447:416];
//		B05[479:448] <= C04[479:448] - M04[479:448];
//		B05[511:480] <= C04[511:480] - M04[511:480];

		B05 <= B04;
	
//		C05 <= B04;
		C05x <= B03;
		C05 <= C05x;

		M0X <= data_le;

		B0X[511:480] <= data_le[511:480] + 32'hC1099CB7;
		B0X[479:448] <= data_le[479:448] + 32'h07B385F3;
		B0X[447:416] <= data_le[447:416] + 32'hE7442C26;
		B0X[415:384] <= data_le[415:384] + 32'hCC8AD640;
		B0X[383:352] <= data_le[383:352] + 32'hEB6F56C7;
		B0X[351:320] <= data_le[351:320] + 32'h1EA81AA9;
		B0X[319:288] <= data_le[319:288] + 32'h73B9D314;
		B0X[287:256] <= data_le[287:256] + 32'h1DE85D08;
		B0X[255:224] <= data_le[255:224] + 32'h48910A5A;
		B0X[223:192] <= data_le[223:192] + 32'h893B22DB;
		B0X[191:160] <= data_le[191:160] + 32'hC5A0DF44;
		B0X[159:128] <= data_le[159:128] + 32'hBBC4324E;
		B0X[127: 96] <= data_le[127: 96] + 32'h72D2F240;
		B0X[ 95: 64] <= data_le[ 95: 64] + 32'h75941D99;
		B0X[ 63: 32] <= data_le[ 63: 32] + 32'h6D8BDE82;
		B0X[ 31:  0] <= data_le[ 31:  0] + 32'hA1A7502B;
		
		M00 <= M0X;

		B00[511:480] <= { B0X[494:480], B0X[511:495] };
		B00[479:448] <= { B0X[462:448], B0X[479:463] };
		B00[447:416] <= { B0X[430:416], B0X[447:431] };
		B00[415:384] <= { B0X[398:384], B0X[415:399] };
		B00[383:352] <= { B0X[366:352], B0X[383:367] };
		B00[351:320] <= { B0X[334:320], B0X[351:335] };
		B00[319:288] <= { B0X[302:288], B0X[319:303] };
		B00[287:256] <= { B0X[270:256], B0X[287:271] };
		B00[255:224] <= { B0X[238:224], B0X[255:239] };
		B00[223:192] <= { B0X[206:192], B0X[223:207] };
		B00[191:160] <= { B0X[174:160], B0X[191:175] };
		B00[159:128] <= { B0X[142:128], B0X[159:143] };
		B00[127: 96] <= { B0X[110: 96], B0X[127:111] };
		B00[ 95: 64] <= { B0X[ 78: 64], B0X[ 95: 79] };
		B00[ 63: 32] <= { B0X[ 46: 32], B0X[ 63: 47] };
		B00[ 31:  0] <= { B0X[ 14:  0], B0X[ 31: 15] };

	end

	wire [383:0] A10_out, A11_out, A12_out;
	wire [511:0] B10_out, B11_out, B12_out;
	wire [511:0] C10_out, C11_out, C12_out;
	wire [511:0] M10_out, M11_out, M12_out;

	reg [383:0] A10, A11, A12, A13, A14, A15;
	reg [511:0] B1X, B10, B11, B12, B13, B14, B15;
	reg [511:0] C1X, C10, C11, C12, C13, C14, C15;
	reg [511:0] M10, M11, M12, M13, M14, M15;

	// Middle Round
	shabal_round sr10 (clk, A10, B10, C10, M10, A10_out, B10_out, C10_out, M10_out);
	shabal_round sr11 (clk, A11, B11, C11, M11, A11_out, B11_out, C11_out, M11_out);
	shabal_round sr12 (clk, A12, B12, C12, M12, A12_out, B12_out, C12_out, M12_out);

	always @ ( posedge clk ) begin
	
		B1X[511:480] <= B04[511:480] + 32'h00000080;
		B1X[479:448] <= B04[479:448];
		B1X[447:416] <= B04[447:416];
		B1X[415:384] <= B04[415:384];
		B1X[383:352] <= B04[383:352];
		B1X[351:320] <= B04[351:320];
		B1X[319:288] <= B04[319:288];
		B1X[287:256] <= B04[287:256];
		B1X[255:224] <= B04[255:224];
		B1X[223:192] <= B04[223:192];
		B1X[191:160] <= B04[191:160];
		B1X[159:128] <= B04[159:128];
		B1X[127: 96] <= B04[127: 96];
		B1X[ 95: 64] <= B04[ 95: 64];
		B1X[ 63: 32] <= B04[ 63: 32];
		B1X[ 31:  0] <= B04[ 31:  0];

		B10[511:480] <= { B1X[494:480], B1X[511:495] };
		B10[479:448] <= { B1X[462:448], B1X[479:463] };
		B10[447:416] <= { B1X[430:416], B1X[447:431] };
		B10[415:384] <= { B1X[398:384], B1X[415:399] };
		B10[383:352] <= { B1X[366:352], B1X[383:367] };
		B10[351:320] <= { B1X[334:320], B1X[351:335] };
		B10[319:288] <= { B1X[302:288], B1X[319:303] };
		B10[287:256] <= { B1X[270:256], B1X[287:271] };
		B10[255:224] <= { B1X[238:224], B1X[255:239] };
		B10[223:192] <= { B1X[206:192], B1X[223:207] };
		B10[191:160] <= { B1X[174:160], B1X[191:175] };
		B10[159:128] <= { B1X[142:128], B1X[159:143] };
		B10[127: 96] <= { B1X[110: 96], B1X[127:111] };
		B10[ 95: 64] <= { B1X[ 78: 64], B1X[ 95: 79] };
		B10[ 63: 32] <= { B1X[ 46: 32], B1X[ 63: 47] };
		B10[ 31:  0] <= { B1X[ 14:  0], B1X[ 31: 15] };
		
		A10 <= A05;
		C10 <= C05;
		M10 <= { 32'h00000080, 480'h0 };

		A11 <= { A10_out[255:0], A10_out[383:256] };
		B11 <= B10_out;
		C11 <= C10_out;
		M11 <= M10_out;

		A12 <= { A11_out[255:0], A11_out[383:256] };
		B12 <= B11_out;
		C12 <= C11_out;
		M12 <= M11_out;

		A13[ 31:  0] <= A12_out[287:256] + C12_out[319:288];
		A13[ 63: 32] <= A12_out[319:288] + C12_out[351:320];
		A13[ 95: 64] <= A12_out[351:320] + C12_out[383:352];
		A13[127: 96] <= A12_out[383:352] + C12_out[415:384];
		A13[159:128] <= A12_out[ 31:  0] + C12_out[447:416];
		A13[191:160] <= A12_out[ 63: 32] + C12_out[479:448];
		A13[223:192] <= A12_out[ 95: 64] + C12_out[511:480];
		A13[255:224] <= A12_out[127: 96] + C12_out[ 31:  0];
		A13[287:256] <= A12_out[159:128] + C12_out[ 63: 32];
		A13[319:288] <= A12_out[191:160] + C12_out[ 95: 64];
		A13[351:320] <= A12_out[223:192] + C12_out[127: 96];
		A13[383:352] <= A12_out[255:224] + C12_out[159:128];
		A14[ 31:  0] <= A13[ 31:  0] + C13[191:160];
		A14[ 63: 32] <= A13[ 63: 32] + C13[223:192];
		A14[ 95: 64] <= A13[ 95: 64] + C13[255:224];
		A14[127: 96] <= A13[127: 96] + C13[287:256];
		A14[159:128] <= A13[159:128] + C13[319:288];
		A14[191:160] <= A13[191:160] + C13[351:320];
		A14[223:192] <= A13[223:192] + C13[383:352];
		A14[255:224] <= A13[255:224] + C13[415:384];
		A14[287:256] <= A13[287:256] + C13[447:416];
		A14[319:288] <= A13[319:288] + C13[479:448];
		A14[351:320] <= A13[351:320] + C13[511:480];
		A14[383:352] <= A13[383:352] + C13[ 31:  0];
		A15[ 31:  0] <= A14[ 31:  0] + C14[ 63: 32];
		A15[ 63: 32] <= A14[ 63: 32] + C14[ 95: 64];
		A15[ 95: 64] <= A14[ 95: 64] + C14[127: 96];
		A15[127: 96] <= A14[127: 96] + C14[159:128];
		A15[159:128] <= A14[159:128] + C14[191:160];
		A15[191:160] <= A14[191:160] + C14[223:192];
		A15[223:192] <= A14[223:192] + C14[255:224];
		A15[255:224] <= A14[255:224] + C14[287:256];
		A15[287:256] <= A14[287:256] + C14[319:288];
		A15[319:288] <= A14[319:288] + C14[351:320];
		A15[351:320] <= A14[351:320] + C14[383:352];
		A15[383:352] <= (A14[383:352] + C14[415:384]) ^ 32'h00000002;
	
		C13 <= C12_out;
		C14 <= C13;
		C15 <= B14;
		
		B13 <= B12_out;
		B14 <= B13;
		B15 <= C14;
		
		M13 <= M12_out;
		M14 <= M13;
		M15 <= M14;

	end

	wire [383:0] A20_out, A21_out, A22_out;
	wire [511:0] B20_out, B21_out, B22_out;
	wire [511:0] C20_out, C21_out, C22_out;
	wire [511:0] M20_out, M21_out, M22_out;

	reg [383:0] A20, A21, A22, A23, A24, A25;
	reg [511:0] B2X, B20, B21, B22, B23, B24, B25;
	reg [511:0] C20, C21, C22, C23, C24, C25;
	reg [511:0] M20, M21, M22, M23, M24, M25;

	// Final Round 1
	shabal_round sr20 (clk, A20, B20, C20, M20, A20_out, B20_out, C20_out, M20_out);
	shabal_round sr21 (clk, A21, B21, C21, M21, A21_out, B21_out, C21_out, M21_out);
	shabal_round sr22 (clk, A22, B22, C22, M22, A22_out, B22_out, C22_out, M22_out);

	always @ ( posedge clk ) begin
	
//		B2X[511:480] <= B14[511:480] + 32'h00000080;
//		B2X[479:448] <= B14[479:448];
//		B2X[447:416] <= B14[447:416];
//		B2X[415:384] <= B14[415:384];
//		B2X[383:352] <= B14[383:352];
//		B2X[351:320] <= B14[351:320];
//		B2X[319:288] <= B14[319:288];
//		B2X[287:256] <= B14[287:256];
//		B2X[255:224] <= B14[255:224];
//		B2X[223:192] <= B14[223:192];
//		B2X[191:160] <= B14[191:160];
//		B2X[159:128] <= B14[159:128];
//		B2X[127: 96] <= B14[127: 96];
//		B2X[ 95: 64] <= B14[ 95: 64];
//		B2X[ 63: 32] <= B14[ 63: 32];
//		B2X[ 31:  0] <= B14[ 31:  0];

		B2X[511:480] <= C14[511:480];
		B2X[479:448] <= C14[479:448];
		B2X[447:416] <= C14[447:416];
		B2X[415:384] <= C14[415:384];
		B2X[383:352] <= C14[383:352];
		B2X[351:320] <= C14[351:320];
		B2X[319:288] <= C14[319:288];
		B2X[287:256] <= C14[287:256];
		B2X[255:224] <= C14[255:224];
		B2X[223:192] <= C14[223:192];
		B2X[191:160] <= C14[191:160];
		B2X[159:128] <= C14[159:128];
		B2X[127: 96] <= C14[127: 96];
		B2X[ 95: 64] <= C14[ 95: 64];
		B2X[ 63: 32] <= C14[ 63: 32];
		B2X[ 31:  0] <= C14[ 31:  0];

		B20[511:480] <= { B2X[494:480], B2X[511:495] };
		B20[479:448] <= { B2X[462:448], B2X[479:463] };
		B20[447:416] <= { B2X[430:416], B2X[447:431] };
		B20[415:384] <= { B2X[398:384], B2X[415:399] };
		B20[383:352] <= { B2X[366:352], B2X[383:367] };
		B20[351:320] <= { B2X[334:320], B2X[351:335] };
		B20[319:288] <= { B2X[302:288], B2X[319:303] };
		B20[287:256] <= { B2X[270:256], B2X[287:271] };
		B20[255:224] <= { B2X[238:224], B2X[255:239] };
		B20[223:192] <= { B2X[206:192], B2X[223:207] };
		B20[191:160] <= { B2X[174:160], B2X[191:175] };
		B20[159:128] <= { B2X[142:128], B2X[159:143] };
		B20[127: 96] <= { B2X[110: 96], B2X[127:111] };
		B20[ 95: 64] <= { B2X[ 78: 64], B2X[ 95: 79] };
		B20[ 63: 32] <= { B2X[ 46: 32], B2X[ 63: 47] };
		B20[ 31:  0] <= { B2X[ 14:  0], B2X[ 31: 15] };
		
		A20 <= A15;
		C20 <= C15;
		M20 <= { 32'h00000080, 480'h0 };


		A21 <= { A20_out[255:0], A20_out[383:256] };
		B21 <= B20_out;
		C21 <= C20_out;
		M21 <= M20_out;

		A22 <= { A21_out[255:0], A21_out[383:256] };
		B22 <= B21_out;
		C22 <= C21_out;
		M22 <= M21_out;

		A23[ 31:  0] <= A22_out[287:256] + C22_out[319:288];
		A23[ 63: 32] <= A22_out[319:288] + C22_out[351:320];
		A23[ 95: 64] <= A22_out[351:320] + C22_out[383:352];
		A23[127: 96] <= A22_out[383:352] + C22_out[415:384];
		A23[159:128] <= A22_out[ 31:  0] + C22_out[447:416];
		A23[191:160] <= A22_out[ 63: 32] + C22_out[479:448];
		A23[223:192] <= A22_out[ 95: 64] + C22_out[511:480];
		A23[255:224] <= A22_out[127: 96] + C22_out[ 31:  0];
		A23[287:256] <= A22_out[159:128] + C22_out[ 63: 32];
		A23[319:288] <= A22_out[191:160] + C22_out[ 95: 64];
		A23[351:320] <= A22_out[223:192] + C22_out[127: 96];
		A23[383:352] <= A22_out[255:224] + C22_out[159:128];
		A24[ 31:  0] <= A23[ 31:  0] + C23[191:160];
		A24[ 63: 32] <= A23[ 63: 32] + C23[223:192];
		A24[ 95: 64] <= A23[ 95: 64] + C23[255:224];
		A24[127: 96] <= A23[127: 96] + C23[287:256];
		A24[159:128] <= A23[159:128] + C23[319:288];
		A24[191:160] <= A23[191:160] + C23[351:320];
		A24[223:192] <= A23[223:192] + C23[383:352];
		A24[255:224] <= A23[255:224] + C23[415:384];
		A24[287:256] <= A23[287:256] + C23[447:416];
		A24[319:288] <= A23[319:288] + C23[479:448];
		A24[351:320] <= A23[351:320] + C23[511:480];
		A24[383:352] <= A23[383:352] + C23[ 31:  0];
		A25[ 31:  0] <= A24[ 31:  0] + C24[ 63: 32];
		A25[ 63: 32] <= A24[ 63: 32] + C24[ 95: 64];
		A25[ 95: 64] <= A24[ 95: 64] + C24[127: 96];
		A25[127: 96] <= A24[127: 96] + C24[159:128];
		A25[159:128] <= A24[159:128] + C24[191:160];
		A25[191:160] <= A24[191:160] + C24[223:192];
		A25[223:192] <= A24[223:192] + C24[255:224];
		A25[255:224] <= A24[255:224] + C24[287:256];
		A25[287:256] <= A24[287:256] + C24[319:288];
		A25[319:288] <= A24[319:288] + C24[351:320];
		A25[351:320] <= A24[351:320] + C24[383:352];
		A25[383:352] <= (A24[383:352] + C24[415:384]) ^ 32'h00000002;
	
		C23 <= C22_out;
		C24 <= C23;
		C25 <= B24;
		
		B23 <= B22_out;
		B24 <= B23;
		B25 <= C24;
		
		M23 <= M22_out;
		M24 <= M23;
		M25 <= M24;

	end

	wire [383:0] A30_out, A31_out, A32_out;
	wire [511:0] B30_out, B31_out, B32_out;
	wire [511:0] C30_out, C31_out, C32_out;
	wire [511:0] M30_out, M31_out, M32_out;

	reg [383:0] A30, A31, A32, A33, A34, A35;
	reg [511:0] B3X, B30, B31, B32, B33, B34, B35;
	reg [511:0] C30, C31, C32, C33, C34, C35;
	reg [511:0] M30, M31, M32, M33, M34, M35;

	// Final Round 2
	shabal_round sr30 (clk, A30, B30, C30, M30, A30_out, B30_out, C30_out, M30_out);
	shabal_round sr31 (clk, A31, B31, C31, M31, A31_out, B31_out, C31_out, M31_out);
	shabal_round sr32 (clk, A32, B32, C32, M32, A32_out, B32_out, C32_out, M32_out);

	always @ ( posedge clk ) begin

		B3X[511:480] <= C24[511:480];
		B3X[479:448] <= C24[479:448];
		B3X[447:416] <= C24[447:416];
		B3X[415:384] <= C24[415:384];
		B3X[383:352] <= C24[383:352];
		B3X[351:320] <= C24[351:320];
		B3X[319:288] <= C24[319:288];
		B3X[287:256] <= C24[287:256];
		B3X[255:224] <= C24[255:224];
		B3X[223:192] <= C24[223:192];
		B3X[191:160] <= C24[191:160];
		B3X[159:128] <= C24[159:128];
		B3X[127: 96] <= C24[127: 96];
		B3X[ 95: 64] <= C24[ 95: 64];
		B3X[ 63: 32] <= C24[ 63: 32];
		B3X[ 31:  0] <= C24[ 31:  0];

		B30[511:480] <= { B3X[494:480], B3X[511:495] };
		B30[479:448] <= { B3X[462:448], B3X[479:463] };
		B30[447:416] <= { B3X[430:416], B3X[447:431] };
		B30[415:384] <= { B3X[398:384], B3X[415:399] };
		B30[383:352] <= { B3X[366:352], B3X[383:367] };
		B30[351:320] <= { B3X[334:320], B3X[351:335] };
		B30[319:288] <= { B3X[302:288], B3X[319:303] };
		B30[287:256] <= { B3X[270:256], B3X[287:271] };
		B30[255:224] <= { B3X[238:224], B3X[255:239] };
		B30[223:192] <= { B3X[206:192], B3X[223:207] };
		B30[191:160] <= { B3X[174:160], B3X[191:175] };
		B30[159:128] <= { B3X[142:128], B3X[159:143] };
		B30[127: 96] <= { B3X[110: 96], B3X[127:111] };
		B30[ 95: 64] <= { B3X[ 78: 64], B3X[ 95: 79] };
		B30[ 63: 32] <= { B3X[ 46: 32], B3X[ 63: 47] };
		B30[ 31:  0] <= { B3X[ 14:  0], B3X[ 31: 15] };
		
		A30 <= A25;
		C30 <= C25;
		M30 <= { 32'h00000080, 480'h0 };


		A31 <= { A30_out[255:0], A30_out[383:256] };
		B31 <= B30_out;
		C31 <= C30_out;
		M31 <= M30_out;

		A32 <= { A31_out[255:0], A31_out[383:256] };
		B32 <= B31_out;
		C32 <= C31_out;
		M32 <= M31_out;

		A33[ 31:  0] <= A32_out[287:256] + C32_out[319:288];
		A33[ 63: 32] <= A32_out[319:288] + C32_out[351:320];
		A33[ 95: 64] <= A32_out[351:320] + C32_out[383:352];
		A33[127: 96] <= A32_out[383:352] + C32_out[415:384];
		A33[159:128] <= A32_out[ 31:  0] + C32_out[447:416];
		A33[191:160] <= A32_out[ 63: 32] + C32_out[479:448];
		A33[223:192] <= A32_out[ 95: 64] + C32_out[511:480];
		A33[255:224] <= A32_out[127: 96] + C32_out[ 31:  0];
		A33[287:256] <= A32_out[159:128] + C32_out[ 63: 32];
		A33[319:288] <= A32_out[191:160] + C32_out[ 95: 64];
		A33[351:320] <= A32_out[223:192] + C32_out[127: 96];
		A33[383:352] <= A32_out[255:224] + C32_out[159:128];
		A34[ 31:  0] <= A33[ 31:  0] + C33[191:160];
		A34[ 63: 32] <= A33[ 63: 32] + C33[223:192];
		A34[ 95: 64] <= A33[ 95: 64] + C33[255:224];
		A34[127: 96] <= A33[127: 96] + C33[287:256];
		A34[159:128] <= A33[159:128] + C33[319:288];
		A34[191:160] <= A33[191:160] + C33[351:320];
		A34[223:192] <= A33[223:192] + C33[383:352];
		A34[255:224] <= A33[255:224] + C33[415:384];
		A34[287:256] <= A33[287:256] + C33[447:416];
		A34[319:288] <= A33[319:288] + C33[479:448];
		A34[351:320] <= A33[351:320] + C33[511:480];
		A34[383:352] <= A33[383:352] + C33[ 31:  0];
		A35[ 31:  0] <= A34[ 31:  0] + C34[ 63: 32];
		A35[ 63: 32] <= A34[ 63: 32] + C34[ 95: 64];
		A35[ 95: 64] <= A34[ 95: 64] + C34[127: 96];
		A35[127: 96] <= A34[127: 96] + C34[159:128];
		A35[159:128] <= A34[159:128] + C34[191:160];
		A35[191:160] <= A34[191:160] + C34[223:192];
		A35[223:192] <= A34[223:192] + C34[255:224];
		A35[255:224] <= A34[255:224] + C34[287:256];
		A35[287:256] <= A34[287:256] + C34[319:288];
		A35[319:288] <= A34[319:288] + C34[351:320];
		A35[351:320] <= A34[351:320] + C34[383:352];
		A35[383:352] <= (A34[383:352] + C34[415:384]) ^ 32'h00000002;
	
		C33 <= C32_out;
		C34 <= C33;
		C35 <= B34;
		
		B33 <= B32_out;
		B34 <= B33;
		B35 <= C34;
		
		M33 <= M32_out;
		M34 <= M33;
		M35 <= M34;

	end

	wire [383:0] A40_out, A41_out, A42_out;
	wire [511:0] B40_out, B41_out, B42_out;
	wire [511:0] C40_out, C41_out, C42_out;
	wire [511:0] M40_out, M41_out, M42_out;

	reg [383:0] A40, A41, A42, A43, A44, A45;
	reg [511:0] B4X, B40, B41, B42, B43, B44, B45;
	reg [511:0] C40, C41, C42, C43, C44, C45;
	reg [511:0] M40, M41, M42, M43, M44, M45;

	// Final Round 3
	shabal_round sr40 (clk, A40, B40, C40, M40, A40_out, B40_out, C40_out, M40_out);
	shabal_round sr41 (clk, A41, B41, C41, M41, A41_out, B41_out, C41_out, M41_out);
	shabal_round sr42 (clk, A42, B42, C42, M42, A42_out, B42_out, C42_out, M42_out);

	always @ ( posedge clk ) begin

		B4X[511:480] <= C34[511:480];
		B4X[479:448] <= C34[479:448];
		B4X[447:416] <= C34[447:416];
		B4X[415:384] <= C34[415:384];
		B4X[383:352] <= C34[383:352];
		B4X[351:320] <= C34[351:320];
		B4X[319:288] <= C34[319:288];
		B4X[287:256] <= C34[287:256];
		B4X[255:224] <= C34[255:224];
		B4X[223:192] <= C34[223:192];
		B4X[191:160] <= C34[191:160];
		B4X[159:128] <= C34[159:128];
		B4X[127: 96] <= C34[127: 96];
		B4X[ 95: 64] <= C34[ 95: 64];
		B4X[ 63: 32] <= C34[ 63: 32];
		B4X[ 31:  0] <= C34[ 31:  0];

		B40[511:480] <= { B4X[494:480], B4X[511:495] };
		B40[479:448] <= { B4X[462:448], B4X[479:463] };
		B40[447:416] <= { B4X[430:416], B4X[447:431] };
		B40[415:384] <= { B4X[398:384], B4X[415:399] };
		B40[383:352] <= { B4X[366:352], B4X[383:367] };
		B40[351:320] <= { B4X[334:320], B4X[351:335] };
		B40[319:288] <= { B4X[302:288], B4X[319:303] };
		B40[287:256] <= { B4X[270:256], B4X[287:271] };
		B40[255:224] <= { B4X[238:224], B4X[255:239] };
		B40[223:192] <= { B4X[206:192], B4X[223:207] };
		B40[191:160] <= { B4X[174:160], B4X[191:175] };
		B40[159:128] <= { B4X[142:128], B4X[159:143] };
		B40[127: 96] <= { B4X[110: 96], B4X[127:111] };
		B40[ 95: 64] <= { B4X[ 78: 64], B4X[ 95: 79] };
		B40[ 63: 32] <= { B4X[ 46: 32], B4X[ 63: 47] };
		B40[ 31:  0] <= { B4X[ 14:  0], B4X[ 31: 15] };
		
		A40 <= A35;
		C40 <= C35;
		M40 <= { 32'h00000080, 480'h0 };


		A41 <= { A40_out[255:0], A40_out[383:256] };
		B41 <= B40_out;
		C41 <= C40_out;
		M41 <= M40_out;

		A42 <= { A41_out[255:0], A41_out[383:256] };
		B42 <= B41_out;
		C42 <= C41_out;
		M42 <= M41_out;

		A43[ 31:  0] <= A42_out[287:256] + C42_out[319:288];
		A43[ 63: 32] <= A42_out[319:288] + C42_out[351:320];
		A43[ 95: 64] <= A42_out[351:320] + C42_out[383:352];
		A43[127: 96] <= A42_out[383:352] + C42_out[415:384];
		A43[159:128] <= A42_out[ 31:  0] + C42_out[447:416];
		A43[191:160] <= A42_out[ 63: 32] + C42_out[479:448];
		A43[223:192] <= A42_out[ 95: 64] + C42_out[511:480];
		A43[255:224] <= A42_out[127: 96] + C42_out[ 31:  0];
		A43[287:256] <= A42_out[159:128] + C42_out[ 63: 32];
		A43[319:288] <= A42_out[191:160] + C42_out[ 95: 64];
		A43[351:320] <= A42_out[223:192] + C42_out[127: 96];
		A43[383:352] <= A42_out[255:224] + C42_out[159:128];
		A44[ 31:  0] <= A43[ 31:  0] + C43[191:160];
		A44[ 63: 32] <= A43[ 63: 32] + C43[223:192];
		A44[ 95: 64] <= A43[ 95: 64] + C43[255:224];
		A44[127: 96] <= A43[127: 96] + C43[287:256];
		A44[159:128] <= A43[159:128] + C43[319:288];
		A44[191:160] <= A43[191:160] + C43[351:320];
		A44[223:192] <= A43[223:192] + C43[383:352];
		A44[255:224] <= A43[255:224] + C43[415:384];
		A44[287:256] <= A43[287:256] + C43[447:416];
		A44[319:288] <= A43[319:288] + C43[479:448];
		A44[351:320] <= A43[351:320] + C43[511:480];
		A44[383:352] <= A43[383:352] + C43[ 31:  0];
		A45[ 31:  0] <= A44[ 31:  0] + C44[ 63: 32];
		A45[ 63: 32] <= A44[ 63: 32] + C44[ 95: 64];
		A45[ 95: 64] <= A44[ 95: 64] + C44[127: 96];
		A45[127: 96] <= A44[127: 96] + C44[159:128];
		A45[159:128] <= A44[159:128] + C44[191:160];
		A45[191:160] <= A44[191:160] + C44[223:192];
		A45[223:192] <= A44[223:192] + C44[255:224];
		A45[255:224] <= A44[255:224] + C44[287:256];
		A45[287:256] <= A44[287:256] + C44[319:288];
		A45[319:288] <= A44[319:288] + C44[351:320];
		A45[351:320] <= A44[351:320] + C44[383:352];
		A45[383:352] <= A44[383:352] + C44[415:384];

		h <= B42_out;

	end





endmodule

module shabal_round (
	input clk,
	input [383:0] A,
	input [511:0] B,
	input [511:0] C,
	input [511:0] M,
	output [383:0] A_out,
	output [511:0] B_out,
	output [511:0] C_out,
	output [511:0] M_out
);

	wire [31:0] A10,A11,A12,A13,A14,A15,A16,A17,A18,A19,A1A,A1B,A1C,A1D,A1E,A1F;
	wire [31:0] B10,B11,B12,B13,B14,B15,B16,B17,B18,B19,B1A,B1B,B1C,B1D,B1E,B1F;
	
	reg [383:0] A0,A1,A2,A3,A4,A5,A6,A7,A8,A9,AA,AB,AC,AD,AE,AF;
	reg [511:0] B0,B1,B2,B3,B4,B5,B6,B7,B8,B9,BA,BB,BC,BD,BE,BF;
	reg [511:0] C0,C1,C2,C3,C4,C5,C6,C7,C8,C9,CA,CB,CC,CD,CE,CF;
	reg [511:0] M0,M1,M2,M3,M4,M5,M6,M7,M8,M9,MA,MB,MC,MD,ME,MF;

	shabal_permutation sp00 (A0[383:352], A0[31:  0], B0[511:480], B0[319:288], B0[223:192], B0[ 95: 64], C0[255:224], M0[511:480], A10, B10);
	shabal_permutation sp01 (A1[383:352], A1[31:  0], B1[511:480], B1[319:288], B1[223:192], B1[ 95: 64], C1[255:224], M1[511:480], A11, B11);
	shabal_permutation sp02 (A2[383:352], A2[31:  0], B2[511:480], B2[319:288], B2[223:192], B2[ 95: 64], C2[255:224], M2[511:480], A12, B12);
	shabal_permutation sp03 (A3[383:352], A3[31:  0], B3[511:480], B3[319:288], B3[223:192], B3[ 95: 64], C3[255:224], M3[511:480], A13, B13);
	shabal_permutation sp04 (A4[383:352], A4[31:  0], B4[511:480], B4[319:288], B4[223:192], B4[ 95: 64], C4[255:224], M4[511:480], A14, B14);
	shabal_permutation sp05 (A5[383:352], A5[31:  0], B5[511:480], B5[319:288], B5[223:192], B5[ 95: 64], C5[255:224], M5[511:480], A15, B15);
	shabal_permutation sp06 (A6[383:352], A6[31:  0], B6[511:480], B6[319:288], B6[223:192], B6[ 95: 64], C6[255:224], M6[511:480], A16, B16);
	shabal_permutation sp07 (A7[383:352], A7[31:  0], B7[511:480], B7[319:288], B7[223:192], B7[ 95: 64], C7[255:224], M7[511:480], A17, B17);
	shabal_permutation sp08 (A8[383:352], A8[31:  0], B8[511:480], B8[319:288], B8[223:192], B8[ 95: 64], C8[255:224], M8[511:480], A18, B18);
	shabal_permutation sp09 (A9[383:352], A9[31:  0], B9[511:480], B9[319:288], B9[223:192], B9[ 95: 64], C9[255:224], M9[511:480], A19, B19);
	shabal_permutation sp0A (AA[383:352], AA[31:  0], BA[511:480], BA[319:288], BA[223:192], BA[ 95: 64], CA[255:224], MA[511:480], A1A, B1A);
	shabal_permutation sp0B (AB[383:352], AB[31:  0], BB[511:480], BB[319:288], BB[223:192], BB[ 95: 64], CB[255:224], MB[511:480], A1B, B1B);
	shabal_permutation sp0C (AC[383:352], AC[31:  0], BC[511:480], BC[319:288], BC[223:192], BC[ 95: 64], CC[255:224], MC[511:480], A1C, B1C);
	shabal_permutation sp0D (AD[383:352], AD[31:  0], BD[511:480], BD[319:288], BD[223:192], BD[ 95: 64], CD[255:224], MD[511:480], A1D, B1D);
	shabal_permutation sp0E (AE[383:352], AE[31:  0], BE[511:480], BE[319:288], BE[223:192], BE[ 95: 64], CE[255:224], ME[511:480], A1E, B1E);
	shabal_permutation sp0F (AF[383:352], AF[31:  0], BF[511:480], BF[319:288], BF[223:192], BF[ 95: 64], CF[255:224], MF[511:480], A1F, B1F);

	always @ ( posedge clk ) begin
	
		A0 <= A;
		B0 <= B;
		C0 <= C;
		M0 <= M;
		
		A1 <= { A0[351:0], A10 };
		B1 <= { B0[479:0], B10 };
		C1 <= { C0[31:0], C0[511:32] };
		M1 <= { M0[479:0], M0[511:480] };

		A2 <= { A1[351:0], A11 };
		B2 <= { B1[479:0], B11 };
		C2 <= { C1[31:0], C1[511:32] };
		M2 <= { M1[479:0], M1[511:480] };

		A3 <= { A2[351:0], A12 };
		B3 <= { B2[479:0], B12 };
		C3 <= { C2[31:0], C2[511:32] };
		M3 <= { M2[479:0], M2[511:480] };

		A4 <= { A3[351:0], A13 };
		B4 <= { B3[479:0], B13 };
		C4 <= { C3[31:0], C3[511:32] };
		M4 <= { M3[479:0], M3[511:480] };

		A5 <= { A4[351:0], A14 };
		B5 <= { B4[479:0], B14 };
		C5 <= { C4[31:0], C4[511:32] };
		M5 <= { M4[479:0], M4[511:480] };

		A6 <= { A5[351:0], A15 };
		B6 <= { B5[479:0], B15 };
		C6 <= { C5[31:0], C5[511:32] };
		M6 <= { M5[479:0], M5[511:480] };

		A7 <= { A6[351:0], A16 };
		B7 <= { B6[479:0], B16 };
		C7 <= { C6[31:0], C6[511:32] };
		M7 <= { M6[479:0], M6[511:480] };

		A8 <= { A7[351:0], A17 };
		B8 <= { B7[479:0], B17 };
		C8 <= { C7[31:0], C7[511:32] };
		M8 <= { M7[479:0], M7[511:480] };

		A9 <= { A8[351:0], A18 };
		B9 <= { B8[479:0], B18 };
		C9 <= { C8[31:0], C8[511:32] };
		M9 <= { M8[479:0], M8[511:480] };

		AA <= { A9[351:0], A19 };
		BA <= { B9[479:0], B19 };
		CA <= { C9[31:0], C9[511:32] };
		MA <= { M9[479:0], M9[511:480] };

		AB <= { AA[351:0], A1A };
		BB <= { BA[479:0], B1A };
		CB <= { CA[31:0], CA[511:32] };
		MB <= { MA[479:0], MA[511:480] };

		AC <= { AB[351:0], A1B };
		BC <= { BB[479:0], B1B };
		CC <= { CB[31:0], CB[511:32] };
		MC <= { MB[479:0], MB[511:480] };

		AD <= { AC[351:0], A1C };
		BD <= { BC[479:0], B1C };
		CD <= { CC[31:0], CC[511:32] };
		MD <= { MC[479:0], MC[511:480] };

		AE <= { AD[351:0], A1D };
		BE <= { BD[479:0], B1D };
		CE <= { CD[31:0], CD[511:32] };
		ME <= { MD[479:0], MD[511:480] };

		AF <= { AE[351:0], A1E };
		BF <= { BE[479:0], B1E };
		CF <= { CE[31:0], CE[511:32] };
		MF <= { ME[479:0], ME[511:480] };

	end

	assign A_out = { AF[95:0], A1F, AF[351:96] };
	assign B_out = { BF[479:0], B1F };
	assign C_out = { CF[31:0], CF[511:32] };
	assign M_out = { MF[479:0], MF[511:480] };
	
endmodule

module shabal_permutation (
	input [31:0] A0,
	input [31:0] AB,
	input [31:0] B0,
	input [31:0] B6,
	input [31:0] B9,
	input [31:0] BD,
	input [31:0] C8,
	input [31:0] M0,
	output [31:0] A_out,
	output [31:0] B_out
);
	wire [31:0] V, U, B, A0_rot, B0_rot;

	assign A0_rot = { AB[16:0], AB[31:17] };
	assign V = { A0_rot[29:0], 2'h0 } + A0_rot;
	assign U = { (V[30:0] ^ A0[30:0] ^ C8[30:0]), 1'h0 } + (V ^ A0 ^ C8);
	assign B = (~B6 & B9) ^ BD;
	assign A_out = U ^ B ^ M0;
	assign B0_rot = { B0[30:0], B0[31] };
	assign B_out = ~(A_out ^ B0_rot);

endmodule
