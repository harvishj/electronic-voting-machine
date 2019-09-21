`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:50:42 04/06/2019 
// Design Name: 
// Module Name:    evm 
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
module evm(clk,voter_switch,PB,voting_en,opled,invalid,dout);
 
input voting_en,PB,clk;//voting process will start when vote_en is on
input [2:0]voter_switch;
output [6:0]dout;//Max no. of votes = 127
output reg [2:0]opled;//opled[0]=party1 led, opled[1]=party2 led, opled[2]=party3 led
output reg invalid;//invalid vote indicator led
 
//counters to count each party votes
reg [6:0]cnt_reg1=0;//party1
reg [6:0]cnt_nxt1=0;//party1
reg [6:0]cnt_reg2=0;//party2
reg [6:0]cnt_nxt2=0;//party2
reg [6:0]cnt_reg3=0;//party3
reg [6:0]cnt_nxt3=0;//party3
 
reg PB_reg1;  
reg PB_reg2;  
reg [15:0] PB_cnt;
reg PB_state;
 /*
//debounce circuit to detect only one rising edge of push button //PB(Refer http://www.fpga4fun.com/Debouncer2.html for more //information on debounce circuit)
always @(posedge clk)
PB_reg1 <= PB; 
always @(posedge clk)
PB_reg2 <= PB_reg1;
 
wire PB_idle = (PB_state==PB_reg2);
wire PB_cnt_max = &PB_cnt; // true when all bits of PB_cnt are 1's
 
always @(posedge clk)
  if(PB_idle)
    PB_cnt <= 0;  // idle state i.e. PB_cnt will not increment 
else
begin
    PB_cnt <= PB_cnt + 16'd1;
    if(PB_cnt_max) 
  PB_state <= ~PB_state;  // if the counter is maximum, PB changes
end
assign PB = ~PB_idle & PB_cnt_max & ~PB_state;*/
 
//counter for party1 votes
always@(posedge PB)
 if(voter_switch == 3'b001 && voting_en == 1'b1)
 begin
 cnt_reg1 <= cnt_nxt1;
 end
always@(*)
 begin
 cnt_nxt1 = cnt_reg1 + 1;
 end
 
//Counter for party2 votes
always@(posedge PB)
 if(voter_switch == 3'b010 && voting_en == 1'b1)
 begin
 cnt_reg2 <= cnt_nxt2;
 end
always@(*)
 begin
 cnt_nxt2 = cnt_reg2 + 1;
 end
 
//Counter for party3 votes
always@(posedge PB)
 if(voter_switch == 3'b100 && voting_en == 1'b1)
 begin
 cnt_reg3 <= cnt_nxt3;
 end
always@(*)
 begin
 cnt_nxt3 = cnt_reg3 + 1;
 end
 
//Final count i.e. total number of votes
assign dout = cnt_reg1 + cnt_reg2 + cnt_reg3;
//relation of "voter_switch" with "opled" & "invalid"
always@(*)
if(voting_en)  
 case(voter_switch)
  3'b100 : begin
     opled = 3'b100;
     invalid = 1'b0;
     end
  3'b010 : begin
     opled = 3'b010;
     invalid = 1'b0;
     end
  3'b001 : begin
     opled = 3'b001; 
     invalid = 1'b0;
     end
  3'b011 : begin
     opled = 3'b000;
     invalid = 1'b1;
     end
  3'b110 : begin
     opled = 3'b000;
     invalid = 1'b1;
     end
  3'b101 : begin
     opled = 3'b000;
     invalid = 1'b1;
     end
  3'b111 : begin
     opled = 3'b000;
     invalid = 1'b1;
     end
  3'b000 : begin
     opled = 3'b000;
     invalid = 1'b0;
     end
  default : begin
      opled = 3'b000;
      invalid = 1'b0;
      end
 endcase
endmodule
