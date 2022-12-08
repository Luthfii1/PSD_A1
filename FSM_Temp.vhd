LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

-- Inner FSM
ENTITY FSM_Temp IS
  PORT (
    clk : IN STD_LOGIC;
    reset : IN STD_LOGIC;
    temp_hot : IN STD_LOGIC_VECTOR(1 DOWNTO 0); -- "11"
    temp_cold : IN STD_LOGIC_VECTOR(1 DOWNTO 0); -- "01"
    temp_normal : IN STD_LOGIC_VECTOR(1 DOWNTO 0); --"10"
    output : OUT STD_LOGIC_VECTOR(1 DOWNTO 0));
END FSM_Temp;

ARCHITECTURE behavioral OF FSM_Temp IS
  TYPE state_type IS (state_normal, state_hot, state_cold);
  SIGNAL current_state, next_state : state_type;
BEGIN
  PROCESS (clk, reset)
  BEGIN
    IF (reset = '1') THEN
      current_state <= state_normal;
    ELSIF (clk'event AND clk = '1') THEN
      current_state <= next_state;
    END IF;
  END PROCESS;

  -- FSM transition logic
  PROCESS (current_state, temp_hot, temp_cold, temp_normal)
  BEGIN
    CASE current_state IS
      WHEN state_normal =>
        IF (temp_normal = '0' AND temp_hot = '1' AND temp_cold = '0') THEN
          next_state <= state_hot;
        ELSE
          IF (temp_normal = '0' AND temp_hot = '0' AND temp_cold = '1') THEN
            next_state <= state_cold;
          ELSE
            next_state <= state_normal;
        END IF;
      WHEN state_hot =>
        IF (temp_normal = '1' AND temp_hot = '0' AND temp_cold = '0') THEN
          next_state <= state_normal;
        ELSE
          IF (temp_normal = '0' AND temp_hot = '0' AND temp_cold = '1')
            next_state <= state_cold;
          ELSE
            next_state <= state_hot;
        END IF;
      WHEN state_cold =>
        IF (temp_normal = '1' AND temp_hot = '0' AND temp_cold = '0') THEN
          next_state <= state_normal;
        ELSE
          IF (temp_normal = '0' AND temp_hot = '1' AND temp_cold = '0')
            next_state <= state_hot;
          ELSE
            next_state <= state_cold;
          END IF;
      WHEN OTHERS =>
        next_state <= state_normal;
    END CASE;
  END PROCESS;

  -- Output logic
  output <= "01" WHEN current_state = state_cold ELSE
            "10" WHEN current_state = state_normal ELSE
            "11" WHEN current_state = state_hot;
END behavioral;