----------------------------------------------------------------------------------
-- Top-level wrapper para o compressor 5:2 de 28 bits com registros pipelined.
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top_level_compressor_52_28b_v1 is
  port (
    clk      : in  std_logic;
    ap_rst   : in  std_logic;
    a        : in  std_logic_vector(27 downto 0);
    b        : in  std_logic_vector(27 downto 0);
    c        : in  std_logic_vector(27 downto 0);
    d        : in  std_logic_vector(27 downto 0);
    e        : in  std_logic_vector(27 downto 0);
    soma     : out std_logic_vector(27 downto 0);
    c_out    : out std_logic
  );
end top_level_compressor_52_28b_v1;

architecture Behavioral of top_level_compressor_52_28b_v1 is

  component Compressor_52_28b_v1 is
    port (
      a   : in  std_logic_vector(27 downto 0);
      b   : in  std_logic_vector(27 downto 0);
      c   : in  std_logic_vector(27 downto 0);
      d   : in  std_logic_vector(27 downto 0);
      e   : in  std_logic_vector(27 downto 0);
      sum : out std_logic_vector(30 downto 0)
    );
  end component;

  component FF_D28 is
    port (
      clk   : in  std_logic;
      rst_n : in  std_logic;
      d     : in  std_logic_vector(27 downto 0);
      q     : out std_logic_vector(27 downto 0)
    );
  end component;

  component FF_D is
    port (
      clk   : in  std_logic;
      rst_n : in  std_logic;
      d     : in  std_logic;
      q     : out std_logic
    );
  end component;

  signal rst_n     : std_logic;
  signal a_reg     : std_logic_vector(27 downto 0);
  signal b_reg     : std_logic_vector(27 downto 0);
  signal c_reg     : std_logic_vector(27 downto 0);
  signal d_reg     : std_logic_vector(27 downto 0);
  signal e_reg     : std_logic_vector(27 downto 0);
  signal s_raw     : std_logic_vector(30 downto 0);
  signal soma_raw  : std_logic_vector(27 downto 0);
  signal soma_reg  : std_logic_vector(27 downto 0);
  signal c_out_raw : std_logic;
  signal c_out_reg : std_logic;

begin

  rst_n <= not ap_rst;

  ff_a : FF_D28
    port map (clk => clk, rst_n => rst_n, d => a, q => a_reg);

  ff_b : FF_D28
    port map (clk => clk, rst_n => rst_n, d => b, q => b_reg);

  ff_c : FF_D28
    port map (clk => clk, rst_n => rst_n, d => c, q => c_reg);

  ff_d1 : FF_D28
    port map (clk => clk, rst_n => rst_n, d => d, q => d_reg);

  ff_e : FF_D28
    port map (clk => clk, rst_n => rst_n, d => e, q => e_reg);

  u_compressor : Compressor_52_28b_v1
    port map (
      a   => a_reg,
      b   => b_reg,
      c   => c_reg,
      d   => d_reg,
      e   => e_reg,
      sum => s_raw
    );

  -- Separa os bits de soma e de carry produzidos pelo compressor 5:2.
  soma_raw  <= s_raw(27 downto 0);
  c_out_raw <= s_raw(30);

  ff_soma : FF_D28
    port map (clk => clk, rst_n => rst_n, d => soma_raw, q => soma_reg);

  ff_cout : FF_D
    port map (clk => clk, rst_n => rst_n, d => c_out_raw, q => c_out_reg);

  soma  <= soma_reg;
  c_out <= c_out_reg;

end Behavioral;
