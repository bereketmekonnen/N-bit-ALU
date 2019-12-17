library IEEE;	  
library mydesign;
use mydesign.all;
use IEEE.STD_LOGIC_1164.all;

entity NBitAdder is  
	generic( N     :     integer);
    Port ( A  , B  : in  STD_LOGIC_VECTOR(N-1 downto 0);  -- A and B as inputs to n bit adder 
	Overflow,Negative,Zero       : out std_logic;
	Answer         : out STD_LOGIC_VECTOR(N-1 downto 0);
	CarryOut           : out std_logic
	);    
end NBitAdder;

architecture Structural of NBitAdder is

-- Compoments Needed 
component FullAdder 	 
	Port ( A  , B , CarryIn : in  STD_LOGIC;   -- XOR gate input
	Sum , CarryOut    : out STD_LOGIC
	);	
end component;	

component XorGate
	port(IN1, IN2 : in std_logic;
	     O        : out std_logic);
end component;

component XnorGate
	port(IN1, IN2 : in std_logic;
	     O        : out std_logic);
end component;

component AndGate
	port(IN1 , IN2 : in std_logic;
		O          : out std_logic);
end component;



signal Cout, Cin : std_logic_vector(N-1 downto 0);	  
signal TestOne,TestTwo : std_logic;	
signal tmp : std_logic_vector(N-1 downto 0);


begin 	
-- port map of components to create a N bit adder

Cin(0) <= '0';	-- firt bit calculations
Add0: FullAdder Port map ( A(0)  , B(0) , Cin(0) , Answer(0) , Cout(0));
	Cin(1) <= Cout(0);	  

U1to14: for I in 1 to N-2 generate		   -- Loop of components
	Add1to14: FullAdder Port map ( A(I)  , B(I) , Cin(I) , Answer(I) , Cout(I));
	Cin(I+1) <= Cout(I);
end generate;	  

Add15: FullAdder Port map ( A(N-1)  , B(N-1) , Cin(N-2) , tmp(N-1) , Cout(N-1)); -- last bit calculations (left open because signal is not needed )
Answer(N-1) <= tmp(N-1);  
CarryOut <= Cout(N-1);

-- Negative test 
Negative <= tmp(N-1);

-- Overflow test
OflowTest0: XnorGate port map(A(N-1), B(N-1), TestOne);	 -- checks the last bits if they are equal
OflowTest1: XorGate port map(B(N-1) , tmp(N-1), TestTwo);
OflowTest2: AndGate port map(TestOne, TestTwo, Overflow); 

-- Zero 
Zero <= 'Z';



	
	


end Structural;