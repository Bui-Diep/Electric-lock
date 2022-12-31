library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
--------------------------------------
entity electric_lock_1 is
	port (
		clk_in : in std_logic;
		btn : in std_logic_vector (0 to 7);
		o : inout std_logic;
		rs : in std_logic;
		led : out std_logic_vector (0 to 3)
		);
end electric_lock_1;
architecture behav of electric_lock_1 is
signal clk : std_logic ;
signal temp : std_logic := '1';
begin
process(btn)
constant c : std_logic := '1';
begin
case btn is
	when "01111111" => clk <= not (c);
	when "10111111" => clk <= not (c);
	when "11011111" => clk <= not (c);
	when "11101111" => clk <= not (c);
	when "11110111" => clk <= not (c);
	when "11111011" => clk <= not (c);
	when "11111101" => clk <= not (c);
	when "11111110" => clk <= not (c);
	when "11111111" => clk <= c;
	when others => null;
end case;

end process;

process (clk, temp)
variable i : integer := 0;
begin
if falling_edge (clk) then
	temp <= '0';
end if;
if temp = '0' then 
	if rising_edge (clk_in) then
		if i = 1000000 then
			i := 0;
			temp <= not (temp);
		else i := i + 1;
		end if;
	end if;
end if;
	
end process;

process(o, rs)
variable n : integer := 0;
begin
if rising_edge (o) then
	if n < 5 then
		n := n + 1;
	elsif n = 5 then
		n := 0;
	end if;	
else 
	null;
end if;

if rs = '0' then
	n := 0;
else null;
end if;

case n is
	when 1 => led(0 to 3) <= "0111";
	when 2 => led(0 to 3) <= "1011";
	when 3 => led(0 to 3) <= "1101";
	when 4 => led(0 to 3) <= "1110";
	when others => led(0 to 3) <= "1111"; 
end case;

end process;
o <= temp;
end behav;