library IEEE;	 
library mydesign;
use mydesign.all;
use IEEE.STD_LOGIC_1164.all;

entity GateTest is
    Port ( IN1 : in  STD_LOGIC;    -- XOR gate input
           IN2 : in  STD_LOGIC;    -- XOR gate input
           O   : out STD_LOGIC_VECTOR(2 downto 0));    -- XOR gate output	
		   
end GateTest;

architecture Structural of GateTest is		 
--
	component AndGate  
		Port (   IN1 : in  STD_LOGIC;    -- AND gate input
          		 IN2 : in  STD_LOGIC;    -- AND gate input
          		 O   : out STD_LOGIC);    -- AND gate output
	end component;	  	
	
	component XorGate  
		Port (   IN1 : in  STD_LOGIC;    -- Xor gate input
          		 IN2 : in  STD_LOGIC;    -- Xor gate input
          		 O   : out STD_LOGIC);   -- Xor gate output
	end component;	  
	
	component NotGate  
		Port (   IN1 : in  STD_LOGIC;    -- Not gate input
          		 O   : out STD_LOGIC);    -- Not gate output
	end component;	  
--	
begin 

	
--	 Need to test xnor gate, or gate, and nbitnandgate  
Test0: AndGate port map(IN1,IN2,O(0));
Test1: XorGate port map(IN1,IN2,O(1));
Test2: NotGate port map(IN1,O(2));
	

	

end Structural;