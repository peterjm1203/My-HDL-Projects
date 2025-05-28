library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity remainder_correction is
    Port (
        A : in std_logic;
        Q_bit : in std_logic;
        Anded_with_Q : in std_logic;
        C_in : in std_logic;
        C_out : out std_logic;
        R : out std_logic
    );
end remainder_correction;

architecture Behavioral of remainder_correction is
    -- Component declaration for full_adder
    component full_adder
        Port (
            A : in std_logic;
            B : in std_logic;
            Cin : in std_logic;
            Sum : out std_logic;
            Cout : out std_logic
        );
    end component;

    signal and_output : std_logic;
begin
    -- AND operation
    and_output <= Q_bit and Anded_with_Q;

    -- Instantiate the full_adder component
    FA: full_adder
        port map (
            A => A,
            B => and_output,
            Cin => C_in,
            Sum => R,
            Cout => C_out
        );
end Behavioral;
