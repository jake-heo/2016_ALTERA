module histeq (valid, wsig, rsig, clk, rst, ydata, iydata, outY);

	input	valid, wsig, rsig, clk, rst;
	input	[7:0]	ydata, iydata;
	
	output	[7:0]	outY;
	
	reg	[18:0]	histY	[0:255];
	reg	[18:0]	ehistY [0:255];
	reg	pwsig;
	integer		i;
	
	wire	[24:0]	aout;
	wire	erst, wend;
	
	always @(posedge clk or negedge erst)	begin
		if(!erst)	begin

			for(i=0; i<256; i=i+1)	begin
				histY[i]		<= 19'b0;
			end
			
		end
		else	if (valid & wsig)	begin
			for(i=0; i<256 ; i=i+1)	begin
				if(i>=ydata)	histY[i] <= histY[i] + 1'b1;
			end			
		end
		else if (wend)	begin
			for(i=0; i<256; i=i+1)	begin
				ehistY[i] <= histY[i];
			end
		end
	end
	
	always @(posedge clk or negedge rst)	begin
		if(!rst)		pwsig <= 0;
		else			pwsig <= wsig;
	end
			
	assign erst = !(!pwsig & wsig) & rst;		
	assign wend = pwsig & !wsig;
	assign aout = ehistY[iydata] * 6'b110110;
	assign outY = aout[24] ? 8'b11111111 : aout[23:16];
	
endmodule
		