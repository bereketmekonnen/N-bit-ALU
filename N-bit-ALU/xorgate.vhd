library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity XorGate is
    Port ( IN1 : in  STD_LOGIC;    -- XOR gate input
           IN2 : in  STD_LOGIC;    -- XOR gate input
           O   : out STD_LOGIC);    -- XOR gate output
end XorGate;

architecture Structural of XorGate is
begin 
	
process(IN1,IN2)
begin
   if IN1 = '1' and IN2 = '1'  then O <= transport '0' after 10 ns;		 
   elsif IN1 = '1' and IN2 = '0'  then O <= transport '1' after 10 ns;
   elsif IN1 = '0' and IN2 = '1'  then O <= transport '1' after 10 ns;	
   elsif IN1 = '0' and IN2 = '0'  then O <= transport '0' after 10 ns;	
   else O <= transport '0' after 10ns; 
	   
	   end if;
	   
end process;
	   
end Structural;