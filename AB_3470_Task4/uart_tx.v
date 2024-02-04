module uart_tx(
    input  clk_3125k,
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


 always @(posedge clk_3125k) begin
 	 
	 if(!data) begin
	    tx=1;
		 counter<=0;
		 state=ST_start;
	 end
	 
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
	 
	 counter<=counter+1;
	 if(counter==27) counter<=0;
end


endmodule