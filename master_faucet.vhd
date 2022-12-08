-- Add some new file, to see what happen in git
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

-- Input and Output
entity master_faucet is
    port (
        -- Input
        sensor : in std_logic;                  -- Sensor input to detect hands or object
        suhu : in std_logic_vector(1 downto 0); -- Temperature input to set the temperature
        switch : in std_logic;                  -- Switch input to turn on or off the faucet
        clock : in std_logic;                   -- Clock input to count the time

        -- Output
        LED_Red : out std_logic;                    -- LED red to show the water is hot
        water : out std_logic;                      -- Output as water flow
        SSD_MSD : out std_logic_vector(6 downto 0); -- SSD to show the number of hundred times
        SSD_LSD : out std_logic_vector(6 downto 0); -- SSD to show the number of one times
        SSD_MMSD : out std_logic_vector(6 downto 0);  -- SSD to show the number of ten times
        SSD_Timer : out std_logic_vector(6 downto 0)    -- SSD to show the number of timer
    );
end entity;

architecture rtl of master_faucet is

    -- Component declaration of BCDConverter
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

    

end architecture;