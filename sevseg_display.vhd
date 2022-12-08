-- Add library IEEE
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

-- Entity declaration for the top level
-- 3 Digit seven segment display using active low
entity sevseg_display is
    port (
        -- Inputs
        binary_sevseg : in std_logic_vector(7 downto 0);    -- 8 bit binary input
        msd, lsd, mmsd : in std_logic_vector(3 downto 0);   -- 4 bit binary input to select the digit to be displayed
        CLK : in std_logic;                                 -- Clock input

        -- Outputs
        segment : out std_logic_vector(6 downto 0)          -- 7 bit output to drive the 7 segment display
    );
end entity;

-- Architecture declaration for the top level
architecture BCDtoSevSeg of sevseg_display is

    -- Component BCDConverter to detect input and output 
    component BCDConverter is
        port (
            -- Input that will be converted to BCD
            binary_inp   : in std_logic_vector(7 downto 0);  -- Left bit is the MSB and the right bit is the LSB

            -- Output that will be converted to BCD
            MSD_out      : out std_logic_vector(3 downto 0); -- MSD_out to store binary value of most significant digit
            LSD_out      : out std_logic_vector(3 downto 0); -- LSD_out to store binary value of least significant digit
            MMSD_out     : out std_logic_vector(3 downto 0) -- MMSD_out to store binary value of middle most significant digit
        );
    end component;

begin

    -- Convert from binary to BCD

end architecture;