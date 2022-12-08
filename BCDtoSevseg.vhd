-- This is a generic seven-segment display module that takes a 4-bit BCD value as input
-- and outputs the corresponding 7-segment display pattern.

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_1164.STD_ULOGIC;

ENTITY bcd_to_seven_segment IS
  GENERIC (
    -- The number of BCD digits to convert
    num_digits : INTEGER := 4
  );
  PORT (
    -- The BCD input value
    msd_input : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    mmsd_input : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    lsd_input : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    timer_input : IN STD_LOGIC_VECTOR(3 DOWNTO 0);

    -- The 7-segment display pattern output
    msd_out : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
    mmsd_out : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
    lsd_out : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
    timer_out : OUT STD_LOGIC_VECTOR(6 DOWNTO 0)
  );
END ENTITY bcd_to_seven_segment;

ARCHITECTURE behavioral OF bcd_to_seven_segment IS
BEGIN

  -- Convert each BCD digit to the corresponding 7-segment display pattern
  PROCESS (msd_input) IS
  BEGIN
    -- Initialize the output to all '0's
    msd_out <= (OTHERS => '0');

    -- Loop through each BCD digit
      -- Convert the BCD digit to the corresponding 7-segment display pattern
      CASE msd_input IS
        WHEN "0000" => msd_out <= "0111111";
        WHEN "0001" => msd_out <= "0000110";
        WHEN "0010" => msd_out <= "1011011";
        WHEN "0011" => msd_out <= "1001111";
        WHEN "0100" => msd_out <= "1100110";
        WHEN "0101" => msd_out <= "1101101";
        WHEN "0110" => msd_out <= "1111101";
        WHEN "0111" => msd_out <= "0000111";
        WHEN "1000" => msd_out <= "1111111";
        WHEN "1001" => msd_out <= "1101111";
        WHEN OTHERS => msd_out <= "0000000";
      END CASE;
  END PROCESS;

  PROCESS (mmsd_input) IS
  BEGIN
    -- Initialize the output to all '0's
    mmsd_out <= (OTHERS => '0');

    -- Loop through each BCD digit
      -- Convert the BCD digit to the corresponding 7-segment display pattern
      CASE mmsd_input IS
        WHEN "0000" => mmsd_out <= "0111111";
        WHEN "0001" => mmsd_out <= "0000110";
        WHEN "0010" => mmsd_out <= "1011011";
        WHEN "0011" => mmsd_out <= "1001111";
        WHEN "0100" => mmsd_out <= "1100110";
        WHEN "0101" => mmsd_out <= "1101101";
        WHEN "0110" => mmsd_out <= "1111101";
        WHEN "0111" => mmsd_out <= "0000111";
        WHEN "1000" => mmsd_out <= "1111111";
        WHEN "1001" => mmsd_out <= "1101111";
        WHEN OTHERS => mmsd_out <= "0000000";
      END CASE;
  END PROCESS;

  PROCESS (lsd_input) IS
  BEGIN
    -- Initialize the output to all '0's
    lsd_out <= (OTHERS => '0');

    -- Loop through each BCD digit
      -- Convert the BCD digit to the corresponding 7-segment display pattern
      CASE lsd_input IS
        WHEN "0000" => lsd_out <= "0111111";
        WHEN "0001" => lsd_out <= "0000110";
        WHEN "0010" => lsd_out <= "1011011";
        WHEN "0011" => lsd_out <= "1001111";
        WHEN "0100" => lsd_out <= "1100110";
        WHEN "0101" => lsd_out <= "1101101";
        WHEN "0110" => lsd_out <= "1111101";
        WHEN "0111" => lsd_out <= "0000111";
        WHEN "1000" => lsd_out <= "1111111";
        WHEN "1001" => lsd_out <= "1101111";
        WHEN OTHERS => lsd_out <= "0000000";
      END CASE;
  END PROCESS;

  PROCESS (timer_input) IS
  BEGIN
    -- Initialize the output to all '0's
    timer_out <= (OTHERS => '0');

    -- Loop through each BCD digit
      -- Convert the BCD digit to the corresponding 7-segment display pattern
      CASE timer_input IS
        WHEN "0000" => timer_out <= "0111111";
        WHEN "0001" => timer_out <= "0000110";
        WHEN "0010" => timer_out <= "1011011";
        WHEN "0011" => timer_out <= "1001111";
        WHEN "0100" => timer_out <= "1100110";
        WHEN "0101" => timer_out <= "1101101";
        WHEN "0110" => timer_out <= "1111101";
        WHEN "0111" => timer_out <= "0000111";
        WHEN "1000" => timer_out <= "1111111";
        WHEN "1001" => timer_out <= "1101111";
        WHEN OTHERS => timer_out <= "0000000";
      END CASE;
  END PROCESS;

END ARCHITECTURE behavioral;