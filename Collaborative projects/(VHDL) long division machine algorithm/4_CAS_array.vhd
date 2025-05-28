-- four_CAS_array.vhd
library ieee;
use ieee.std_logic_1164.all;

entity four_CAS_array is
    port (
        M : in std_logic_vector(3 downto 0);
        A : in std_logic_vector(3 downto 0);
        B : in std_logic;
        Q : out std_logic;
        S : out std_logic_vector(3 downto 0)
    );
end four_CAS_array;

architecture Structural of four_CAS_array is
    -- Component declaration for controlled_adder_subtractor
    component controlled_adder_subtractor
        port (
            A : in std_logic;
            B : in std_logic;
            Diagonal : in std_logic;
            C_in : in std_logic;
            C_out : out std_logic;
            S : out std_logic
        );
    end component;

    signal C_out_wire : std_logic_vector(3 downto 0);
begin
    -- First controlled adder/subtractor instance (not in generate)
    cas0: controlled_adder_subtractor
        port map (
            A => A(0),
            B => B,
            Diagonal => M(0),
            C_in => B,
            C_out => C_out_wire(0),
            S => S(0)
        );

    -- Generate remaining instances
    gen_cas: for i in 1 to 3 generate
        cas_inst: controlled_adder_subtractor
            port map (
                A => A(i),
                B => B,
                Diagonal => M(i),
                C_in => C_out_wire(i-1),
                C_out => C_out_wire(i),
                S => S(i)
            );
    end generate;

    -- Q is assigned as the MSB of C_out_wire
    Q <= C_out_wire(3);
end Structural;
