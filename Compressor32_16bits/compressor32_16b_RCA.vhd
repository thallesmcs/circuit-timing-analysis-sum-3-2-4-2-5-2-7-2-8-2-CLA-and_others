library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity HALF_ADDER is
port (A, B: in std_logic;
      Cout: out std_logic;
      S: out std_logic
      );
end HALF_ADDER;

architecture Behavioral of HALF_ADDER is

begin

S <= A XOR B;
Cout <= A AND B;

end Behavioral;

LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY FULL_ADDER IS
	PORT (CIN, A, B: IN STD_LOGIC;
		  COUT, S: OUT STD_LOGIC
	);
END FULL_ADDER;

ARCHITECTURE RCAcomportamento4m28b OF FULL_ADDER IS

SIGNAL fio1, fio2, fio3: STD_LOGIC;
BEGIN
	fio1 <= A XOR B; 
	S <= fio1 XOR CIN;
	fio2 <= A AND B; 
	fio3 <= fio1 AND CIN; 
	COUT <= fio3 OR fio2; 
END RCAcomportamento4m28b;

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

COMPONENT HALF_ADDER is
port (A, B: in std_logic;
      Cout: out std_logic;
      S: out std_logic
      );
END COMPONENT;

COMPONENT FULL_ADDER IS
	PORT (CIN, A, B: IN STD_LOGIC;
		  COUT, S: OUT STD_LOGIC
	);
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

ENTITY compressor32_16b_RCA IS
PORT (A, B, C: IN STD_LOGIC_VECTOR(15 DOWNTO 0);
	  S: OUT STD_LOGIC_VECTOR(17 DOWNTO 0)
	   );
END compressor32_16b_RCA;

ARCHITECTURE comportamento OF compressor32_16b_RCA IS

SIGNAL carry: STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL sum: STD_LOGIC_VECTOR(15 DOWNTO 1);
SIGNAL temp: STD_LOGIC_VECTOR(14 DOWNTO 0);

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

var0: HALF_ADDER PORT MAP(carry(0), sum(1), temp(0), S(1));
var1: FULL_ADDER PORT MAP(temp(0), carry(1), sum(2), temp(1), S(2));
var2: FULL_ADDER PORT MAP(temp(1), carry(2), sum(3), temp(2), S(3));
var3: FULL_ADDER PORT MAP(temp(2), carry(3), sum(4), temp(3), S(4));
var4: FULL_ADDER PORT MAP(temp(3), carry(4), sum(5), temp(4), S(5));
var5: FULL_ADDER PORT MAP(temp(4), carry(5), sum(6), temp(5), S(6));
var6: FULL_ADDER PORT MAP(temp(5), carry(6), sum(7), temp(6), S(7));
var7: FULL_ADDER PORT MAP(temp(6), carry(7), sum(8), temp(7), S(8));
var8: FULL_ADDER PORT MAP(temp(7), carry(8), sum(9), temp(8), S(9));
var9: FULL_ADDER PORT MAP(temp(8), carry(9), sum(10), temp(9), S(10));
var10: FULL_ADDER PORT MAP(temp(9), carry(10), sum(11), temp(10), S(11));
var11: FULL_ADDER PORT MAP(temp(10), carry(11), sum(12), temp(11), S(12));
var12: FULL_ADDER PORT MAP(temp(11), carry(12), sum(13), temp(12), S(13));
var13: FULL_ADDER PORT MAP(temp(12), carry(13), sum(14), temp(13), S(14));
var14: FULL_ADDER PORT MAP(temp(13), carry(14), sum(15), temp(14), S(15));
var15: HALF_ADDER PORT MAP(temp(14), carry(15), S(17), S(16));

--sum(16) <= '0';
-- Soma dos Resultados Parciais
-- Somador da biblioteca, '+'.

--S(0) <= sum(0);

--S(17 downto 1) <= ('0' & carry) + ( '0' & sum(16 downto 1));

END comportamento;

					

