module yuv2rgb (valid, clk, rst, Y, U, V, R, G, B, outvalid);

	input				valid, clk, rst;
	input [7:0]		Y, U, V;
	output	reg	[7:0]	R, G, B;
	output	reg	outvalid;
	
	wire	[8:0]		Y9, U9, V9;
	wire	[17:0]	R1, G1, B1;
	wire	[9:0]		R2, G2, B2;
	
	assign Y9 = {1'b0,Y};
	assign U9 = {1'b0,U};
	assign V9 = {1'b0,V};
	
	assign R1 = Y9*9'b100101100 + V9*9'b110011010 - 18'b001101111100000000;
	assign G1 = Y9*9'b100101100 - U9*9'b001100100 - V9*9'b011010000 + 18'b001000100000000000;
	assign B1 = Y9*9'b100101100 + U9*9'b111111111 - 18'b010001011000000000;
	
	/*assign R2 = R1[17:8] - 10'b0011011111;
	assign G2 = G1[17:8] + 10'b0010001000;
	assign B2 = B1[17:8] - 10'b0100010110;*/

	always @(posedge clk or negedge rst)	
	begin
		if	(!rst)	begin
			R <= 8'b0;
			G <= 8'b0;
			B <= 8'b0;
		end
		else	if	(valid)	begin
			if(R1[17:8] > 10'b1100111001)				R <= 8'b0;
			else if(R1[17:8] > 10'b0011111111)		R <= 8'b11111111;
			else										R <= R1[15:8];
			
			if(G1[17:8] > 10'b1101100101)				G <= 8'b0;
			else if(G1[17:8] > 10'b0011111111)		G <= 8'b11111111;
			else										G <= G1[15:8];
			
			if(B1[17:8] > 10'b1100001001)				B <= 8'b0;
			else if(B1[17:8] > 10'b0011111111)		B <= 8'b11111111;
			else										B <= B1[15:8];

			outvalid	<= 1'b1;
		end
		else	outvalid <= 0;
	end
	
	
endmodule
