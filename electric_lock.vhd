library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
--------------------------------------
entity electric_lock is
	port (
		i : in std_logic;
		clk_in : in std_logic;
		o : out std_logic
		);
end electric_lock;
architecture behavioral of electric_lock is
signal temp : std_logic := '1';
begin

process(i, clk_in, temp)
variable n : integer := 0;

begin

if temp = '0' then
	if rising_edge (clk_in) then
		if n = 1000000 then
			n := 0;
			temp <= not (temp);
		elsif n < 1000000 then
			n := n + 1;
		end if;
	end if;
elsif temp = '1' then
	if falling_edge (i) then
		temp <= '0';
	else null;
	end if;
end if;
end process;
o <= temp;

end behavioral;