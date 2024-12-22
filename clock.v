// Vincent Mai 217990136
// Minhyeok An 217078668

module clock(cin,clk);

	 input cin;
	 output reg clk;
	 reg[32:0] count = 0;
	 always @(posedge cin) begin
		 count <= count + 1;
		 if (count >= 25000000) begin
			 clk <= ~clk;
			 count <= 0;
		 end
	 end
	 
endmodule