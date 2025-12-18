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

library ieee;
use ieee.std_logic_1164.all;

entity kogge_stone_8 is
    port(
        A   : in  std_logic_vector(7 downto 0);
        B   : in  std_logic_vector(7 downto 0);
        Cin : in  std_logic;
        SUM : out std_logic_vector(7 downto 0);
        Cout: out std_logic
    );
end kogge_stone_8;

architecture rtl of kogge_stone_8 is

    -- stage 0: per-bit G and P
    signal G0, P0 : std_logic_vector(7 downto 0);

    -- stage 1: (combine neighbors)
    signal G1, P1 : std_logic_vector(7 downto 0);

    -- stage 2: 
    signal G2, P2 : std_logic_vector(7 downto 0);

    -- stage 3: (final)
    signal G3, P3 : std_logic_vector(7 downto 0);

    -- carries (C(i) is carry into bit i)
    signal C : std_logic_vector(8 downto 0); -- C(0)=Cin ... C(8)=Cout

begin

    ------------------------------------------------------------------
    -- carry in
    ------------------------------------------------------------------
    C(0) <= Cin;

    ------------------------------------------------------------------
    -- Stage 0: generate/propagate
    ------------------------------------------------------------------
    G0(0) <= A(0) and B(0);
    P0(0) <= A(0) xor B(0);

    G0(1) <= A(1) and B(1);
    P0(1) <= A(1) xor B(1);

    G0(2) <= A(2) and B(2);
    P0(2) <= A(2) xor B(2);

    G0(3) <= A(3) and B(3);
    P0(3) <= A(3) xor B(3);

    G0(4) <= A(4) and B(4);
    P0(4) <= A(4) xor B(4);

    G0(5) <= A(5) and B(5);
    P0(5) <= A(5) xor B(5);

    G0(6) <= A(6) and B(6);
    P0(6) <= A(6) xor B(6);

    G0(7) <= A(7) and B(7);
    P0(7) <= A(7) xor B(7);

    ------------------------------------------------------------------
    -- Stage 1 - combine i and i-1 for i >= 1
    ------------------------------------------------------------------
    -- copy index 0
    G1(0) <= G0(0);
    P1(0) <= P0(0);

    -- i = 1
    G1(1) <= G0(1) or (P0(1) and G0(0));
    P1(1) <= P0(1) and P0(0);

    -- i = 2
    G1(2) <= G0(2) or (P0(2) and G0(1));
    P1(2) <= P0(2) and P0(1);

    -- i = 3
    G1(3) <= G0(3) or (P0(3) and G0(2));
    P1(3) <= P0(3) and P0(2);

    -- i = 4
    G1(4) <= G0(4) or (P0(4) and G0(3));
    P1(4) <= P0(4) and P0(3);

    -- i = 5
    G1(5) <= G0(5) or (P0(5) and G0(4));
    P1(5) <= P0(5) and P0(4);

    -- i = 6
    G1(6) <= G0(6) or (P0(6) and G0(5));
    P1(6) <= P0(6) and P0(5);

    -- i = 7
    G1(7) <= G0(7) or (P0(7) and G0(6));
    P1(7) <= P0(7) and P0(6);

    ------------------------------------------------------------------
    -- Stage 2 - combine i and i-2 for i >= 2
    ------------------------------------------------------------------
    -- copy indices 0 and 1
    G2(0) <= G1(0);
    P2(0) <= P1(0);

    G2(1) <= G1(1);
    P2(1) <= P1(1);

    -- i = 2
    G2(2) <= G1(2) or (P1(2) and G1(0));
    P2(2) <= P1(2) and P1(0);

    -- i = 3
    G2(3) <= G1(3) or (P1(3) and G1(1));
    P2(3) <= P1(3) and P1(1);

    -- i = 4
    G2(4) <= G1(4) or (P1(4) and G1(2));
    P2(4) <= P1(4) and P1(2);

    -- i = 5
    G2(5) <= G1(5) or (P1(5) and G1(3));
    P2(5) <= P1(5) and P1(3);

    -- i = 6
    G2(6) <= G1(6) or (P1(6) and G1(4));
    P2(6) <= P1(6) and P1(4);

    -- i = 7
    G2(7) <= G1(7) or (P1(7) and G1(5));
    P2(7) <= P1(7) and P1(5);

    ------------------------------------------------------------------
    -- Stage 3 - combine i and i-4 for i >= 4  (final stage)
    ------------------------------------------------------------------
    -- copy indices 0..3
    G3(0) <= G2(0);
    P3(0) <= P2(0);

    G3(1) <= G2(1);
    P3(1) <= P2(1);

    G3(2) <= G2(2);
    P3(2) <= P2(2);

    G3(3) <= G2(3);
    P3(3) <= P2(3);

    -- i = 4
    G3(4) <= G2(4) or (P2(4) and G2(0));
    P3(4) <= P2(4) and P2(0);

    -- i = 5
    G3(5) <= G2(5) or (P2(5) and G2(1));
    P3(5) <= P2(5) and P2(1);

    -- i = 6
    G3(6) <= G2(6) or (P2(6) and G2(2));
    P3(6) <= P2(6) and P2(2);

    -- i = 7
    G3(7) <= G2(7) or (P2(7) and G2(3));
    P3(7) <= P2(7) and P2(3);

    ------------------------------------------------------------------
    -- Final carry extraction
    -- Carry into bit i is C(i) (i from 0..7). C(0)=Cin.
    -- For i>=1: C(i) = G3(i-1) OR (P3(i-1) AND Cin)
    -- Cout = C(8) = G3(7) OR (P3(7) AND Cin)
    ------------------------------------------------------------------
    C(0) <= Cin;

    C(1) <= G3(0) or (P3(0) and Cin);
    C(2) <= G3(1) or (P3(1) and Cin);
    C(3) <= G3(2) or (P3(2) and Cin);
    C(4) <= G3(3) or (P3(3) and Cin);
    C(5) <= G3(4) or (P3(4) and Cin);
    C(6) <= G3(5) or (P3(5) and Cin);
    C(7) <= G3(6) or (P3(6) and Cin);
    C(8) <= G3(7) or (P3(7) and Cin); -- final carry out

    ------------------------------------------------------------------
    -- Sum bits
    ------------------------------------------------------------------
    SUM(0) <= P0(0) xor C(0);
    SUM(1) <= P0(1) xor C(1);
    SUM(2) <= P0(2) xor C(2);
    SUM(3) <= P0(3) xor C(3);
    SUM(4) <= P0(4) xor C(4);
    SUM(5) <= P0(5) xor C(5);
    SUM(6) <= P0(6) xor C(6);
    SUM(7) <= P0(7) xor C(7);

    Cout <= C(8);

end rtl;

library ieee;
use ieee.std_logic_1164.all;

PACKAGE my_components IS

COMPONENT mux_1bit IS
	PORT (a, b: IN STD_LOGIC;
		  mux_out: OUT STD_LOGIC;
		  sel: IN STD_LOGIC
		  );
END COMPONENT;

COMPONENT kogge_stone_8 is
    port(
        A   : in  std_logic_vector(7 downto 0);
        B   : in  std_logic_vector(7 downto 0);
        Cin : in  std_logic;
        SUM : out std_logic_vector(7 downto 0);
        Cout: out std_logic
    );
end COMPONENT;

END my_components;

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

END my_components1;

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE work.my_components.all;
USE work.my_components1.all;

ENTITY compressor32_8b_Kogge_Stone IS
PORT (A, B, C: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	  S: OUT STD_LOGIC_VECTOR(9 DOWNTO 0)
	   );
END compressor32_8b_Kogge_Stone;

ARCHITECTURE comportamento OF compressor32_8b_Kogge_Stone IS

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

var0: kogge_stone_8 PORT MAP(carry, '0' & sum, '0', S(8 downto 1), S(9));

END comportamento;

					

