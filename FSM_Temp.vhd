LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

-- Inner FSM
ENTITY FSM_Temp IS
  PORT (
    clk : IN STD_LOGIC;
    reset : IN STD_LOGIC;
    temp_hot : IN STD_LOGIC; 
    temp_cold : IN STD_LOGIC; 
    temp_normal : IN STD_LOGIC; 
    output : OUT STD_LOGIC_VECTOR(1 DOWNTO 0)); -- "01" = cold, "10" = normal, "11" = hot
END FSM_Temp;

ARCHITECTURE behavioral OF FSM_Temp IS
  -- ST0 = State Idle; ST1 = State Cold; ST2 = State Normal; ST3 = State Hot
  TYPE state_type IS (ST0, ST1, ST2, ST3);
  SIGNAL current_state, next_state : state_type;
BEGIN
  -- The FSM State Transitions
  PROCESS (clk, reset)
  BEGIN
    IF (reset = '1') THEN
      current_state <= ST0;
    ELSIF (clk'event AND clk = '1') THEN
      current_state <= next_state;
    END IF;
  END PROCESS;

  -- FSM transition logic
  PROCESS (current_state, temp_hot, temp_cold, temp_normal)
  BEGIN
    CASE current_state IS
      WHEN ST0 => -- State Idle
        IF (temp_hot = '1') THEN
          next_state <= ST3;
        ELSIF (temp_cold = '1') THEN
          next_state <= ST1;
        ELSIF (temp_normal = '1') THEN
          next_state <= ST2;
        ELSE
          next_state <= ST0;
        END IF;

      WHEN ST1 => -- State Cold
        IF (temp_hot = '1') THEN
          next_state <= ST3;
        ELSIF (temp_cold = '1') THEN
          next_state <= ST1;
        ELSIF (temp_normal = '1') THEN
          next_state <= ST2;
        ELSE
          next_state <= ST0;
        END IF;

      WHEN ST2 => -- State Normal
        IF (temp_hot = '1') THEN
          next_state <= ST3;
        ELSIF (temp_cold = '1') THEN
          next_state <= ST1;
        ELSIF (temp_normal = '1') THEN
          next_state <= ST2;
        ELSE
          next_state <= ST0;
        END IF;

      WHEN ST3 => -- State Hot
        IF (temp_hot = '1') THEN
          next_state <= ST3;
        ELSIF (temp_cold = '1') THEN
          next_state <= ST1;
        ELSIF (temp_normal = '1') THEN
          next_state <= ST2;
        ELSE
          next_state <= ST0;
        END IF;
    END CASE;
  END PROCESS;

  -- Output logic
  output <= "00";
  PROCESS (current_state)
  BEGIN
    CASE current_state IS
      WHEN ST0 =>
        output <= "00"; -- State Idle
      WHEN ST1 =>
        output <= "01"; -- State Cold
      WHEN ST2 =>
        output <= "10"; -- State Normal
      WHEN ST3 =>
        output <= "11"; -- State Hot
END behavioral;