module tlbuffer(clk, rstn, idata1, idata2, idata3, odata);

	input clk, rstn;
	input	[7:0]	idata1, idata2, idata3;
	output	reg	[7:0] odata;
	
	reg	[7:0]	a1, a2, a3, b1, b2, b3, c1, c2, c3;
	reg	[10:0]	caldata;
	
	wire [11:0]	cal, center;
	
	always@(posedge clk or negedge rstn)	begin
		if(!rstn)	begin
			a1 <= 8'b0;
			a2 <= 8'b0;
			a3 <= 8'b0;
			b1 <= 8'b0;
			b2 <= 8'b0;
			b3 <= 8'b0;
			c1 <= 8'b0;
			c2 <= 8'b0;
			c3 <= 8'b0;
		end
		else	begin
			a1 <= idata1;
			a2 <= a1;
			a3 <= a2;
			b1 <= idata2;
			b2 <= b1;
			b3 <= b2;
			c1 <= idata3;
			c2 <= c1;
			c3 <= c2;
			if(cal > center)	caldata <= cal - center;
			else	caldata <= 11'b0;
		end
	end
	
	assign cal = a1 + a2 + a3 + b1 + b3 + c1 + c2 + c3;
	assign center = b2*4'b1000;
endmodule
	