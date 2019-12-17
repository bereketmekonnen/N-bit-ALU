library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity NBitNand is 
	generic( N : in integer);
    Port ( IN1 : in  STD_LOGIC_VECTOR(N-1 downto 0);    -- AND gate input
           O   : out STD_LOGIC);    -- AND gate output
end NBitNand;

architecture Structural of NBitNand is	 
signal tmp : std_logic_vector(N-1 downto 0);   
begin  
tmp <= (others => '1');

O <= '0' when IN1 = tmp else '1';
	   
end Structural;