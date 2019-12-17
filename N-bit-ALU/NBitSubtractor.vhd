library IEEE;		
library mydesign;
use mydesign.all;
use IEEE.STD_LOGIC_1164.all;

entity NBitSubstractor is  
	generic( N     :     integer);
    Port ( A  , B  : in  STD_LOGIC_VECTOR(N-1 downto 0);  -- A and B as inputs to n bit adder 
	Overflow,Negative,Zero       : out std_logic;
	Answer         : out STD_LOGIC_VECTOR(N-1 downto 0)
	);    	 
	
end NBitSubstractor;

architecture Structural of NBitSubstractor is
-- Components Needed
component FullAdder 	 
	Port ( A  , B , CarryIn : in  STD_LOGIC;   -- XOR gate input
	      Sum , CarryOut    : out STD_LOGIC
	);	
end component;	  

component XorGate
	port (IN1, IN2 : in std_logic;
		  O      : out std_logic);	
end component;	 

component OrGate
	port (IN1, IN2 : in std_logic;
		  O      : out std_logic);	
end component;

component AndGate
	port (IN1, IN2 : in std_logic;
		  O      : out std_logic);	
end component; 

component NotGate
		port (IN1 : in std_logic;
		  O      : out std_logic);	
end component;


signal Cout, Cin : std_logic_vector(N-1 downto 0);
signal Temp :std_logic_vector(N-1 downto 0);   
signal SubTmp,Zerotmp : std_logic_vector(N-1 downto 0);	  
signal ovtmp : std_logic;


begin 	 
Cin(0) <= '1';			 
SubBit0: XorGate port map('1',B(0),Temp(0));
--BitEq0: XorGate port map(A(0), B(0), ZeroTest(0));
Sub0: FullAdder Port map ( A(0)  , Temp(0) , Cin(0) , SubTmp(0) , Cout(0));	
Answer(0) <=  SubTmp(0);
	Cin(1) <= Cout(0);	  

U1to14: for I in 1 to N-2 generate	   
	SubBit1to14: xorgate port map('1',B(I),Temp(I));			  
	--BitEq1to14: XorGate port map (A(I), B(I), ZeroTest(I));
	Sub1to14: FullAdder Port map ( A(I)  , Temp(I) , Cin(I) , SubTmp(I) , Cout(I));	
	Answer(I) <= SubTmp(I);
	Cin(I+1) <= Cout(I);	

end generate;	

SubBit15: xorgate port map('1',B(N-1),Temp(N-1));  
--BitEq15: XorGate port map(A(N-1), B(N-1), ZeroTest(N-1));	
Sub15: FullAdder Port map ( A(N-1)  , Temp(N-1) , Cin(N-1) , SubTmp(N-1) , Cout(N-1)); 
Answer(N-1)<= SubTmp(N-1);
Zerotmp <= SubTmp;


-- Zero Test 
ZeroTesting: for J in 1 to N-1  generate 
	ZeroTest0to15: OrGate port map(Zerotmp(J-1),Zerotmp(J),Zerotmp(J));	 
end generate;	

Invert: NotGate port map(SubTmp(N-1),Zero);
	  

-- Overflow 

Ovfl: XorGate port map(  Cout(N-1), Cin(N-1),ovtmp);
Overflow<= ovtmp;	

-- Negative Test
Negative <= SubTmp(N-1) when ovtmp = '0' else '0';
	
	


end Structural;