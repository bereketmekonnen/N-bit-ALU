library IEEE;	  
library mydesign;
use mydesign.all;
use IEEE.STD_LOGIC_1164.all;

entity NBitMultiplier is  
	generic( N     :     integer);
    Port ( A  , B  : in  STD_LOGIC_VECTOR(N-1 downto 0);  -- A and B as inputs to n bit adder 
	Overflow,Negative,Zero       : out std_logic;	 
	Answer         : out STD_LOGIC_VECTOR(N-1 downto 0)
	);    
end NBitMultiplier;	  
	

architecture Structural of NBitMultiplier is

-- Compoments Needed 
component NBitAdder 
	generic ( N : integer); 
	Port ( A  , B  : in  STD_LOGIC_VECTOR(N-1 downto 0);   -- XOR gate input
	Overflow,Negative,Zero      : out std_logic;
	Answer         : out STD_LOGIC_VECTOR(N-1 downto 0);
	CarryOut       : out std_logic
	);	
end component;	  

component AndGate 
    Port ( IN1 : in  STD_LOGIC;    -- AND gate input
           IN2 : in  STD_LOGIC;    -- AND gate input
           O   : out STD_LOGIC);    -- AND gate output	 
end component;	 

component XnorGate 
	    Port ( IN1 : in  STD_LOGIC;    -- XOR gate input
           IN2 : in  STD_LOGIC;    -- XOR gate input
           O   : out STD_LOGIC);    -- XOR gate output	
end component; 




-- Types
subtype subbits is std_logic_vector(N-1 downto 0);	
type NsubBits is array(N-1 downto 0) of subbits; 
-- Signals   
--signal Total : std_logic_vector((2*N)-1 downto 0);	
signal ANDtmp, tmp,Sumtmp : NsubBits;  	 
signal Cout,Cin,Ovtest, tmpanswer : std_logic_vector(N-1 downto 0); 
signal zerotest : std_logic_vector(N-1  downto 0):= (others => '0'); 
signal onestest : std_logic_vector(N-1  downto 0):= (others => '1');

begin	
	
-- And of A with B(I) 	
	BANDA   : for I in 0 to N-1 generate  -- NsubBits	
		BIANDA	: for J in 0 to N-1 generate  -- SubBits
			U0: AndGate port map(B(I),A(J), ANDtmp(I)(J));
		end generate BIANDA;
	end generate BANDA;	  
tmp(0) <= '0'&ANDtmp(0)(N-1 downto 1);	


Answer(0)<=ANDtmp(0)(0); 
tmpanswer(0) <= ANDtmp(0)(0);
Sumtmp(0) <= ANDtmp(0);

Cout(0) <= '0';
Adder2to14: for I in 1 to N-1 generate 
	Cin(I) <= Cout(I-1);
	tmp(I) <= Cin(I)&Sumtmp(I-1)(N-1 downto 1);	 
	U2to14:  NBitAdder generic map( N => N) port map(ANDtmp(I),tmp(I),open,open,open,		Sumtmp(I),   Cout(I)); 
	Answer(I)<= Sumtmp(I)(0); 
	tmpanswer(I)<= Sumtmp(I)(0);
end generate Adder2to14;   


--- Zero Test  
Zero<= '1' when tmpanswer = zerotest else '0';




-- Over Flow Test 

Overflow <= '0' when  tmp(N-1) = onestest or tmp(N-1) = zerotest else '1';


	

-- Negativge Test
Negative <= '1' when Sumtmp(N-1)(0) = '1' else '0';	-- done 
  








end Structural;