// Vincent Mai 217990136
// Minhyeok An 217078668

module outputHex(a, b, c, d, e, hex_location);

	input a;
	input b;
	input c;
	input d;
	input e;
	output [7:0] hex_location;

	// Segment 0
	assign hex_location[0] = (~a & ~b & ~c & d) + (~a & b & ~c & ~d) + (a & ~b & c & d) + (a & b & ~c & d);
	
	// Segment 1
	assign hex_location[1] = (~a & b & ~c & d) + (~a & b & c & ~d) + (a & ~b & c & d) + (a & b & ~c & ~d) + (a & b & c & ~d);
	
	// Segment 2
	assign hex_location[2] = (~a  & ~b & c & ~d) + (a & b & ~c & ~d) + (a & b & c & ~d);
	
	// Segment 3
	assign hex_location[3] = (~a & ~b & ~c & d) + (~a & b & ~c & ~d) + (~a & b & c & d) + (a & ~b & c & ~d);
	
	// Segment 4
	assign hex_location[4] = (~a & ~b & ~c & d) + (~a & ~b & c & d) + (~a & b & ~c & ~d) + (~a & b & ~c & d) + (~a & b & c & d) + (a & ~b & ~c & d);
	
	// Segment 5
	assign hex_location[5] = (~a & ~b & ~c & d) + (~a & ~b & c & ~d) + (~a & ~b & c & d) + (~a & b & c & d) + (a & b & ~c & d);
	
	// Segment 6
	assign hex_location[6] = (~a & ~b & ~c & ~d) + (~a & ~b & ~c & d) + (~a & b & c & d) + (a & b & ~c & ~d);
	
	// Segment 7, set decimal point to on if "alarm" is set to ON
	assign hex_location[7] = ~e;

endmodule