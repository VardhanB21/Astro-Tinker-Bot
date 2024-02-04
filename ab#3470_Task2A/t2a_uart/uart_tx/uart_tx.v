// AstroTinker Bot : Task 2A : UART Transmitter
/*
Instructions
-------------------
Students are not allowed to make any changes in the Module declaration.

This file is used to generate UART Tx data packet to transmit the messages based on the input data.

Recommended Quartus Version : 20.1
The submitted project file must be 20.1 compatible as the evaluation will be done on Quartus Prime Lite 20.1.

Warning: The error due to compatibility will not be entertained.
-------------------
*/

/*
Module UART Transmitter

Input:  clk_50M - 50 MHz clock
        data    - 8-bit data line to transmit
Output: tx      - UART Transmission Line
*/

// module declaration
module uart_tx(
    input  clk_50M,
    input  [7:0] data,
    output reg tx
);


integer counter=0;
integer counter2=0;
reg [2:0] counter1=0;
reg startreceive=0;

parameter ST_start=2'b00, ST_data=2'b01, ST_end=2'b10;

reg [1:0] state=ST_start;

initial begin
	 tx = 1;
end


 always @(posedge clk_50M) begin
 	 
	 if(!data) tx=1;
	 
    if(data && !counter) begin
	 
	 if(!startreceive) begin
	    state=ST_start;
		 startreceive=1;
	 end
	 
    case (state)
            ST_start: begin
				    tx=0;
                state = ST_data; 	 
            end
            ST_data: begin
				    tx=data[counter2];
					 counter1=counter1+3'b001;
					 counter2=counter2+1;
                if(!counter1) begin
					 state = ST_end;
					 counter2=0;
					 end
            end
            ST_end: begin
				    tx=1;
                startreceive=0;
            end
          
            default: state = ST_start;
    endcase
	 end
	 
	 counter=counter+1;
	 if(counter==434) counter=0;
end


endmodule