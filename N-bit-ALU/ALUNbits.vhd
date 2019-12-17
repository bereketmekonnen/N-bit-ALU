library IEEE;
library work;
use IEEE.STD_LOGIC_1164.all;  
use work.TypesPackage.all; 
use IEEE.math_real.all;	


entity ALUNbits is
	generic (datawidth, N : integer  );  -- N = number of Data Lines and Datawidth = data width 	  (change in package manually )
	port(A,B     : in std_logic_vector(datawidth-1 downto 0);    --  N data lines each with datawidth size  (could not make it generic need generic packages	 ) 
		 SelectLines      : in std_logic_vector(integer(ceil(log2(real(N))))-1 downto 0);	-- Number of selec lines
	     Output   : out std_logic_vector(datawidth-1 downto 0);  -- selected output
         Zero,Overflow,Negative   : out STD_LOGIC;
		 Answer   : out std_logic_vector(datawidth-1 downto 0));    -- AND gate output	  
		 
end ALUNbits;

architecture Structural of ALUNbits is	
-- Mux needed	 
component MUX8 	  
	generic (datawidth,N : integer  );  -- N = number of Data Lines and Datawidth = data width 	  (change in package manually )
	port(Data     : in Datasel;    --  N data lines each with datawidth size  (could not make it generic need generic packages	 ) 
		 Sel      : in std_logic_vector(integer(ceil(log2(real(N))))-1 downto 0);	-- Number of selec lines
		 inflags  : in flags; 	
		 outflag  : out std_logic_vector(2 downto 0);
	     Output   : out std_logic_vector(datawidth-1 downto 0));  -- selected output	   
	
end component; 	 

component NbitAdder
		generic( N     :     integer);
    Port ( A  , B  : in  STD_LOGIC_VECTOR(N-1 downto 0);  -- A and B as inputs to n bit adder 
	Overflow,Negative,Zero       : out std_logic;
	Answer         : out STD_LOGIC_VECTOR(N-1 downto 0);
	CarryOut           : out std_logic
	);  
	
end component;	

component Nbitsubstractor
	generic( N     :     integer);
    Port ( A  , B  : in  STD_LOGIC_VECTOR(N-1 downto 0);  -- A and B as inputs to n bit adder 
	Overflow,Negative,Zero       : out std_logic;
	Answer         : out STD_LOGIC_VECTOR(N-1 downto 0)
	
	);  
	
end component;


component NbitMultiplier
	generic( N     :     integer);
    Port ( A  , B  : in  STD_LOGIC_VECTOR(N-1 downto 0);  -- A and B as inputs to n bit adder 
	Overflow,Zero,Negative       : out std_logic;	 
	Answer         : out STD_LOGIC_VECTOR(N-1 downto 0)
	);    
end component;


signal Data : Datasel;  
signal inputflag:flags;	 
signal tmp : std_logic_vector(2 downto 0);
begin  

  
	
Add: NbitAdder	     generic map(N => datawidth) port map( A,B, inputflag(0)(0),inputflag(0)(1),inputflag(0)(2),Data(0),open); --0
Sub: NBitSubstractor generic map(N => datawidth) port map( A,B, inputflag(1)(0),inputflag(1)(1),inputflag(1)(2),Data(1));	   --1
Mult:NbitMultiplier	 generic map(N => datawidth) port map( A,B, inputflag(4)(0),inputflag(4)(1),inputflag(4)(2),Data(4));	   --4
-- A = 2   B = 3 , open = 5 and 6 and 7		
Data(2)<= A; 
Data(3)<=B;
Data(5)<= (Others =>'Z'); 
Data(6)<= (Others =>'Z');
Data(7)<= (Others =>'Z');





ALUNbit: Mux8 generic map ( datawidth => datawidth , N => N)  port map(Data,SelectLines,inputflag,tmp,Answer); 
Overflow <= tmp(2);
Zero <= tmp(1);
Negative <= tmp(0);
Output<= (others => '0');

	   
end Structural;