`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:45:05 04/06/2019 
// Design Name: 
// Module Name:    electronic_voting_machine 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module electronic_voting_machine(clk,voter_switch,gender_in_male,gender_in_female,voting_en,opled1, opled2, opled3,invalid,dout, party1, party2, party3,gender_out_male,gender_out_female,voting_percentage, one_twenty_seven);

input clk;
input voting_en;
input [2:0] voter_switch;
input gender_in_male, gender_in_female;

output reg opled1=0, opled2=0, opled3=0;
output reg invalid;
output [6:0] dout;
output reg [7:0] party1=0,party2=0,party3=0;
output reg [7:0] gender_out_male=0, gender_out_female=0;
output reg [6:0] one_twenty_seven; 
output [7:0] voting_percentage;

//parameter voting = 2'b01, non_voting = 2'b10;

reg state;
//wire temp;

always @ (posedge voting_en)
begin
state = 1;
invalid = 0;
end

always @ (*)
begin
if(voter_switch == 3'b001 && voting_en && voter_switch != 3'b100 && voter_switch != 3'b010 && state)
	begin
		party1 = party1 + 1;
		opled1=1;
		opled2=0;
		opled3=0;
		
		if(gender_in_male == 1)
			begin
				gender_out_male = gender_out_male + 1;
			end
		if(gender_in_female == 1)
			begin
				gender_out_female = gender_out_female + 1;
			end
		state=0;
	end
else if(voter_switch == 3'b010 && voting_en && voter_switch != 3'b100 && voter_switch != 3'b001 && state)
	begin
	
		party2 = party2 + 1;
		opled1=0;
		opled2=1;
		opled3=0;
		if(gender_in_male == 1)
			begin
				gender_out_male = gender_out_male + 1;
			end
		if(gender_in_female == 1)
			begin
				gender_out_female = gender_out_female + 1;
			end
			state = 0;
	end
else if(voter_switch == 3'b100 && voting_en && voter_switch != 3'b010 && voter_switch != 3'b001 && state)
	begin
		party3 = party3 + 1;
		opled1 = 0;
		opled2 = 0;
		opled3 = 1;

		if(gender_in_male == 1)
			begin
				gender_out_male = gender_out_male + 1;
			end
		if(gender_in_female == 1)
			begin
				gender_out_female = gender_out_female + 1;
			end
			state = 0;
	end
else
	begin
		invalid = 1;
		state = 0;
	end

end

assign one_twenty_seven = 127; 
//wire [6:0] fraction;
assign dout = party1 + party2 + party3;
division d1(dout, one_twenty_seven, voting_percetage);
//assign voting_percentage = fraction*100;

endmodule

/*
module debounce(input pb_1,clk,output pb_out);
wire slow_clk;
wire Q1,Q2,Q2_bar;
clock_div u1(clk,slow_clk);
my_dff d1(slow_clk, pb_1,Q1 );
my_dff d2(slow_clk, Q1,Q2 );
assign Q2_bar = ~Q2;
assign pb_out = Q1 & Q2_bar;
endmodule
// Slow clock for debouncing 
module clock_div(input Clk_100M, output reg slow_clk

    );
    reg [26:0]counter=0;
    always @(posedge Clk_100M)
    begin
        counter <= (counter>=249999)?0:counter+1;
        slow_clk <= (counter < 125000)?1'b0:1'b1;
    end
endmodule
// D-flip-flop for debouncing module 
module my_dff(input DFF_CLOCK, D, output reg Q);

    always @ (posedge DFF_CLOCK) begin
        Q <= D;
    end

endmodule
*/
