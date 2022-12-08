-- library that we are using
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

-- entity that we are using
entity timer is
    port (
        -- Inputs
        clk   : in std_logic;   -- clock input
        sensor : in std_logic;  -- sensor input
        switch : in std_logic;  -- switch input

        -- Outputs
        timer : out std_logic_vector (3 downto 0); -- clock output for timer
        counter : out std_logic_vector(7 downto 0)   -- clock output for counter
    );
end entity;

-- Update
-- architecture of timer
architecture rtl of timer is
    constant reset_timer : integer := 0;  -- max value for timer is 7 seconds
    constant max_counter : integer := 255;  -- max value for counter (255, using 3 ssd)
begin
    -- process for timer
    my_timer : process (clk, sensor, switch)
        variable count : integer := 7;          -- variable for timer
        variable count_counter : integer := 0;  -- variable for counter
    begin
        if (sensor = '1' and switch = '1') then
            if (rising_edge(clk)) then          -- if clock is rising edge will execute
                if (count = reset_timer) then   -- if count is 0, will reset to 7 
                    count := 7;                 -- reset count to 7
                    if(count_counter = max_counter) then    -- if count_counter is 255, will reset to 0
                        count_counter := 0;                 -- reset count_counter to 0
                    else                                    -- else will increment count_counter
                        count_counter := count_counter + 1; -- increment count_counter
                    end if;
                else                        -- else will decrement count for timer
                    count := count - 1;     -- decrement count
                end if;
            end if;
            timer <= std_logic_vector(to_unsigned(count, 4));           -- convert count for timer to std_logic_vector
            counter <= std_logic_vector(to_unsigned(count_counter, 8)); -- convert count_counter for counter to std_logic_vector
        else
            timer <= (others => '0');   -- if sensor or switch is 0, will reset timer to 0
            counter <= (others => '0'); -- if sensor or switch is 0, will reset counter to 0
            count := 7;                 -- reset count to 7
        end if;

    end process;

end architecture;