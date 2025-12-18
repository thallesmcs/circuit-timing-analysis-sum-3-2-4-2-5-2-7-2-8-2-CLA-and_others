--============================================================
-- Multiplexador de 2:1 entradas de 1 bit
--============================================================
LIBRARY ieee ;
USE ieee.std_logic_1164.all ;

ENTITY mux_1bit IS
	PORT (a, b: IN STD_LOGIC;
		  mux_out: OUT STD_LOGIC;
		  sel: IN STD_LOGIC
		  );
END mux_1bit;

ARCHITECTURE comportamento OF mux_1bit IS
BEGIN
	
	WITH sel SELECT
	   
	   mux_out <=	a WHEN '0',
					b WHEN others;
					
END comportamento;

-------------------------------------------------------------------
-- Somador Ripple-Carry de 4 bits
-------------------------------------------------------------------

LIBRARY ieee ;
USE ieee.std_logic_1164.all ;

entity rca4 is
    Port (
        A  : in  STD_LOGIC_VECTOR(3 downto 0);
        B  : in  STD_LOGIC_VECTOR(3 downto 0);
        Cin: in  STD_LOGIC;
        S  : out STD_LOGIC_VECTOR(3 downto 0);
        Cout: out STD_LOGIC
    );
end rca4;

architecture behavioral of rca4 is
    signal c1, c2, c3: STD_LOGIC;
begin
    -- bit 0
    S(0) <= A(0) xor B(0) xor Cin;
    c1   <= (A(0) and B(0)) or (A(0) and Cin) or (B(0) and Cin);

    -- bit 1
    S(1) <= A(1) xor B(1) xor c1;
    c2   <= (A(1) and B(1)) or (A(1) and c1) or (B(1) and c1);

    -- bit 2
    S(2) <= A(2) xor B(2) xor c2;
    c3   <= (A(2) and B(2)) or (A(2) and c2) or (B(2) and c2);

    -- bit 3
    S(3) <= A(3) xor B(3) xor c3;
    Cout <= (A(3) and B(3)) or (A(3) and c3) or (B(3) and c3);
end behavioral;


library IEEE;
use IEEE.std_logic_1164.all;

PACKAGE my_components IS

COMPONENT mux_1bit IS
	PORT (a, b: IN STD_LOGIC;
		  mux_out: OUT STD_LOGIC;
		  sel: IN STD_LOGIC
		  );
END COMPONENT;

COMPONENT rca4 is
    Port (
        A  : in  STD_LOGIC_VECTOR(3 downto 0);
        B  : in  STD_LOGIC_VECTOR(3 downto 0);
        Cin: in  STD_LOGIC;
        S  : out STD_LOGIC_VECTOR(3 downto 0);
        Cout: out STD_LOGIC
    );
end COMPONENT;

END my_components;

-------------------------------------------------------------------
-- Somador Carry-Select de 8 bits
-------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE work.my_components.all;

entity csa8 is
    Port (
        A  : in  STD_LOGIC_VECTOR(7 downto 0);
        B  : in  STD_LOGIC_VECTOR(7 downto 0);
        Cin: in  STD_LOGIC;
        S  : out STD_LOGIC_VECTOR(7 downto 0);
        Cout: out STD_LOGIC
    );
end csa8;

architecture structural of csa8 is
    signal s_low   : STD_LOGIC_VECTOR(3 downto 0);
    signal c_low   : STD_LOGIC;

    signal s_high0 : STD_LOGIC_VECTOR(3 downto 0);
    signal c_high0 : STD_LOGIC;

    signal s_high1 : STD_LOGIC_VECTOR(3 downto 0);
    signal c_high1 : STD_LOGIC;
begin
    -- Primeiro bloco (bits 3..0)
    lowblock: rca4 port map (A(3 downto 0), B(3 downto 0), Cin, s_low, c_low);

    -- Segundo bloco assumindo Cin = 0
    high0: rca4 port map (A(7 downto 4), B(7 downto 4), '0', s_high0, c_high0);

    -- Segundo bloco assumindo Cin = 1
    high1: rca4 port map (A(7 downto 4), B(7 downto 4), '1', s_high1, c_high1);

    -- MUX para selecionar soma correta
    S(3 downto 0) <= s_low;
    S(7 downto 4) <= s_high0 when c_low = '0' else s_high1;
    Cout          <= c_high0 when c_low = '0' else c_high1;

end structural;

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE work.my_components.all;

ENTITY compressor32 IS
PORT (A, B, C: IN STD_LOGIC;
	  Carry, Sum : OUT STD_LOGIC);

END compressor32;

ARCHITECTURE comportamento OF compressor32 IS

SIGNAL  out_xor1:  STD_LOGIC;

BEGIN

	out_xor1 <= A XOR B;

	Sum <= out_xor1 XOR C;
	
s0: mux_1bit
	  PORT MAP   (a => A,
				     b => C,
				     mux_out => Carry,
				     sel => out_xor1
				   );

END comportamento;

LIBRARY ieee ;
USE ieee.std_logic_1164.all ;

PACKAGE my_components1 IS

COMPONENT compressor32 IS
PORT (A, B, C: IN STD_LOGIC;
	  Carry, Sum : OUT STD_LOGIC);

END COMPONENT;

COMPONENT csa8 is
    Port (
        A  : in  STD_LOGIC_VECTOR(7 downto 0);
        B  : in  STD_LOGIC_VECTOR(7 downto 0);
        Cin: in  STD_LOGIC;
        S  : out STD_LOGIC_VECTOR(7 downto 0);
        Cout: out STD_LOGIC
    );
end COMPONENT;

END my_components1;

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE work.my_components1.all;

ENTITY compressor32_8b_Carry_Select IS
PORT (A, B, C: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	  S: OUT STD_LOGIC_VECTOR(9 DOWNTO 0)
	   );
END compressor32_8b_Carry_Select;

ARCHITECTURE comportamento OF compressor32_8b_Carry_Select IS

SIGNAL carry: STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL sum: STD_LOGIC_VECTOR(7 DOWNTO 1);

BEGIN
    
-- Compressores 3:2 (CSA)
estagio0: compressor32 PORT MAP(A(0),B(0),C(0),carry(0),S(0));
estagio1: compressor32 PORT MAP(A(1),B(1),C(1),carry(1),sum(1));
estagio2: compressor32 PORT MAP(A(2),B(2),C(2),carry(2),sum(2));
estagio3: compressor32 PORT MAP(A(3),B(3),C(3),carry(3),sum(3));
estagio4: compressor32 PORT MAP(A(4),B(4),C(4),carry(4),sum(4));
estagio5: compressor32 PORT MAP(A(5),B(5),C(5),carry(5),sum(5));
estagio6: compressor32 PORT MAP(A(6),B(6),C(6),carry(6),sum(6));
estagio7: compressor32 PORT MAP(A(7),B(7),C(7),carry(7),sum(7));

var0: csa8 PORT MAP(carry, '0' & sum, '0', S(8 downto 1), S(9));

END comportamento;

					

