// AstroTinker Bot : Task 1C : Pulse Generator and Detector
/*
Instructions
-------------------
Students are not allowed to make any changes in the Module declaration.

This file is used to design a module which will generate a 10us pulse and detect incoming pulse signal.

Recommended Quartus Version : 20.1
The submitted project file must be 20.1 compatible as the evaluation will be done on Quartus Prime Lite 20.1.

Warning: The error due to compatibility will not be entertained.
-------------------
*/

// t1c_pulse_gen_detect
//Inputs : clk_50M, reset, echo_rx
//Output : trigger, distance, pulses, state

// module declaration
module t1c_pulse_gen_detect (
    input clk_50M, reset, echo_rx,
    output reg trigger, out,
    output reg [21:0] pulses,
    output reg [1:0] state
);

integer counter=0;

parameter ST_warm=2'b00, ST_trigger=2'b01, ST_pulse=2'b10, ST_output=2'b11;

initial begin
    trigger = 0; out = 0; pulses = 0; state = ST_warm;
end


//////////////////DO NOT MAKE ANY CHANGES ABOVE THIS LINE//////////////////

 always @(posedge clk_50M) begin
   if(reset) begin
	out=0;
	state=ST_warm;
	counter=0;
	pulses=0;
	end
	
	else begin
			case(state)
				ST_warm:begin
				  if(counter==49) state=ST_trigger;
				end
				ST_trigger:begin
					trigger=1;
					if(counter==549) state = ST_pulse; 
				end
				ST_pulse: begin
				  trigger=0;
				  if(echo_rx) pulses=pulses+22'b0000000000000000000001;
				  if(counter==50549) state = ST_output;
				end
				ST_output: begin
							if(pulses==29410) out=1;
							state = ST_warm;
				end
				 
				 
				 default: state = ST_warm;
			endcase
			
			
			counter=counter+1;
				if (counter==50551) begin
				counter=0;
				pulses=0;
				end
		end
 end

/*
Add your logic here
*/

//////////////////DO NOT MAKE ANY CHANGES BELOW THIS LINE//////////////////

endmodule
