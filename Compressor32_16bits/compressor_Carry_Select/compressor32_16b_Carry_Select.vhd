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

entity csa16 is
    Port (
        A    : in  STD_LOGIC_VECTOR(15 downto 0);
        B    : in  STD_LOGIC_VECTOR(15 downto 0);
        Cin  : in  STD_LOGIC;
        Sum  : out STD_LOGIC_VECTOR(15 downto 0);
        Cout : out STD_LOGIC
    );
end csa16;

architecture RTL of csa16 is

    -- sinais para os blocos
signal S0, S1_0, S1_1, S2_0, S2_1, S3_0, S3_1 : STD_LOGIC_VECTOR(3 downto 0);
signal C0, C1_0, C1_1, C2_0, C2_1, C3_0, C3_1 : STD_LOGIC;

-- sinais adicionais usados na seleção
    signal C1, C2 : STD_LOGIC;

begin

    ------------------------------------------------------------------
    -- Bloco 0: bits 3..0 (usa Cin diretamente)
    ------------------------------------------------------------------
    B0: rca4 port map (A(3 downto 0), B(3 downto 0), Cin, S0, C0);

    ------------------------------------------------------------------
    -- Bloco 1: bits 7..4 (precomputação para Cin=0 e Cin=1)
    ------------------------------------------------------------------
    B1_0: rca4 port map (A(7 downto 4), B(7 downto 4), '0', S1_0, C1_0);

    B1_1: rca4 port map (A(7 downto 4), B(7 downto 4), '1', S1_1, C1_1);

    ------------------------------------------------------------------
    -- Bloco 2: bits 11..8
    ------------------------------------------------------------------
    B2_0: rca4 port map (A(11 downto 8), B(11 downto 8), '0', S2_0, C2_0);

    B2_1: rca4 port map (A(11 downto 8), B(11 downto 8), '1', S2_1, C2_1);

    ------------------------------------------------------------------
    -- Bloco 3: bits 15..12
    ------------------------------------------------------------------
    B3_0: rca4 port map (A(15 downto 12), B(15 downto 12), '0', S3_0, C3_0);

    B3_1: rca4 port map (A(15 downto 12), B(15 downto 12), '1', S3_1, C3_1);

    ------------------------------------------------------------------
    -- Multiplexação dos blocos
    ------------------------------------------------------------------
    Sum(3 downto 0) <= S0;

    Sum(7 downto 4) <= S1_0 when C0 = '0' else S1_1;
    C1              <= C1_0 when C0 = '0' else C1_1;

    Sum(11 downto 8) <= S2_0 when C1 = '0' else S2_1;
    C2               <= C2_0 when C1 = '0' else C2_1;

    Sum(15 downto 12) <= S3_0 when C2 = '0' else S3_1;
    Cout              <= C3_0 when C2 = '0' else C3_1;

end RTL;

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

COMPONENT csa16 is
    Port (
        A    : in  STD_LOGIC_VECTOR(15 downto 0);
        B    : in  STD_LOGIC_VECTOR(15 downto 0);
        Cin  : in  STD_LOGIC;
        Sum  : out STD_LOGIC_VECTOR(15 downto 0);
        Cout : out STD_LOGIC
    );
end COMPONENT;

END my_components1;

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE work.my_components1.all;

ENTITY compressor32_16b_Carry_Select IS
PORT (A, B, C: IN STD_LOGIC_VECTOR(15 DOWNTO 0);
	  S: OUT STD_LOGIC_VECTOR(17 DOWNTO 0)
	   );
END compressor32_16b_Carry_Select;

ARCHITECTURE comportamento OF compressor32_16b_Carry_Select IS

SIGNAL carry: STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL sum: STD_LOGIC_VECTOR(15 DOWNTO 1);

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
estagio8: compressor32 PORT MAP(A(8),B(8),C(8),carry(8),sum(8));
estagio9: compressor32 PORT MAP(A(9),B(9),C(9),carry(9),sum(9));
estagio10: compressor32 PORT MAP(A(10),B(10),C(10),carry(10),sum(10));
estagio11: compressor32 PORT MAP(A(11),B(11),C(11),carry(11),sum(11));
estagio12: compressor32 PORT MAP(A(12),B(12),C(12),carry(12),sum(12));
estagio13: compressor32 PORT MAP(A(13),B(13),C(13),carry(13),sum(13));
estagio14: compressor32 PORT MAP(A(14),B(14),C(14),carry(14),sum(14));
estagio15: compressor32 PORT MAP(A(15),B(15),C(15),carry(15),sum(15));

var0: csa16 PORT MAP(carry, '0' & sum, '0', S(16 downto 1), S(17));

END comportamento;

					

