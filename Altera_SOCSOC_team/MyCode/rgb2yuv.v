module rgb2yuv (valid, clk, rst, R, G, B, Y, U, V, outvalid);

	input				valid, clk, rst;
	input 	[7:0]	R, G, B;
	output	reg	[7:0]	Y,	U, V;
	output	reg	outvalid;
	
	wire	[15:0]	Y1, U1, V1;
		
	assign Y1 = R * 8'b01000001 + G * 8'b10000000 + B * 8'b00011001 + 16'b0001000000000000;
	assign U1 = B * 8'b01110000 - R * 8'b00100110 - G * 8'b01001010 + 16'b1000000000000000;
	assign V1 = R * 8'b01110000 - G * 8'b01011110 - B * 8'b00010010 + 16'b1000000000000000;

	always @(posedge clk or negedge rst)	
	begin
		if	(!rst)	begin
			Y <= 8'b0;
			U <= 8'b0;
			V <= 8'b0;
			outvalid <= 1'b0;
		end
		else	if	(valid)	begin
			Y <= Y1[15:8]; 
			U <= U1[15:8]; 
			V <= V1[15:8];
			outvalid <= 1'b1;
		end
		else	outvalid <= 1'b0;
	end
	
endmodule
