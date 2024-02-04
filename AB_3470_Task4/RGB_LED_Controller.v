module RGB_LED_Controller (
    input clk,
    input rst,
    input [1:0] color_select,
    output  red_output1,
    output  green_output1,
    output  blue_output1,
    output  red_output2,
    output  green_output2,
    output  blue_output2,
    output  red_output3,
    output  green_output3,
    output  blue_output3
);

parameter OFF = 2'b00;
parameter RED = 2'b01;
parameter GREEN = 2'b10;
parameter BLUE = 2'b11;

reg [1:0] state;
reg red_internal, green_internal, blue_internal;

initial begin
  red_internal=1; 
  green_internal=0;
  blue_internal=0;
  state = 2'b01;
end

always @(posedge clk or posedge !rst) begin
    if (!rst) begin
        state <= OFF;
        red_internal <= 1'b0;
        green_internal <= 1'b0;
        blue_internal <= 1'b0;
    end else begin
        state <= color_select;

        // Update individual color outputs based on state
        if (state == RED) begin
            red_internal <= 1'b1;
            green_internal <= 1'b0;
            blue_internal <= 1'b0;
        end else if (state == GREEN) begin
            red_internal <= 1'b0;
            green_internal <= 1'b1;
            blue_internal <= 1'b0;
        end else if (state == BLUE) begin
            red_internal <= 1'b0;
            green_internal <= 1'b0;
            blue_internal <= 1'b1;
        end else if (state == OFF) begin
            red_internal <= 1'b0;
            green_internal <= 1'b0;
            blue_internal <= 1'b0;
        end else begin
            // Default to selecting red
            red_internal <= 1'b1;
            green_internal <= 1'b0;
            blue_internal <= 1'b0;
        end
    end
end

assign red_output1 = red_internal;
assign green_output1 = green_internal;
assign blue_output1 = blue_internal;

assign red_output2 = red_internal;
assign green_output2 = green_internal;
assign blue_output2 = blue_internal;

assign red_output3 = red_internal;
assign green_output3 = green_internal;
assign blue_output3 = blue_internal;

endmodule
