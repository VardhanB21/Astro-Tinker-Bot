module reset_generator (
    input clk,          // Clock input
    input trigger_input, // Additional input signal to trigger reset generation
    output reset1    // Reset output
);

integer counter=0;
reg reset;

parameter CYCLE_THRESHOLD = 2000570;

always @(posedge clk) begin
    if (trigger_input && counter == CYCLE_THRESHOLD) begin
        reset <= 1;
        counter <= 0;
    end else begin
        reset <= 0;
        counter <= counter + 1;
    end
end

assign reset1=reset;

endmodule
