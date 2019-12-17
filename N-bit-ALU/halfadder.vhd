library IEEE;					  
library mydesign;
use mydesign.all;
use IEEE.STD_LOGIC_1164.all;  


entity HalfAdder is	

    Port ( A   , B      : in  std_logic;    -- XOR gate input
           Sum , Cout   : out std_logic);    -- XOR gate output
end HalfAdder;

architecture Structural of HalfAdder is		  

component xorgate 	 
	port(IN1,IN2 : in std_logic;
	O : out std_logic);	
end component;	 

component andgate 	 
	port(IN1,IN2 : in std_logic;
	O : out std_logic);	
	end component;
	
begin 	 

	
AND0: andgate port map ( A , B , Cout );
XOR0: xorgate port map ( A , B , Sum   );
	   
end Structural;