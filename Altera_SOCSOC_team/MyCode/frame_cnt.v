module frame_cnt(clk, rstn, valid, sig);

input	clk;
input	rstn;
input	valid;
output reg	sig;

reg [18:0] counter;

always @ (posedge clk or negedge rstn)
begin
	if(!rstn)	begin
		counter <= 0;
		sig	<= 0;
	end
	else if(counter == 19'd307200)	begin
		counter <= 0;
		sig	<= ~sig;
	end
	else if(valid)		counter <= counter + 19'b1;
end

endmodule