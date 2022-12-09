library ieee;
use ieee.std_logic_1164.all;

entity another_testbench is
end entity;

architecture testbench of another_testbench is
     -- Component declaration
     component master_faucet is
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
            LED_White : out std_logic;                      -- LED white to show the water is off
            water : out std_logic;                          -- Output as water flow
            SSD_MSD : out std_logic_vector(bit_SSD-1 downto 0);     -- SSD to show the number of hundred times
            SSD_LSD : out std_logic_vector(bit_SSD-1 downto 0);     -- SSD to show the number of one times
            SSD_MMSD : out std_logic_vector(bit_SSD-1 downto 0);    -- SSD to show the number of ten times
            SSD_Timer : out std_logic_vector(bit_SSD-1 downto 0)    -- SSD to show the number of timer
        );
    end component;

    -- Declare the signals that will be used in the testbench
    signal handSensor: std_logic;
    signal suhu: std_logic_vector(1 downto 0);
    signal switchMaster: std_logic;
    signal clock: std_logic;

    signal LED_Red: std_logic;
    signal LED_Green: std_logic;
    signal LED_Blue: std_logic;
    signal LED_White: std_logic;
    signal water: std_logic;
    signal SSD_MSD: std_logic_vector(7 downto 0);
    signal SSD_LSD: std_logic_vector(7 downto 0);
    signal SSD_MMSD: std_logic_vector(7 downto 0);
    signal SSD_Timer: std_logic_vector(7 downto 0);
begin

    -- Instantiate the master_faucet entity
    dut: entity work.master_faucet
        generic map (
            bit_SSD => 7
        )
        port map (
            handSensor => handSensor,
            suhu => suhu,
            switchMaster => switchMaster,
            clock => clock,
            LED_Red => LED_Red,
            LED_Green => LED_Green,
            LED_Blue => LED_Blue,
            LED_White => LED_White,
            water => water,
            SSD_MSD => SSD_MSD,
            SSD_LSD => SSD_LSD,
            SSD_MMSD => SSD_MMSD,
            SSD_Timer => SSD_Timer
        );

    -- Create a test case to test the functionality of the master_faucet entity
    test_case: process
    begin
        -- Initialize the input signals for State Idle
        handSensor <= '0';
        suhu <= "00";
        switchMaster <= '0';
        clock <= '0';

        -- Wait for 100 ns
        wait for 100 ns;

        -- Change the input signals for State Normal
        handSensor <= '1';
        suhu <= "10";
        switchMaster <= '1';
        clock <= '1';

        -- Wait for 100 ns
        wait for 100 ns;

        -- Change the input signals to State Idle
        handSensor <= '0';
        suhu <= "10";
        switchMaster <= '0';
        clock <= '0';

        -- Wait for 100 ns
        wait for 100 ns;

        -- Change the input signals for State Cold
        handSensor <= '1';
        suhu <= "01";
        switchMaster <= '1';
        clock <= '1';

        -- Wait for 100 ns
        wait for 100 ns;

        -- Change the input signals to State Idle
        handSensor <= '0';
        suhu <= "01";
        switchMaster <= '0';
        clock <= '0';

        -- Wait for 100 ns
        wait for 100 ns;

        -- Change the input signals for State Hot
        handSensor <= '1';
        suhu <= "11";
        switchMaster <= '1';
        clock <= '1';

        -- Wait for 100 ns
        wait for 100 ns;

        -- Change the input signals to State Idle
        handSensor <= '0';
        suhu <= "11";
        switchMaster <= '0';
        clock <= '0';

        -- Wait for 100 ns
        wait for 100 ns;

        -- Stop the test
        wait;
    end process;

end architecture;
