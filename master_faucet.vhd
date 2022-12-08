-- MASIH GA SESUAI
-- Add some new file, to see what happen in git
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

-- Input and Output
entity master_faucet is
    generic (
        -- Generic input
        bit_SSD : integer := 7    -- Temperature input to set the temperature
    );
    port (
        -- Input
        handSensor : in std_logic;                  -- Sensor input to detect hands or object
        suhu : in std_logic_vector(1 downto 0);     -- Temperature input to set the temperature
        switchMaster : in std_logic;                -- Switch input to turn on or off the faucet
        clock : in std_logic;                       -- Clock input to count the time

        -- Output
        LED_Red : out std_logic;                        -- LED red to show the water is hot
        LED_Green : out std_logic;                      -- LED green to show the water is default (netral)
        LED_Blue : out std_logic;                       -- LED blue to show the water is cold
        water : out std_logic;                          -- Output as water flow
        SSD_MSD : out std_logic_vector(bit_SSD-1 downto 0);     -- SSD to show the number of hundred times
        SSD_LSD : out std_logic_vector(bit_SSD-1 downto 0);     -- SSD to show the number of one times
        SSD_MMSD : out std_logic_vector(bit_SSD-1 downto 0);    -- SSD to show the number of ten times
        SSD_Timer : out std_logic_vector(bit_SSD-1 downto 0)    -- SSD to show the number of timer
    );
end entity;

-- Architecture of the master_faucet that will be implemented
architecture rtl of master_faucet is
    -- Component declaration of the timer
        component timer is
            port (
                -- Inputs
                clk   : in std_logic;   -- clock input
                sensor : in std_logic;  -- sensor input
                switch : in std_logic;  -- switch input
        
                -- Outputs
                timer : out std_logic_vector (3 downto 0); -- clock output for timer
                counter : out std_logic_vector(7 downto 0)   -- clock output for counter
            );
        end component timer;

    -- Component declaration of the BCDConverter
    component BCDConverter is
        port (
            -- Input that will be converted to BCD
            counter_inp  : in std_logic_vector(7 downto 0);  -- Left bit is the MSB and the right bit is the LSB, counter_input to store the input value of the counter

            -- Output that will be converted to BCD
            MSD_out      : out std_logic_vector(3 downto 0); -- MSD_out to store binary value of most significant digit
            LSD_out      : out std_logic_vector(3 downto 0); -- LSD_out to store binary value of least significant digit
            MMSD_out     : out std_logic_vector(3 downto 0) -- MMSD_out to store binary value of middle most significant digit
        );
    end component BCDConverter;

    -- Component declaration of the 7-segment display
    component BCDtoSevseg is
        port(
            bin_in : in  std_logic_vector(3 downto 0);
            seg_out : out std_logic_vector(6 downto 0)
        );
    end component;

    -- Signal declaration
    signal timer_temp : std_logic_vector(3 downto 0);     -- timer signal to store the value of timer
    signal counter_temp : std_logic_vector(7 downto 0);   -- counter signal to store the value of counter
    signal MSD_temp : std_logic_vector(3 downto 0);       -- MSD signal to store the value of most significant digit
    signal LSD_temp : std_logic_vector(3 downto 0);       -- LSD signal to store the value of least significant digit
    signal MMSD_temp : std_logic_vector(3 downto 0);      -- MMSD signal to store the value of middle most significant digit
begin

    -- port mapping of timer
    timePM : timer port map (
        clk => clock,
        sensor => handSensor,
        switch => switchMaster,
        timer => timer_temp,
        counter => counter_temp
    );

    -- port mapping of the BCDConverter
    Converter : BCDConverter port map (
        counter_inp => counter_temp,
        MSD_out => MSD_temp,
        LSD_out => LSD_temp,
        MMSD_out => MMSD_temp
    );

    -- port mapping of the 7-segment display MSD
    MSD : BCDtoSevseg port map (
        bin_in => MSD_temp,
        seg_out => SSD_MSD
    );

    -- port mapping of the 7-segment display MMSD
    MMSD : BCDtoSevseg port map (
        bin_in => MMSD_temp,
        seg_out => SSD_MMSD
    );

    -- port mapping of the 7-segment display LSD
    LSD : BCDtoSevseg port map (
        bin_in => LSD_temp,
        seg_out => SSD_LSD
    );

    -- port mapping of the 7-segment display timer
    TIME : BCDtoSevseg port map (
        bin_in => timer_temp,
        seg_out => SSD_Timer
    );

    -- Set Suhu to LED
    LED_Red <= '1' when suhu = "11" else '0';           -- LED red to show the water is hot when suhu = 11
    LED_Blue <= '1' when suhu = "10" else '0';          -- LED blue to show the water is cold when suhu = 10
    LED_Green <= '1' when suhu = "01" else '0'; -- LED green to show the water is default (netral) when suhu = 01 or 00

    -- Set water flow
    my_timer : process (handSensor, switchMaster, clock)
    begin
        if (handSensor = '1' and switchMaster = '1') then
            water <= '1';
        else
            water <= '0';
        end if;
    end process;

end architecture;