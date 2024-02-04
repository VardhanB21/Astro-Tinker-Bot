// AstroTinker Bot : Task 2A : UART Receiver
/*
Instructions
-------------------
Students are not allowed to make any changes in the Module declaration.

This file is used to receive UART Rx data packet from receiver line and then update the rx_msg and rx_complete data lines.

Recommended Quartus Version : 20.1
The submitted project file must be 20.1 compatible as the evaluation will be done on Quartus Prime Lite 20.1.

Warning: The error due to compatibility will not be entertained.
-------------------
*/

/*
Module UART Receiver

Input:  clk_50M - 50 MHz clock
        rx      - UART Receiver

Output: rx_msg      - read incoming message
        rx_complete - message received flag
*/

// module declaration
module uart_rx (
  input clk_50M, rx,
  output reg [7:0] rx_msg,
  output reg rx_complete
);

//////////////////DO NOT MAKE ANY CHANGES ABOVE THIS LINE//////////////////

////////////////////////// Add your code here


initial begin

rx_msg = 0; rx_complete = 0;

end

integer counter3=0;
integer counter2=7;
reg [2:0] counter1=0;
reg msgreceive=0;
reg [7:0] rx_msg1=0;

parameter ST_start=2'b00, ST_data=2'b01, ST_end=2'b10;

reg [1:0] state=ST_end;


 always @(posedge clk_50M) begin
 
    if(!counter3 && !msgreceive && !rx) begin
	    state=ST_start;
		 msgreceive=1;
		 rx_msg=rx_msg1;
		 if(rx_msg) rx_complete=1;
	 end
	 
    if(!counter3) begin
	 
    case (state)
            ST_start: begin
                state = ST_data; 	 
            end
            ST_data: begin
				    rx_msg1[counter2]=rx;
					 counter1=counter1+3'b001;
					 counter2=counter2-1;
                if(!counter1) begin
					 state = ST_end;
					 counter2=7;
					 end
            end
            ST_end: begin
                msgreceive=0;
            end
          
            default: state = ST_start;
    endcase
	 end
	 
	 if(counter3==1 && state==ST_data) rx_complete=0;
	 counter3=counter3+1;
	 if(counter3==434) counter3=0;
	
	 
end

//////////////////DO NOT MAKE ANY CHANGES BELOW THIS LINE//////////////////

endmodule