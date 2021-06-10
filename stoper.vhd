----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:19:49 04/30/2021 
-- Design Name: 
-- Module Name:    multipleksowanie - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity multipleksowanie is
    Port ( clk : in  STD_LOGIC;
			  reset_stop : in STD_LOGIC;
			  --clk_1 : out std_logic;
			  --clk_2 : out std_logic;
			  start : in STD_LOGIC;
			  stop : in std_logic;
			  odczyt : in std_logic;
			  --en_1 : in STD_LOGIC;
			  --en_2 : in std_logic;
			  --en_3 : in std_logic;
			  --en_4 : in std_logic;
           --wej_1 : in  STD_LOGIC_VECTOR (3 downto 0);
           --wej_10 : in  STD_LOGIC_VECTOR (3 downto 0);
           --wej_100 : in  STD_LOGIC_VECTOR (3 downto 0);
           --wej_1000 : in  STD_LOGIC_VECTOR (3 downto 0);
			  --wej_muxa : in  STD_LOGIC_VECTOR (3 downto 0);
			  dig: out std_logic_vector(7 downto 0);
			  --adr_2: out STD_LOGIC_VECTOR(2 DOWNTO 0);	
			  wyj_dek: out std_logic_vector(6 downto 0));
end multipleksowanie;

architecture Behavioral of multipleksowanie is
	signal adr: STD_LOGIC_VECTOR(2 DOWNTO 0);		--linia adresowa
	signal wej_dek: STD_LOGIC_VECTOR(3 DOWNTO 0);		--wyjscie MUX'a / wejscie dekodera
	signal clk_out : std_logic;
	signal clk_out2 : std_logic;
	signal run : std_logic;
	signal stop_p : std_logic;
	SIGNAL wyjscie_tym : std_logic_vector (3 downto 0);
	SIGNAL wyjscie_2_tym : std_logic_vector (3 downto 0);
	signal wyjscie_3_tym : std_logic_vector (3 downto 0);
	signal wyjscie_4_tym : std_logic_vector (3 downto 0);
	signal wyjscie_5_tym : std_logic_vector (3 downto 0);
	signal wyjscie_6_tym : std_logic_vector (3 downto 0);
	signal wyjscie_7_tym : std_logic_vector (3 downto 0);
	signal wyjscie_8_tym : std_logic_vector (3 downto 0);
	signal en_1_tym : std_logic;
	signal en_2_tym : std_logic;
	signal en_3_tym : std_logic;
	signal en_4_tym : std_logic;
	
	
begin		
	process(clk)
	variable tym: natural range 0 to 20000; --zamiast 500 000
		begin
		if (clk'event and clk = '0') then
			tym := tym + 1;
			if tym = 20000 then
				tym := 0;
				clk_out <= not clk_out;
			end if;
		end if;
	end process;

	process(clk_out)
		begin
		if (clk_out'event and clk_out='0') then
				adr <= adr + 1;
		end if;
	end process;
	
	process(clk)
	variable tym: natural range 0 to 500000; --zamiast 1 000 000
		begin
		if (clk'event and clk = '0') then
			tym := tym + 1;
			if tym = 500000 then
				tym := 0;
				clk_out2 <= not clk_out2;
			end if;
		end if;
	end process;

	process (clk_out2)
		begin  
			if (clk_out2'event and clk_out2 = '1') then
				if run = '1' then
						wyjscie_tym <= wyjscie_tym + 1;
						en_1_tym <= '0';
						
						if wyjscie_tym = "1000" then
							en_1_tym <= '1';
						end if;	
						
						if wyjscie_tym = "1001" then
							wyjscie_tym <= "0000";
						end if;	
				end if;
				if stop_p = '1' then
					wyjscie_tym <= "0000";
				end if;
			end if;
	end process;

	process (clk_out2)
		begin  
			if (clk_out2'event and clk_out2 = '1') then
				if run = '1' then
						if en_1_tym = '1' then
							wyjscie_2_tym <= wyjscie_2_tym + 1;
							en_2_tym <= '0';
						
							if wyjscie_2_tym = "1000" then
								en_2_tym <= '1';
							end if;	
										
							if wyjscie_2_tym = "1001" then
								wyjscie_2_tym <= "0000";
							end if;	
							
						end if;
				end if;
				if stop_p = '1' then
					wyjscie_2_tym <= "0000";
				end if;
			end if;
	end process;

	
	process (clk_out2)
		begin  
			if (clk_out2'event and clk_out2 = '1') then
				if run = '1' then
						if (en_2_tym = '1' and en_1_tym = '1') then
							wyjscie_3_tym <= wyjscie_3_tym + 1;
							en_3_tym <= '0';
						
							if wyjscie_3_tym = "1000" then
								en_3_tym <= '1';
							end if;	
										
							if wyjscie_3_tym = "1001" then
								wyjscie_3_tym <= "0000";
							end if;	
						end if;

				end if;
				if stop_p = '1' then
					wyjscie_3_tym <= "0000";
				end if;
			end if;
	end process;

	process (clk_out2)
		begin  
			if (clk_out2'event and clk_out2 = '1') then
				if run = '1' then
						if (en_3_tym = '1' and en_2_tym = '1' and en_1_tym = '1') then
							wyjscie_4_tym <= wyjscie_4_tym + 1;
							en_4_tym <= '0';
						
							if wyjscie_4_tym = "1000" then
								en_4_tym <= '1';
							end if;	
										
							if wyjscie_4_tym = "1001" then
								wyjscie_4_tym <= "0000";
							end if;	
						end if;
				end if;
				if stop_p = '1' then
					wyjscie_4_tym <= "0000";
				end if;
			end if;
	end process;
		
		process (clk)
			begin  
				if (clk'event and clk = '1') then				
					if odczyt = '1' then			
						wyjscie_5_tym <= wyjscie_tym;
						wyjscie_6_tym <= wyjscie_2_tym;
						wyjscie_7_tym <= wyjscie_3_tym;
						wyjscie_8_tym <= wyjscie_4_tym;
					end if;
					if start = '1' then
						run <= '1';
						stop_p <= '0';
					end if;
					if stop = '1' then
						run <= '0';
						stop_p <= '0';
					end if;
					if reset_stop = '1' then
						stop_p <= '1';
					end if;
				end if;
		end process;

	
		with adr select	--kontroler pozycji
			dig <= 	not "00000001" when "000",
						not "00000010" when "001",
						not "00000100" when "010",
						not "00001000" when "011",
						not "00010000" when "100",
						not "00100000" when "101",
						not "01000000" when "110",
						not "10000000" when "111";
						
		with adr select	--MuX
			wej_dek <= 	wyjscie_tym when "000",
							wyjscie_2_tym when "001",
							wyjscie_3_tym  when "010",
							wyjscie_4_tym  when "011",
							wyjscie_5_tym  when "100",
							wyjscie_6_tym  when "101",
							wyjscie_7_tym  when "110",
							wyjscie_8_tym  when "111";
							
		with wej_dek  select	--dekoder
			wyj_dek <=  not "1111110" when "0000",	--0
							not "0110000" when "0001",	--1
							not "1101101" when "0010",	--2
							not "1111001" when "0011",	--3
							not "0110011" when "0100",	--4
							not "1011011" when "0101",	--5
							not "1011111" when "0110",	--6
							not "1110000" when "0111",	--7
							not "1111111" when "1000",	--8
							not "1111011" when "1001",	--9
							not "0000000" when others;
		
--adr_2 <= adr;		
--clk_1 <= clk_out;
--clk_2 <= clk_out2;
end Behavioral;


