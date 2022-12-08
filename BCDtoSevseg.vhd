-- This is a generic seven-segment display module that takes a 4-bit BCD value as input
-- and outputs the corresponding 7-segment display pattern.

library ieee;
use ieee.std_logic_1164.all;

-- Entity for the binary-to-7-segment converter
entity BCDtoSevseg is
    port(
        bin_in : in  std_logic_vector(3 downto 0);
        seg_out : out std_logic_vector(6 downto 0)
    );
end entity;

-- Architecture for the binary-to-7-segment converter
architecture rtl of BCDtoSevseg is
begin
    -- Convert the binary input to 7-segment display values
    -- using a case statement
    process(bin_in)
    begin
        case bin_in is
            when "0000" => seg_out <= "1111110";  -- 0
            when "0001" => seg_out <= "0110000";  -- 1
            when "0010" => seg_out <= "1101101";  -- 2
            when "0011" => seg_out <= "1111001";  -- 3
            when "0100" => seg_out <= "0110011";  -- 4
            when "0101" => seg_out <= "1011011";  -- 5
            when "0110" => seg_out <= "1011111";  -- 6
            when "0111" => seg_out <= "1110000";  -- 7
            when "1000" => seg_out <= "1111111";  -- 8
            when "1001" => seg_out <= "1111011";  -- 9
            when others => seg_out <= "1111111";  -- All segments on
        end case;
    end process;
end architecture;