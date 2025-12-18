LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY CLA16b_Adder IS
PORT ( a, b: IN STD_LOGIC_VECTOR (15 DOWNTO 0);
       cin: IN STD_LOGIC;
       s: OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
       cout: OUT STD_LOGIC);
END CLA16b_Adder;

ARCHITECTURE CLA_Adder OF CLA16b_Adder IS
SIGNAL c: STD_LOGIC_VECTOR (16 DOWNTO 0);
SIGNAL p: STD_LOGIC_VECTOR (15 DOWNTO 0);
SIGNAL g: STD_LOGIC_VECTOR (15 DOWNTO 0);

 BEGIN
 
 ---- PGU: ---------------------------------
p <= a XOR b;
g <= a AND b;
s <= p XOR c(15 downto 0);

 ---- CLAU: --------------------------------

c(0) <= cin;

c(1) <= (cin AND p(0)) OR g(0);

c(2) <= (cin AND p(0) AND p(1)) OR  (g(0) AND p(1)) OR  g(1);

c(3) <= (cin AND p(0) AND p(1) AND p(2)) OR (g(0) AND p(1) AND p(2)) OR (g(1) AND p(2)) OR g(2);

c(4) <= (cin AND p(0) AND p(1) AND p(2) AND p(3)) OR (g(0) AND p(1) AND p(2) AND p(3)) OR (g(1) AND p(2) AND p(3)) OR
        (g(2) AND p(3)) OR g(3);

c(5) <= (cin AND p(0) AND p(1) AND p(2) AND p(3) AND p(4)) OR (g(0) AND p(1) AND p(2) AND p(3) AND p(4)) OR 
        (g(1) AND p(2) AND p(3) AND p(4)) OR (g(2) AND p(3) AND p(4)) OR (g(3) and p(4)) OR g(4);

c(6) <= (cin AND p(0) AND p(1) AND p(2) AND p(3) AND p(4) AND p(5)) OR (g(0) AND p(1) AND p(2) AND p(3) AND p(4) AND p(5)) 
         OR (g(1) AND p(2) AND p(3) AND p(4) AND p(5)) OR (g(2) AND p(3) AND p(4) AND p(5)) 
         OR (g(3) AND p(4) AND p(5)) OR (g(4) and p(5)) OR g(5);

c(7) <= (cin AND p(0) AND p(1) AND p(2) AND p(3) AND p(4) AND p(5) AND p(6)) OR 
         (g(0) AND p(1) AND p(2) AND p(3) AND p(4) AND p(5) AND p(6)) OR 
         (g(1) AND p(2) AND p(3) AND p(4) AND p(5) AND p(6)) OR 
         (g(2) AND p(3) AND p(4) AND p(5) AND p(6)) OR (g(3) AND p(4) AND p(5) AND p(6)) OR 
         (g(4) AND p(5) AND p(6)) OR (g(5) AND p(6)) OR g(6);

c(8) <= (cin AND p(0) AND p(1) AND p(2) AND p(3) AND p(4) AND p(5) AND p(6) AND p(7)) OR 
         (g(0) AND p(1) AND p(2) AND p(3) AND p(4) AND p(5) AND p(6) AND p(7)) OR 
         (g(1) AND p(2) AND p(3) AND p(4) AND p(5) AND p(6) AND p(7)) 
         OR (g(2) AND p(3) AND p(4) AND p(5) AND p(6) AND p(7)) OR 
         (g(3) AND p(4) AND p(5) AND p(6) AND p(7)) OR (g(4) AND p(5) AND p(6) AND p(7)) OR 
         (g(5) AND p(6) AND p(7)) OR (g(6) AND p(7)) OR g(7);

c(9) <= (cin AND p(0) AND p(1) AND p(2) AND p(3) AND p(4) AND p(5) AND p(6) AND p(7) AND p(8)) OR 
         (g(0) AND p(1) AND p(2) AND p(3) AND p(4) AND p(5) AND p(6) AND p(7) AND p(8)) OR 
         (g(1) AND p(2) AND p(3) AND p(4) AND p(5) AND p(6) AND p(7) AND p(8)) 
         OR (g(2) AND p(3) AND p(4) AND p(5) AND p(6) AND p(7) AND p(8)) OR 
         (g(3) AND p(4) AND p(5) AND p(6) AND p(7) AND p(8)) OR (g(4) AND p(5) AND p(6) AND p(7) AND p(8)) OR 
         (g(5) AND p(6) AND p(7) AND p(8)) OR (g(6) AND p(7) AND p(8)) OR (g(7) AND p(8)) OR g(8);

c(10) <= (cin AND p(0) AND p(1) AND p(2) AND p(3) AND p(4) AND p(5) AND p(6) AND p(7) AND p(8) AND p(9)) OR 
         (g(0) AND p(1) AND p(2) AND p(3) AND p(4) AND p(5) AND p(6) AND p(7) AND p(8) AND p(9)) OR 
         (g(1) AND p(2) AND p(3) AND p(4) AND p(5) AND p(6) AND p(7) AND p(8) AND p(9)) 
         OR (g(2) AND p(3) AND p(4) AND p(5) AND p(6) AND p(7) AND p(8) AND p(9)) OR 
         (g(3) AND p(4) AND p(5) AND p(6) AND p(7) AND p(8) AND p(9)) OR (g(4) AND p(5) AND p(6) AND p(7) AND p(8) AND p(9)) OR 
         (g(5) AND p(6) AND p(7) AND p(8) AND p(9)) OR (g(6) AND p(7) AND p(8) AND p(9)) OR (g(7) AND p(8) AND p(9)) OR (g(8) AND p(9)) OR g(9);

c(11) <= (cin AND p(0) AND p(1) AND p(2) AND p(3) AND p(4) AND p(5) AND p(6) AND p(7) AND p(8) AND p(9) AND p(10)) OR 
         (g(0) AND p(1) AND p(2) AND p(3) AND p(4) AND p(5) AND p(6) AND p(7) AND p(8) AND p(9) AND p(10)) OR 
         (g(1) AND p(2) AND p(3) AND p(4) AND p(5) AND p(6) AND p(7) AND p(8) AND p(9) AND p(10)) 
         OR (g(2) AND p(3) AND p(4) AND p(5) AND p(6) AND p(7) AND p(8) AND p(9) AND p(10)) OR 
         (g(3) AND p(4) AND p(5) AND p(6) AND p(7) AND p(8) AND p(9) AND p(10)) OR (g(4) AND p(5) AND p(6) AND p(7) AND p(8) AND p(9) AND p(10)) OR 
         (g(5) AND p(6) AND p(7) AND p(8) AND p(9) AND p(10)) OR (g(6) AND p(7) AND p(8) AND p(9) AND p(10)) OR (g(7) AND p(8) AND p(9) AND p(10)) OR (g(8) AND p(9) AND p(10)) OR (g(9) AND p(10)) OR g(10);

c(12) <= (cin AND p(0) AND p(1) AND p(2) AND p(3) AND p(4) AND p(5) AND p(6) AND p(7) AND p(8) AND p(9) AND p(10) AND p(11)) OR 
         (g(0) AND p(1) AND p(2) AND p(3) AND p(4) AND p(5) AND p(6) AND p(7) AND p(8) AND p(9) AND p(10) AND p(11)) OR 
         (g(1) AND p(2) AND p(3) AND p(4) AND p(5) AND p(6) AND p(7) AND p(8) AND p(9) AND p(10) AND p(11)) 
         OR (g(2) AND p(3) AND p(4) AND p(5) AND p(6) AND p(7) AND p(8) AND p(9) AND p(10) AND p(11)) OR 
         (g(3) AND p(4) AND p(5) AND p(6) AND p(7) AND p(8) AND p(9) AND p(10) AND p(11)) OR (g(4) AND p(5) AND p(6) AND p(7) AND p(8) AND p(9) AND p(10) AND p(11)) OR 
         (g(5) AND p(6) AND p(7) AND p(8) AND p(9) AND p(10) AND p(11)) OR (g(6) AND p(7) AND p(8) AND p(9) AND p(10) AND p(11)) OR (g(7) AND p(8) AND p(9) AND p(10) AND p(11)) OR (g(8) AND p(9) AND p(10) AND p(11)) OR (g(9) AND p(10) AND p(11)) OR (g(11) and P(11)) or  g(11);

c(13) <= (cin AND p(0) AND p(1) AND p(2) AND p(3) AND p(4) AND p(5) AND p(6) AND p(7) AND p(8) AND p(9) AND p(10) AND p(11) AND p(12)) OR 
         (g(0) AND p(1) AND p(2) AND p(3) AND p(4) AND p(5) AND p(6) AND p(7) AND p(8) AND p(9) AND p(10) AND p(11) AND p(12)) OR 
         (g(1) AND p(2) AND p(3) AND p(4) AND p(5) AND p(6) AND p(7) AND p(8) AND p(9) AND p(10) AND p(11) AND p(12)) 
         OR (g(2) AND p(3) AND p(4) AND p(5) AND p(6) AND p(7) AND p(8) AND p(9) AND p(10) AND p(11) AND p(12)) OR 
         (g(3) AND p(4) AND p(5) AND p(6) AND p(7) AND p(8) AND p(9) AND p(10) AND p(11) AND p(12)) OR (g(4) AND p(5) AND p(6) AND p(7) AND p(8) AND p(9) AND p(10) AND p(11) AND p(12)) OR 
         (g(5) AND p(6) AND p(7) AND p(8) AND p(9) AND p(10) AND p(11) AND p(12)) OR (g(6) AND p(7) AND p(8) AND p(9) AND p(10) AND p(11) AND p(12)) OR (g(7) AND p(8) AND p(9) AND p(10) AND p(11) AND p(12)) OR (g(8) AND p(9) AND p(10) AND p(11) AND p(12)) OR (g(9) AND p(10) AND p(11) AND p(12)) OR (g(10) AND p(11) AND p(12)) OR (g(11) AND p(12)) OR g(12);

c(14) <= (cin AND p(0) AND p(1) AND p(2) AND p(3) AND p(4) AND p(5) AND p(6) AND p(7) AND p(8) AND p(9) AND p(10) AND p(11) AND p(12) AND p(13)) OR 
         (g(0) AND p(1) AND p(2) AND p(3) AND p(4) AND p(5) AND p(6) AND p(7) AND p(8) AND p(9) AND p(10) AND p(11) AND p(12) AND p(13)) OR 
         (g(1) AND p(2) AND p(3) AND p(4) AND p(5) AND p(6) AND p(7) AND p(8) AND p(9) AND p(10) AND p(11) AND p(12) AND p(13)) 
         OR (g(2) AND p(3) AND p(4) AND p(5) AND p(6) AND p(7) AND p(8) AND p(9) AND p(10) AND p(11) AND p(12) AND p(13)) OR 
         (g(3) AND p(4) AND p(5) AND p(6) AND p(7) AND p(8) AND p(9) AND p(10) AND p(11) AND p(12) AND p(13)) OR (g(4) AND p(5) AND p(6) AND p(7) AND p(8) AND p(9) AND p(10) AND p(11) AND p(12) AND p(13)) OR 
         (g(5) AND p(6) AND p(7) AND p(8) AND p(9) AND p(10) AND p(11) AND p(12) AND p(13)) OR (g(6) AND p(7) AND p(8) AND p(9) AND p(10) AND p(11) AND p(12) AND p(13)) OR (g(7) AND p(8) AND p(9) AND p(10) AND p(11) AND p(12) AND p(13)) OR 
         (g(8) AND p(9) AND p(10) AND p(11) AND p(12) AND p(13)) OR (g(9) AND p(10) AND p(11) AND p(12) AND p(13)) OR (g(10) AND p(11) AND p(12) AND p(13)) OR (g(11) AND p(12) AND p(13)) OR (g(12) AND p(13)) OR g(13);

c(15) <= (cin AND p(0) AND p(1) AND p(2) AND p(3) AND p(4) AND p(5) AND p(6) AND p(7) AND p(8) AND p(9) AND p(10) AND p(11) AND p(12) AND p(13) AND p(14)) OR 
         (g(0) AND p(1) AND p(2) AND p(3) AND p(4) AND p(5) AND p(6) AND p(7) AND p(8) AND p(9) AND p(10) AND p(11) AND p(12) AND p(13) AND p(14)) OR 
         (g(1) AND p(2) AND p(3) AND p(4) AND p(5) AND p(6) AND p(7) AND p(8) AND p(9) AND p(10) AND p(11) AND p(12) AND p(13) AND p(14)) 
         OR (g(2) AND p(3) AND p(4) AND p(5) AND p(6) AND p(7) AND p(8) AND p(9) AND p(10) AND p(11) AND p(12) AND p(13) AND p(14)) OR 
         (g(3) AND p(4) AND p(5) AND p(6) AND p(7) AND p(8) AND p(9) AND p(10) AND p(11) AND p(12) AND p(13) AND p(14)) OR (g(4) AND p(5) AND p(6) AND p(7) AND p(8) AND p(9) AND p(10) AND p(11) AND p(12) AND p(13) AND p(14)) OR 
         (g(5) AND p(6) AND p(7) AND p(8) AND p(9) AND p(10) AND p(11) AND p(12) AND p(13) AND p(14)) OR (g(6) AND p(7) AND p(8) AND p(9) AND p(10) AND p(11) AND p(12) AND p(13) AND p(14)) OR (g(7) AND p(8) AND p(9) AND p(10) AND p(11) AND p(12) AND p(13) AND p(14)) OR 
         (g(8) AND p(9) AND p(10) AND p(11) AND p(12) AND p(13) AND p(14)) OR (g(9) AND p(10) AND p(11) AND p(12) AND p(13) AND p(14)) OR (g(10) AND p(11) AND p(12) AND p(13) AND p(14)) OR (g(11) AND p(12) AND p(13) AND p(14)) OR (g(12) AND p(13) AND p(14)) OR (g(13) AND p(14)) OR g(14);

c(16) <= (cin AND p(0) AND p(1) AND p(2) AND p(3) AND p(4) AND p(5) AND p(6) AND p(7) AND p(8) AND p(9) AND p(10) AND p(11) AND p(12) AND p(13) AND p(14) AND p(15)) OR 
         (g(0) AND p(1) AND p(2) AND p(3) AND p(4) AND p(5) AND p(6) AND p(7) AND p(8) AND p(9) AND p(10) AND p(11) AND p(12) AND p(13) AND p(14) AND p(15)) OR 
         (g(1) AND p(2) AND p(3) AND p(4) AND p(5) AND p(6) AND p(7) AND p(8) AND p(9) AND p(10) AND p(11) AND p(12) AND p(13) AND p(14) AND p(15)) 
         OR (g(2) AND p(3) AND p(4) AND p(5) AND p(6) AND p(7) AND p(8) AND p(9) AND p(10) AND p(11) AND p(12) AND p(13) AND p(14) AND p(15)) OR 
         (g(3) AND p(4) AND p(5) AND p(6) AND p(7) AND p(8) AND p(9) AND p(10) AND p(11) AND p(12) AND p(13) AND p(14) AND p(15)) OR (g(4) AND p(5) AND p(6) AND p(7) AND p(8) AND p(9) AND p(10) AND p(11) AND p(12) AND p(13) AND p(14) AND p(15)) OR 
         (g(5) AND p(6) AND p(7) AND p(8) AND p(9) AND p(10) AND p(11) AND p(12) AND p(13) AND p(14) AND p(15)) OR (g(6) AND p(7) AND p(8) AND p(9) AND p(10) AND p(11) AND p(12) AND p(13) AND p(14) AND p(15)) OR (g(7) AND p(8) AND p(9) AND p(10) AND p(11) AND p(12) AND p(13) AND p(14) AND p(15)) OR 
         (g(8) AND p(9) AND p(10) AND p(11) AND p(12) AND p(13) AND p(14) AND p(15)) OR (g(9) AND p(10) AND p(11) AND p(12) AND p(13) AND p(14) AND p(15)) OR (g(10) AND p(11) AND p(12) AND p(13) AND p(14) AND p(15)) OR (g(11) AND p(12) AND p(13) AND p(14) AND p(15)) OR 
         (g(12) AND p(13) AND p(14) AND p(15)) OR (g(13) AND p(14) AND p(15)) OR (g(14) AND p(15)) OR g(15);

cout <= c(16);

END CLA_Adder;

--============================================================
-- Multiplexador de 2:1 entradas de 1 bit
--============================================================
LIBRARY ieee ;
USE ieee.std_logic_1164.all ;
USE ieee.std_logic_unsigned.all;
USE ieee.std_logic_arith.all;

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

LIBRARY ieee ;
USE ieee.std_logic_1164.all ;

PACKAGE my_components IS

COMPONENT mux_1bit IS
	PORT (a, b: IN STD_LOGIC;
		  mux_out: OUT STD_LOGIC;
		  sel: IN STD_LOGIC
		  );
END COMPONENT;

COMPONENT CLA16b_Adder IS
PORT ( a, b: IN STD_LOGIC_VECTOR (15 DOWNTO 0);
       cin: IN STD_LOGIC;
       s: OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
       cout: OUT STD_LOGIC);
END COMPONENT;

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

COMPONENT bk_adder16 is
    port(
        A  : in  std_logic_vector(15 downto 0);
        B  : in  std_logic_vector(15 downto 0);
        Cin: in  std_logic;
        S  : out std_logic_vector(15 downto 0);
        Cout: out std_logic
    );
end COMPONENT;

END my_components1;

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE work.my_components.all;
USE work.my_components1.all;

ENTITY compressor32_16b_CLA IS
PORT (A, B, C: IN STD_LOGIC_VECTOR(15 DOWNTO 0);
	  S: OUT STD_LOGIC_VECTOR(17 DOWNTO 0)
	   );
END compressor32_16b_CLA;

ARCHITECTURE comportamento OF compressor32_16b_CLA IS

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

var0: CLA16b_Adder PORT MAP(carry, '0' & sum, '0', S(16 downto 1), S(17));

END comportamento;

					

