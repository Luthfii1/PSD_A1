-- This is a simple example of a VHDL testbench for the program
    library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;
    use ieee.math_real.all;
    
    -- entity declaration
    entity testbench is
    end entity;
    
    -- architecture declaration
    architecture finalTB of testbench is
    
        -- Component declaration
        component master_faucet is
            generic (
                -- Generic input
                bit_SSD : integer := 7    -- Temperature input to set the temperature
            );
            port (
                -- Input
                handSensor : in std_logic;                  -- Sensor input to detect hands or object
                suhu : in std_logic_vector(1 downto 0);     -- Temperature input to set the temperature 00 = idle, 01 = cold, 10 = normal, 11 = hot
                switchMaster : in std_logic;                -- Switch input to turn on or off the faucet
                clock : in std_logic;                       -- Clock input to count the time
        
                -- Output
                LED_Red : out std_logic;                        -- LED red to show the water is hot
                LED_Green : out std_logic;                      -- LED green to show the water is default (netral)
                LED_Blue : out std_logic;                       -- LED blue to show the water is cold
                LED_White : out std_logic;                      -- LED white to show the water is off
                water : out std_logic;                          -- Output as water flow
                SSD_MSD : out std_logic_vector(bit_SSD-1 downto 0);     -- SSD to show the number of hundred times 
                SSD_MMSD : out std_logic_vector(bit_SSD-1 downto 0);    -- SSD to show the number of ten times
                SSD_LSD : out std_logic_vector(bit_SSD-1 downto 0);     -- SSD to show the number of one times 
                SSD_Timer : out std_logic_vector(bit_SSD-1 downto 0)    -- SSD to show the number of timer
            );
        end component;
    
        -- signal declaration
        signal handSensor : std_logic := '0';
        signal suhu : std_logic_vector(1 downto 0) := "00";
        signal switchMaster : std_logic := '0';
        signal clock : std_logic := '0';
        signal LED_Red : std_logic;
        signal LED_Green : std_logic;
        signal LED_Blue : std_logic;
        signal LED_White : std_logic;
        signal water : std_logic;
        signal SSD_MSD : std_logic_vector(6 downto 0);
        signal SSD_LSD : std_logic_vector(6 downto 0);
        signal SSD_MMSD : std_logic_vector(6 downto 0);
        signal SSD_Timer : std_logic_vector(6 downto 0);
        type outp_bench_sevseg is array (0 to 10) of std_logic_vector(6 downto 0);
        signal trycatch : integer := 0;
    begin
    
        
        -- Component instantiation
        UUT : master_faucet generic map (7) port map (
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
    
        tb_try : process
            constant pause : time := 100 ns;
            constant benchSSD : outp_bench_sevseg := (
                "1111110", "0110000", "1101101", "1111001", "0110011", 
                "1011011", "1011111", "1110000", "1111111", "1111011", "0000000"
            );
    
            
        begin
            
            -- test case 0
            wait for pause;
            handSensor <= '0';
            suhu <= "00";
            switchMaster <= '0';
            assert (SSD_MSD = benchSSD(0) and SSD_LSD = benchSSD(0) and SSD_MMSD = benchSSD(0) and SSD_Timer = benchSSD(0) and LED_Red = '0' and LED_Green = '0' and LED_Blue = '0' and LED_White = '1' and water = '0')
                    report "Netnot pada input ke-" & integer'image(trycatch)
                    severity Warning;
    
            
            -- test case 1 (suhu dingin dan timer mulai dari7)
            wait for pause;
            handSensor <= '1';
            suhu <= "01";
            switchMaster <= '1';
            trycatch <=  trycatch + 1;
            assert (SSD_MSD = benchSSD(0) and SSD_LSD = benchSSD(0) and SSD_MMSD = benchSSD(0) and SSD_Timer = benchSSD(7) and LED_Red = '0' and LED_Green = '0' and LED_Blue = '1' and LED_White = '0' and water = '1')
                    report "Netnot pada input ke-" & integer'image(trycatch)
                    severity Warning;

            -- test case 2 (suhu normal, timer ke 6)
            wait for pause;
            suhu <= "10";
            trycatch <=  trycatch + 1;
            assert (SSD_MSD = benchSSD(0) and SSD_LSD = benchSSD(0) and SSD_MMSD = benchSSD(0) and SSD_Timer = benchSSD(6) and LED_Red = '0' and LED_Green = '1' and LED_Blue = '0' and LED_White = '0' and water = '1')
                    report "Netnot pada input ke-" & integer'image(trycatch)
                    severity Warning;

            -- test case 3 (suhu panas, timer ke 5)
            wait for pause;
            suhu <= "11";
            trycatch <=  trycatch + 1;
            assert (SSD_MSD = benchSSD(0) and SSD_LSD = benchSSD(0) and SSD_MMSD = benchSSD(0) and SSD_Timer = benchSSD(5) and LED_Red = '1' and LED_Green = '0' and LED_Blue = '0' and LED_White = '0' and water = '1')
                    report "Netnot pada input ke-" & integer'image(trycatch)
                    severity Warning;
            
            wait;



            -- for i in 7 downto 0 loop
            --     trycatch <=  trycatch + 1;
            --     wait for pause;
            --     assert (SSD_MSD = benchSSD(0) and SSD_LSD = benchSSD(0) and SSD_MMSD = benchSSD(0) and SSD_Timer = benchSSD(i) and LED_Red = '0' and LED_Green = '0' and LED_Blue = '1' and LED_White = '0' and water = '1')
            --             report "Netnot pada time ke-" & integer'image(trycatch)
            --             severity Warning;
            -- end loop;
    
            -- trycatch <=  trycatch + 1;
            -- -- test case 3 (suhu panas dan timer terset dan counter + 1)
            -- suhu <= "11";
            -- wait for pause;
            --     assert (SSD_MSD = benchSSD(0) and SSD_LSD = benchSSD(1) and SSD_MMSD = benchSSD(0) and SSD_Timer = benchSSD(7) and LED_Red = '1' and LED_Green = '0' and LED_Blue = '0' and LED_White = '0' and water = '1')
            --             report "Netnot pada time ke-" & integer'image(trycatch)
            --             severity Warning;
    
            -- -- test case 4 (suhu normal dan timer terset dari 6 ke 0)
            -- suhu <= "10";
            -- for i in 6 downto 0 loop
            --     trycatch <=  trycatch + 1;
            --     wait for pause;
            --     assert (SSD_MSD = benchSSD(0) and SSD_LSD = benchSSD(1) and SSD_MMSD = benchSSD(0) and SSD_Timer = benchSSD(i) and LED_Red = '0' and LED_Green = '1' and LED_Blue = '0' and LED_White = '0' and water = '1')
            --             report "Netnot pada time ke-" & integer'image(trycatch)
            --             severity Warning;
            -- end loop;
    
            -- -- test case 5 (suhu dingin dan timer tereset dan counter + 1)
            -- suhu <= "01";
            -- wait for pause;
            --     assert (SSD_MSD = benchSSD(0) and SSD_LSD = benchSSD(2) and SSD_MMSD = benchSSD(0) and SSD_Timer = benchSSD(7) and LED_Red = '1' and LED_Green = '0' and LED_Blue = '1' and LED_White = '0' and water = '1')
            --             report "Netnot pada time ke-" & integer'image(0)
            --             severity Warning;
    
            -- -- test case 6 (suhu normal dan timer terset dari 6 ke 0)
            -- suhu <= "10";
            -- for i in 6 downto 0 loop
            --     wait for pause;
            --     assert (SSD_MSD = benchSSD(0) and SSD_LSD = benchSSD(2) and SSD_MMSD = benchSSD(0) and SSD_Timer = benchSSD(i) and LED_Red = '0' and LED_Green = '1' and LED_Blue = '0' and LED_White = '0' and water = '1')
            --             report "Netnot pada time ke-" & integer'image(0)
            --             severity Warning;
            -- end loop;
            -- wait;
        end process;
    
    end architecture;