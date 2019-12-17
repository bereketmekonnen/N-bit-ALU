library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity NotGate is
    Port ( IN1 : in  STD_LOGIC;    -- Not Gate input
           O   : out STD_LOGIC);   -- Not Gate output
end NotGate;

architecture Structural of NotGate is
begin 
	
process(IN1)
begin
   if    IN1 = '1' then O <= transport '0' after 10 ns;		 
   elsif IN1 = '0' then O <= transport '1' after 10 ns;
   else  O <= transport 'U' after 10ns;  
   end if;
	   
end process;
	   
end Structural;