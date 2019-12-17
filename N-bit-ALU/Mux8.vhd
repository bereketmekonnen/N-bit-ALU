library ieee;  
library work;
use work.TypesPackage.all;
use ieee.std_logic_1164.all;
use IEEE.math_real.all;	 


entity Mux8 is 	  
	
	generic (datawidth,N : integer  );  -- N = number of Data Lines and Datawidth = data width 	  (change in package manually )
	port(Data     : in Datasel;    --  N data lines each with datawidth size  (could not make it generic need generic packages	 ) 
		 Sel      : in std_logic_vector(integer(ceil(log2(real(N))))-1 downto 0);	-- Number of selec lines
		 inflags  : in flags; 	
		 outflag  : out std_logic_vector(2 downto 0);
	     Output   : out std_logic_vector(datawidth-1 downto 0));  -- selected output	 
end Mux8;  

architecture Structural of Mux8 is
  
	component DataSelAND 
	generic( datawidth, N : in integer);	   -- N = number of selec lines , datawidth = number of bits for data 
    Port ( IN1    : in  STD_LOGIC_VECTOR(N-1 downto 0); -- number of inputs to and gate without data line
		   IN2    : in  STD_LOGIC_VECTOR(datawidth-1 downto 0);-- Data	
	       inflag : in STD_LOGIC_VECTOR(2 downto 0); -- flag input 
		   outflag: out STD_LOGIC_VECTOR(2 downto 0); -- flag output
           O      : out STD_LOGIC_VECTOR(datawidth-1 downto 0)); -- Output
	end component ;		
	
	component DataSelOR  
	generic( datawidth : integer);
    Port ( 	IN1              : in STD_LOGIC_VECTOR(datawidth-1 downto 0);  -- Data one 
			IN2              : in STD_LOGIC_VECTOR(datawidth-1 downto 0);   -- Data two
			inflag1,inflag2 : in STD_LOGIC_VECTOR(2 downto 0); -- flag input 
		    outflag          : out STD_LOGIC_VECTOR(2 downto 0); -- flag output
            O                : out STD_LOGIC_VECTOR(datawidth-1 downto 0));  -- Output
	end component;		 
	
	signal Datatmp : DataSel;	
	signal flagstmp : flags;	
	signal tmpsel : flags;	 
begin		 
tmpsel(0) <= not Sel(2)&not Sel(1)&not Sel(0);
tmpsel(1) <= not Sel(2)&not Sel(1)& Sel(0);
tmpsel(2) <= not Sel(2)& Sel(1)&not Sel(0);
tmpsel(3) <= not Sel(2)& Sel(1)& Sel(0);
tmpsel(4) <=  Sel(2)& not Sel(1)& not Sel(0);
tmpsel(5) <=  Sel(2)&not Sel(1)& Sel(0);
tmpsel(6) <=  Sel(2)& Sel(1)& not Sel(0);
tmpsel(7) <=  Sel(2)& Sel(1)& Sel(0);	




	
DataSelAND0toN:for I in 0 to N-1 generate 
	U0: DataSelAND generic map(datawidth => datawidth, N => integer(ceil(log2(real(N))))) port map(tmpsel(I), Data(I),inflags(I),flagstmp(I),Datatmp(I));
end generate DataSelAND0toN;	 

DataSelORNto1: for J in 1 to N-1 generate
	U1: DataSelOR generic map (datawidth => datawidth) port map (Datatmp(J), Datatmp(J-1),flagstmp(J),flagstmp(J-1),flagstmp(J),Datatmp(J)); 
end generate DataSelORNto1;	  

Output <= Datatmp(N-1);
outflag <= flagstmp(N-1);
	
	
end Structural;
