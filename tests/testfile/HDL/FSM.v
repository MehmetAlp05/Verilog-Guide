// Quartus Prime Verilog Template
// User-encoded state machine

module FSM
(
	input	clk, in, reset,
	input left, right, attack,
	output reg move_flag, direction, attack_flag
);

	// Declare state register
	reg [2:0] state;

	// Declare states
	parameter S_IDLE = 0, S_Right = 2, S_Left = 1, S_Attack_start = 3, S_Attack_active=4;

	// Output depends only on the state
	always @ (*) begin
		move_flag =((state===2)||(state===1));
		direction =((move_flag&&attack));
		attack_flag =((state===3)||(state===4));
			
	end

	// Determine the next state
	always @ (posedge clk or posedge reset) begin
		if (reset)
			state <= S_IDLE;
		else				
			case (state)
				S_IDLE:
					if (left&~right&~attack)begin
						state <= S_Left;
					end else if (right)begin
						state <= S_Right;
					end else if (attack)begin
						state <= S_Attack_start;
					end else
						state <= S_IDLE;
				S_Right:
					if (left)begin
						state <= S_Left;
					end else if (right)begin
						state <= S_Right;
					end else if (attack)begin
						state <= S_Attack_start;
					end else
						state <= S_IDLE;
				S_Left:
					if (left)begin
						state <= S_Left;
					end else if (right)begin
						state <= S_Right;
					end else if (attack)begin
						state <= S_Attack_start;
					end else
						state <= S_IDLE;
					
				S_Attack_start:
					state <= S_Attack_active;
				S_Attack_active:
					state <= S_IDLE;
			endcase
			
	end

endmodule
