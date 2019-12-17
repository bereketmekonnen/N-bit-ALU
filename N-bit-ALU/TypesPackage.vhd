library ieee;
use ieee.std_logic_1164.all;
-- declaration 
package TypesPackage is    

-- Tried to make this generic, cant do it
-- used for entety							  

subtype NBits is std_logic_vector(16-1 downto 0);  
type DataSel is array (8-1  downto 0) of NBits;	 

subtype flag is std_logic_vector(2 downto 0);
type flags is array(8-1 downto 0) of flag;

end package TypesPackage;		


