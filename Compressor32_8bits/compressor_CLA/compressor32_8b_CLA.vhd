LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY CLA8b_Adder IS
PORT ( a, b: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
       cin: IN STD_LOGIC;
       s: OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
       cout: OUT STD_LOGIC);
END CLA8b_Adder;

ARCHITECTURE CLA_Adder OF CLA8b_Adder IS
SIGNAL c: STD_LOGIC_VECTOR (8 DOWNTO 0);
SIGNAL p: STD_LOGIC_VECTOR (7 DOWNTO 0);
SIGNAL g: STD_LOGIC_VECTOR (7 DOWNTO 0);

 BEGIN
 
 ---- PGU: ---------------------------------
p <= a XOR b;
g <= a AND b;
s <= p XOR c(7 downto 0);

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

cout <= c(8);

END CLA_Adder;

LIBRARY ieee ;
USE ieee.std_logic_1164.all ;

ENTITY mux IS
	PORT (a, b: IN STD_LOGIC;
		   sel: IN STD_LOGIC;
		   mux_out: OUT STD_LOGIC
		  );
END mux;

ARCHITECTURE comportamento OF mux IS
BEGIN
	
	PROCESS (sel,a,b)
	BEGIN
		IF (sel = '0') THEN
			mux_out <= a;
		ELSE
			mux_out <= b;
		END IF;
	END PROCESS;

END comportamento;

LIBRARY ieee ;
USE ieee.std_logic_1164.all ;

PACKAGE my_components1 IS

COMPONENT mux IS
	PORT (a, b: IN STD_LOGIC;
		   sel: IN STD_LOGIC;
		   mux_out: OUT STD_LOGIC
		  );
END COMPONENT;

COMPONENT CLA8b_Adder IS
PORT ( a, b: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
       cin: IN STD_LOGIC;
       s: OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
       cout: OUT STD_LOGIC);
END COMPONENT;

END my_components1;

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE work.my_components1.all;

ENTITY compressor32 IS
PORT (A, B, C: IN STD_LOGIC;
	  Carry, Sum : OUT STD_LOGIC);

END compressor32;

ARCHITECTURE comportamento OF compressor32 IS

SIGNAL  out_xor1:  STD_LOGIC;

BEGIN

	out_xor1 <= A XOR B;

	Sum <= out_xor1 XOR C;
	
s0: mux
	  PORT MAP   (a => A,
				     b => C,
				     sel => out_xor1,
				     mux_out => Carry	);

END comportamento;

LIBRARY ieee ;
USE ieee.std_logic_1164.all ;

PACKAGE my_components2 IS

COMPONENT compressor32 IS
PORT (A, B, C: IN STD_LOGIC;
	  Carry, Sum : OUT STD_LOGIC);

END COMPONENT;

END my_components2;

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE work.my_components1.all;
USE work.my_components2.all;

ENTITY compressor32_8b_CLA IS
PORT (A, B, C: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	  S: OUT STD_LOGIC_VECTOR(9 DOWNTO 0)
	   );
END compressor32_8b_CLA;

ARCHITECTURE comportamento OF compressor32_8b_CLA IS

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

var0: CLA8b_Adder PORT MAP(carry, '0' & sum, '0', S(8 downto 1), S(9));

END comportamento;

					

