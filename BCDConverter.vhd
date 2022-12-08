-- Add Library IEEE 
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;


-- Entity BCDConverter to detect input and output 
entity BCDConverter is
    port (
        -- Input that will be converted to BCD
        counter_inp  : in std_logic_vector(7 downto 0);  -- Left bit is the MSB and the right bit is the LSB, counter_input to store the input value of the counter
        timer_inp    : in std_logic_vector(3 downto 0);  -- timer_input to store the input value of the timer
        -- Output that will be converted to BCD
        MSD_out      : out std_logic_vector(3 downto 0); -- MSD_out to store binary value of most significant digit
        LSD_out      : out std_logic_vector(3 downto 0); -- LSD_out to store binary value of least significant digit
        MMSD_out     : out std_logic_vector(3 downto 0); -- MMSD_out to store binary value of middle most significant digit
        timer_out    : out std_logic_vector(3 downto 0) -- timer_out to store binary value of timer
    );
end entity;

-- Architecture of BCDConverter
architecture Converter of BCDConverter is
    -- Code to convert binary to BCD
begin

    process (counter_inp, timer_inp)
        variable temp : integer range 0 to 7 := 0;
        variable count_total : integer range 0 to 255 := 0;     -- Variable to count how many times fauced was used
        variable msd, lsd, mmsd : integer range 0 to 9 := 0;    -- Variables to store the digits, MSD for store the most significant digit, 
                                                                -- LSD for store the least significant digit and 
                                                                -- MMSD for store the middle most significant digit
    begin

        timer_out <= timer_inp;                             -- Give the data from timer_inp to timer_out

        count_total := 0;                                       -- Initialize count_total to 0
        msd := 0;                                               -- Initialize msd to 0
        lsd := 0;                                               -- Initialize lsd to 0
        mmsd := 0;       
        count_total := to_integer(unsigned(counter_inp));       -- Initialize mmsd to 0

        -- Calculate the MSD
        -- input Number >= 100, will find the MSD
        if (count_total >= 100) then
            msd := count_total/100;                        -- Divide the input number by 100 to find the MSD 
            count_total := count_total - (msd*100);        -- Subtract the MMSD*100 from the input number to find the MMSD
        end if;

        -- Calculate the MMSD
        -- input Number >= 10, will find the MMSD
        if (count_total >= 10) then
            mmsd := count_total/10;                          -- Divide the input number by 10 to find the MMSD
            count_total := count_total - (mmsd*10);          -- Subtract the MSD*10 from the input number to find the LSD
        end if;

        -- Calculate the LSD
        lsd := count_total;                                 -- Sisa pembagian menjadi LSD

        -- Convert from integer to binary and give data to the output variable
        MSD_out <= std_logic_vector(to_unsigned(msd, 4));   -- Convert the MSD to binary and give the data to MSD_out, msd is the integer and 4 is the vector length
        MMSD_out <= std_logic_vector(to_unsigned(mmsd, 4)); -- Convert the MMSD to binary and give the data to MMSD_out, mmsd is the integer and 4 is the vector length
        LSD_out <= std_logic_vector(to_unsigned(lsd, 4));   -- Convert the LSD to binary and give the data to LSD_out, lsd is the integer and 4 is the vector length
        
    end process;

end architecture;