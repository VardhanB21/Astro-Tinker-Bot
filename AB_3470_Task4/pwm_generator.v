module pwm_generator(
    input clk_3125KHz,
    input [5:0] duty_cycle,
    output reg pwm_signal
);

initial begin
     pwm_signal = 1;
end

reg [5:0] counter=0;
always @(posedge clk_3125KHz) begin
  if(!counter) pwm_signal= 1;
  if(counter>=duty_cycle) pwm_signal=0;
    counter=counter+1 ;
end	

endmodule