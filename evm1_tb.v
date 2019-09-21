`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   15:41:13 04/16/2019
// Design Name:   evm1
// Module Name:   F:/LECTURES/SEMESTER 2/dd_project/evm1_tb.v
// Project Name:  dd_project
// Target Device: 
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: evm1
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module evm1_tb;

	// Inputs
	reg clk;
	reg [2:0] voter_switch;
	reg voting_en;
	reg gender_in_male;
	reg gender_in_female;

	// Outputs
	wire opled1, opled2, opled3;
	wire invalid;
	wire [6:0] dout;
	wire [7:0] party1, party2, party3,gender_out_male,gender_out_female;
	wire [7:0] voting_percentage;
	wire [6:0] one_twenty_seven;

	// Instantiate the Unit Under Test (UUT)
	electronic_voting_machine uut (
		.clk(clk), 
		.voter_switch(voter_switch),  
		.gender_in_male(gender_in_male),
		.gender_in_female(gender_in_female),
		.voting_en(voting_en), 
		.opled1(opled1),
		.opled2(opled2),
		.opled3(opled3),		
		.invalid(invalid), 
		.dout(dout),
		.party1(party1),
		.party2(party2),
		.party3(party3),
		.gender_out_male(gender_out_male),
		.gender_out_female(gender_out_female),
		.voting_percentage(voting_percentage),
		.one_twenty_seven(one_twenty_seven)
	);

	initial begin

		// Initialize Inputs
		clk = 0;
		voter_switch = 0;
		voting_en = 0;
		gender_in_male = 1;
		gender_in_female = 0;

		// Wait 100 ns for global reset to finish
		#100;
		//clk = 1;
		voter_switch = 3'b001;
		voting_en = 1;
		
		#100;
		voting_en=0;
		//clk = 0;
		
		
		
		#100;
		voting_en = 1;
		//clk=1;
		voter_switch = 3'b010;
		gender_in_male= 0;
		gender_in_female = 1;
		#100;
		voter_switch = 3'b000;
		
		#100;
		voter_switch = 3'b010;
		
		//#100;
		//voter_switch = 3'b001;
		// Add stimulus here

	end
      always #10 clk = ~clk;
endmodule