library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity DataSelAND is 
	generic( datawidth, N : in integer);	   -- N = number of selec lines , datawidth = number of bits for data 
    Port ( IN1    : in  STD_LOGIC_VECTOR(N-1 downto 0); -- number of inputs to and gate without data line
		   IN2    : in  STD_LOGIC_VECTOR(datawidth-1 downto 0);-- Data	
	       inflag : in STD_LOGIC_VECTOR(2 downto 0); -- flag input 
		   outflag: out STD_LOGIC_VECTOR(2 downto 0); -- flag output
           O      : out STD_LOGIC_VECTOR(datawidth-1 downto 0)); -- Output
end DataSelAND;

architecture Structural of DataSelAND is	 
signal tmp : std_logic_vector(N-1 downto 0);   
signal otmp : std_logic;
begin  
	
tmp <= IN1;	
ANDTEST: for I in N-1 downto 1 generate
	tmp(I) <= tmp(I-1) and tmp(I); 
	
end generate ANDTEST;  
otmp<= tmp(N-1);   

ANDTEST: for J in datawidth-1 downto 1 generate
	otmp <= IN2(J) and otmp;
end generate ANDTEST;  


O <= IN2 when otmp = '1' else (others => 'Z');		  
outflag <= inflag when otmp = '1' else (others=>'Z') ;
	   
end Structural;