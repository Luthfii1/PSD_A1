-- Add Library IEEE 
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

-- Entity BCDConverter to detect input and output 
entity BCDConverter is
    port (
        -- Input that will be converted to BCD
        binary_inp   : in std_logic_vector(7 downto 0);  -- Left bit is the MSB and the right bit is the LSB

        -- Output that will be converted to BCD
        MSD_out      : out std_logic_vector(3 downto 0); -- MSD_out to store binary value of most significant digit
        LSD_out      : out std_logic_vector(3 downto 0); -- LSD_out to store binary value of least significant digit
        MMSD_out     : out std_logic_vector(3 downto 0); -- MMSD_out to store binary value of middle most significant digit
        outp : out std_logic_vector(3 downto 0)          -- Output with 4 bits
    );
end entity;

-- Architecture of BCDConverter
architecture Converter of BCDConverter is
    -- Code to convert binary to BCD
begin

    process (binary_inp)
        variable count_total : integer range 0 to 255 := 0;     -- Variable to count how many times fauced was used
        variable msd, lsd, mmsd : integer range 0 to 9 := 0;    -- Variables to store the digits, MSD for store the most significant digit, 
                                                                -- LSD for store the least significant digit and 
                                                                -- MMSD for store the middle most significant digit
    begin

        count_total := 0;                                       -- Initialize count_total to 0
        msd := 0;                                               -- Initialize msd to 0
        lsd := 0;                                               -- Initialize lsd to 0
        mmsd := 0;                                              -- Initialize mmsd to 0
        for i in 0 to 7 loop
            if (binary_inp(i)) then count_total := count_total + 2**i; end if; -- If the bit is i, add 2^i to count_total  
        end loop;

        -- Calculate the MMSD

        -- Calculate the MSD

        -- Calculate the LSD
        
    end process;

end architecture;