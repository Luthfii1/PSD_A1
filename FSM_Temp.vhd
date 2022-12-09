LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

-- Inner FSM
ENTITY FSM_Temp IS
  PORT (
    clk : IN STD_LOGIC;
    reset : IN STD_LOGIC;
    temp : in std_logic_vector(1 downto 0); -- "01" = cold, "10" = normal, "11" = hot

    -- Outputs
    red : out std_logic;    -- if temp is hot
    green : out std_logic;  -- if temp is normal
    blue : out std_logic; -- if temp is cold
    white : out std_logic -- if temp is idle
    ); -- "01" = cold, "10" = normal, "11" = hot
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
  PROCESS (current_state, temp)
  BEGIN
    CASE current_state IS
      WHEN ST0 => -- State Idle
        IF (temp = "11") THEN    -- If temp is hot
          next_state <= ST3;
        ELSIF (temp = "01") THEN  -- If temp is cold
          next_state <= ST1;
        ELSIF (temp = "10") THEN  -- If temp is normal
          next_state <= ST2;
        ELSE                    -- If temp is idle
          next_state <= ST0;
        END IF;

      WHEN ST1 => -- State Cold
        IF (temp = "11") THEN    -- If temp is hot
          next_state <= ST3;
        ELSIF (temp = "01") THEN  -- If temp is cold
          next_state <= ST1;
        ELSIF (temp = "10") THEN  -- If temp is normal
          next_state <= ST2;
        ELSE                    -- If temp is idle
          next_state <= ST0;
        END IF;

      WHEN ST2 => -- State Normal
        IF (temp = "11") THEN    -- If temp is hot
          next_state <= ST3;
        ELSIF (temp = "01") THEN  -- If temp is cold
          next_state <= ST1;
        ELSIF (temp = "10") THEN  -- If temp is normal
          next_state <= ST2;
        ELSE                    -- If temp is idle
          next_state <= ST0;
        END IF;

      WHEN ST3 => -- State Hot
        IF (temp = "11") THEN    -- If temp is hot
          next_state <= ST3;
        ELSIF (temp = "01") THEN  -- If temp is cold
          next_state <= ST1;
        ELSIF (temp = "10") THEN  -- If temp is normal
          next_state <= ST2;
        ELSE                    -- If temp is idle
          next_state <= ST0;
        END IF;

    END CASE;
    
  END PROCESS;

  -- Output logic
  PROCESS (current_state)
  BEGIN
    CASE current_state IS
      WHEN ST0 =>
        white <= '1'; -- State Idle
        blue <= '0';
        green <= '0';
        red <= '0';
      WHEN ST1 =>
        blue <= '1'; -- State Cold
        white <= '0';
        green <= '0';
        red <= '0';
      WHEN ST2 =>
        green <= '1'; -- State Normal
        white <= '0';
        blue <= '0';
        red <= '0';
      WHEN ST3 =>
        red <= '1'; -- State Hot
        white <= '0';
        blue <= '0';
        green <= '0';
      end CASE;
  END PROCESS;
END behavioral;