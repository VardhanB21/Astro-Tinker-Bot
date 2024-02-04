module LineF (
  input clk,
  input rst,
  input enable_motor_ctrl, // New input signal for controlling motor_enabled
  input [11:0] left_sensor,
  input [11:0] center_sensor,
  input [11:0] right_sensor,
  input out,
  output [5:0] left_motor,
  output [5:0] right_motor,
  output left_motor_2,
  output right_motor_2,
  output [1:0] color_select,
  output exttrigger,
  output reg [7:0] data_out0,
  output reg [7:0] data_out1,
  output reg [7:0] data_out2,
  output reg [7:0] data_out3,
  output reg [7:0] data_out4,
  output reg [7:0] data_out5,
  output reg [7:0] data_out6,
  output reg [7:0] data_out7,
  output reg [7:0] data_out8,
  output reg [7:0] data_out9,
  output reg obstacle2, // Control signal for choosing 'E' or 'C'
  output reg [4:0] stop_counter, // 5-bit counter for counting STOP state occurrences
  output reg motor_enabled // Control signal for enabling/disabling motors
);

  // Define states using parameters
  parameter IDLE = 3'b000;
  parameter STOP = 3'b001;
  parameter MOVE_FORWARD = 3'b010;
  parameter MOVE_LEFT = 3'b011;
  parameter MOVE_RIGHT = 3'b100;
  parameter OUT1 = 3'b101;
  

  // Local variables
  reg [5:0] temp_left_motor, temp_right_motor;
  reg exttrigger1;
  reg [1:0] color_select1;
  reg [2:0] state, next_state;
  reg [14:0] counter;
  reg check_node;
  reg [22:0] led_blink;
  
  // Parameter definitions
  parameter OFF = 2'b00;
  parameter RED = 2'b01;
  parameter GREEN = 2'b10;
  parameter BLUE = 2'b11;

  // Initializations
  initial begin
    exttrigger1 = 1;
    state = IDLE;
    temp_left_motor = 6'b0;
    temp_right_motor = 6'b0;
    obstacle2 = 0; // Initially set to 0
    stop_counter = 0; // Initialize counter
    counter = 0;
    motor_enabled = 0; // Initially set to 0 (motors at rest)
	 color_select1 = RED;
	 data_out0 = 8'h00;
	 data_out1 = 8'h00;
	 data_out2 = 8'h00;
	 data_out3 = 8'h00;
	 data_out4 = 8'h00;
	 data_out5 = 8'h00;
	 data_out6 = 8'h00;
	 data_out7 = 8'h00;
	 data_out8 = 8'h00;
	 data_out9 = 8'h00;
	 check_node=1;
	 led_blink=0;
  end

  // Finite State Machine
  always @(posedge clk or posedge !rst) begin
    if (!rst) begin    
      state <= IDLE;
      temp_left_motor <= 6'b0;
      temp_right_motor <= 6'b0;
    end else begin
      // State transition logic only when motor_enabled is high
      if (motor_enabled) begin
        case (state)
          IDLE: begin
            if (center_sensor > 500 && left_sensor > 500 && right_sensor > 500) begin
               state = STOP;
            end else if(out) begin
				   state = OUT1;
				end else if (center_sensor > left_sensor && center_sensor > right_sensor) begin
               state = MOVE_FORWARD;
            end else if (left_sensor > right_sensor) begin
               state = MOVE_LEFT;
            end else if (right_sensor > left_sensor) begin
               state = MOVE_RIGHT;  // Assuming a right turn, change if needed
            end else begin
               state = IDLE;
            end
				
				if (right_sensor < 200 && left_sensor <200 && !check_node) check_node=1;
				
			 end
				
          STOP: begin

            if(check_node)begin
				  check_node=0;
				  stop_counter = stop_counter + 1;
				end

            if (stop_counter == 5'b01100) begin
				    temp_left_motor <= 6'b0;
					 temp_right_motor <= 6'b0;
					 if(led_blink==23'b01000000000000000000000)begin
					    led_blink=0;
					    if(color_select1==GREEN)begin
						   color_select1=OFF;
						 end else begin 
						 color_select1=GREEN; 
						 end
					 end else begin
					    led_blink=led_blink+1;
					 end
				end else begin
              if ((left_sensor > center_sensor || (center_sensor > 500 && left_sensor > 500)) && stop_counter != 5'b00110) begin
              temp_left_motor <= 6'b0;
              temp_right_motor <= 6'b111011;
              end else begin
				  if (stop_counter == 5'b00110) begin
				    temp_left_motor <= 6'b111111;
                temp_right_motor <= 6'b111111;
				  end else begin
					  temp_left_motor <= 6'b011011;
					  temp_right_motor <= 6'b011011;
				  end
              

              // Increment counter for 10 cycles before transitioning to IDLE
              if (counter < 2000) begin
                counter <= counter + 1;
                end else begin
                counter <= 0;
					  // Reset to default values and transition to IDLE
                exttrigger1 = 1;
                color_select1 = RED;
                state = IDLE;
              end
				 end
			   end	 
			 end
          MOVE_FORWARD: begin
            // Define actions for MOVE_FORWARD state
            temp_left_motor <= 6'b01111;
            temp_right_motor <= 6'b011111;
            state = IDLE;
			 end
          MOVE_LEFT: begin
            // Define actions for MOVE_LEFT state
            temp_left_motor <= 6'b0;
            temp_right_motor <= 6'b100110;
            state = (left_sensor > right_sensor) ? MOVE_LEFT : IDLE;
			 end
		    MOVE_RIGHT: begin
            // Define actions for MOVE_LEFT state
            temp_left_motor <= 6'b100100;
            temp_right_motor <= 6'b0;
            state = (right_sensor > left_sensor) ? MOVE_RIGHT : IDLE;
			 end
			 OUT1: begin
					  exttrigger1 = 0;
					  color_select1 = BLUE;

					  // Assign ASCII values to individual data_out ports
					  data_out0 = 8'h46; // ASCII value of 'F'
					  data_out1 = 8'h49; // ASCII value of 'I'
					  data_out2 = 8'h4D; // ASCII value of 'M'
					  data_out3 = 8'h2D; // ASCII value of '-'
					  data_out5 = 8'h53; // ASCII value of 'S'
					  data_out6 = 8'h55; // ASCII value of 'U'
					  data_out8 = 8'h2D; // ASCII value of '-'
					  data_out9 = 8'h23; // ASCII value of '#'

//					  // Use 'E' if obstacle2 is 1, else use 'C' for data_out4
//					  data_out4 = (obstacle2) ? 8'h45 : 8'h43;
//
//					  // Use '3' if obstacle2 is 1, else use '1' for data_out7
//					  data_out7 = (obstacle2) ? 8'h33 : 8'h31;
//					  
//					  obstacle2 = ~obstacle2;
                 if(data_out4==8'h43) begin
					    data_out4=8'h45;
						 data_out7=8'h33;
					   end else  begin
					    data_out4=8'h43;
						 data_out7=8'h31;
					   end
					  state = IDLE;
					  
			 end
          default:
            // Default actions
            state = IDLE;
        endcase
      end
    end
  end
 
  

  // Input signal for controlling motor_enabled
  always @(posedge clk or posedge !rst) begin
    if (!rst) begin
      // Initial setup
      motor_enabled <= 0;
    end else if (!enable_motor_ctrl) begin
      // Toggle motor_enabled on positive edge of enable_motor_ctrl
      motor_enabled <= 1;
    end
  end


  // Assign temporary values to outputs
  assign left_motor = temp_left_motor;
  assign right_motor = temp_right_motor;
  assign exttrigger = exttrigger1;
  assign color_select=color_select1;
  
  // Negative terminals set to low
  assign left_motor_2 = 1'b0;
  assign right_motor_2 = 1'b0;

endmodule