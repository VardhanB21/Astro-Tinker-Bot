module WordToASCII (
  input  clk_3125K,
  input  rst,
  input  [7:0] word_input_0,
  input  [7:0] word_input_1,
  input  [7:0] word_input_2,
  input  [7:0] word_input_3,
  input  [7:0] word_input_4,
  input  [7:0] word_input_5,
  input  [7:0] word_input_6,
  input  [7:0] word_input_7,
  input  [7:0] word_input_8,
  input  [7:0] word_input_9,
  output [7:0] ascii_output
);

  reg [4:0] char_count;
  reg [7:0] current_char;
  reg [10:0] cycle_count;
  reg [7:0] prev_word_input_0, prev_word_input_1, prev_word_input_2, prev_word_input_3, prev_word_input_4,
  prev_word_input_5, prev_word_input_6, prev_word_input_7, prev_word_input_8, prev_word_input_9;
  
  initial begin
    prev_word_input_0 = 8'h00;
    prev_word_input_1 = 8'h00;
    prev_word_input_2 = 8'h00;
    prev_word_input_3 = 8'h00;
    prev_word_input_4 = 8'h00;
	 prev_word_input_5 = 8'h00;
    prev_word_input_6 = 8'h00;
    prev_word_input_7 = 8'h00;
    prev_word_input_8 = 8'h00;
    prev_word_input_9 = 8'h00;
    current_char = 8'h00;
	 char_count = 0;
	 cycle_count = 0;
  end

  // Internal logic for sequential processing
  always @(posedge clk_3125K or posedge !rst) begin
  
		 if (!rst) begin
			char_count = 0;
			current_char = 8'h00; // Set to 0 during reset
			cycle_count  = 0;
			prev_word_input_0 = 8'h00; // Initialize to 0
			prev_word_input_1 = 8'h00;
			prev_word_input_2 = 8'h00;
			prev_word_input_3 = 8'h00;
			prev_word_input_4 = 8'h00;
			prev_word_input_5 = 8'h00;
			 prev_word_input_6 = 8'h00;
			 prev_word_input_7 = 8'h00;
			 prev_word_input_8 = 8'h00;
			 prev_word_input_9 = 8'h00;
		 end 
	 
		 else begin
			 if (cycle_count >= 290) begin
					  if ((char_count < 10) && 
							(word_input_0 != prev_word_input_0 || 
							 word_input_1 != prev_word_input_1 || 
							 word_input_2 != prev_word_input_2 || 
							 word_input_3 != prev_word_input_3 || 
							 word_input_4 != prev_word_input_4 ||
							 word_input_5 != prev_word_input_5 ||
							 word_input_6 != prev_word_input_6 ||
							 word_input_7 != prev_word_input_7 ||
							 word_input_8 != prev_word_input_8 ||
							 word_input_9 != prev_word_input_9)) begin
						 case (char_count)
							0: current_char = word_input_0;
							1: current_char = word_input_1;
							2: current_char = word_input_2;
							3: current_char = word_input_3;
							4: current_char = word_input_4;
							5: current_char = word_input_5;
							6: current_char = word_input_6;
							7: current_char = word_input_7;
							8: current_char = word_input_8;
							9: current_char = word_input_9;
						 endcase
						 char_count = char_count + 1;
					  end
				  
					  else if (char_count >= 10) begin
						 current_char = 8'h00; // Set to 0 when all characters are processed
						 prev_word_input_0 = word_input_0;
						 prev_word_input_1 = word_input_1;
						 prev_word_input_2 = word_input_2;
						 prev_word_input_3 = word_input_3;
						 prev_word_input_4 = word_input_4;
						 prev_word_input_5 = word_input_5;
						 prev_word_input_6 = word_input_6;
						 prev_word_input_7 = word_input_7;
						 prev_word_input_8 = word_input_8;
						 prev_word_input_9 = word_input_9;
						 char_count = 0;
					  end 
					  
					  else begin
						 current_char = 8'h00;
					  end
					  cycle_count = 0;
			  end 
			
				else begin
				  cycle_count = cycle_count + 1;
				end
				
				if (cycle_count == 270) begin
				   current_char = 8'h00;
				end
				
       end
  end

  assign ascii_output = current_char;

endmodule


