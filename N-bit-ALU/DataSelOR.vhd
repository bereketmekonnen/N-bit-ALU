library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity DataSelOR is 
	generic( datawidth : integer);
    Port ( 	IN1              : in STD_LOGIC_VECTOR(datawidth-1 downto 0);  -- Data one 
			IN2              : in STD_LOGIC_VECTOR(datawidth-1 downto 0);   -- Data two
			inflag1,inflag2 : in STD_LOGIC_VECTOR(2 downto 0); -- flag input 
		    outflag          : out STD_LOGIC_VECTOR(2 downto 0); -- flag output
            O                : out STD_LOGIC_VECTOR(datawidth-1 downto 0));  -- Output
end DataSelOR;

architecture Structural of DataSelOR is	 
signal tmp : std_logic_vector(datawidth-1 downto 0);   
begin  
tmp <= (others => 'Z');	 

O <= IN1 when IN2 = tmp else IN2 when IN1 = tmp else tmp when (IN2 = tmp and IN1 = tmp);

outflag <= inflag1 when IN2 = tmp else inflag2 when IN1 = tmp else (others=>'Z') when IN2 = tmp and IN1 = tmp ;

	   
end Structural;