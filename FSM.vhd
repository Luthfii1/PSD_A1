library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Inner FSM
entity temp_fsm is
    port(
        clk : in std_logic;
        reset : in std_logic;
        temp_hot : in std_logic;
        temp_cold : in std_logic;
        temp_normal : in std_logic;
        output : out std_logic);
end temp_fsm;
  
architecture behavioral of temp_fsm is
    type state_type is (state_normal, state_hot, state_cold);
    signal current_state, next_state : state_type;
  begin
    process(clk, reset)
    begin
      if (reset = '1') then
        current_state <= state_1;
      elsif (clk'event and clk = '1') then
        current_state <= next_state;
      end if;
    end process;
  
    -- FSM transition logic
    process(current_state, temp_hot, temp_cold, temp_normal)
    begin
      case current_state is
        when state_normal =>
            if (temp_normal = '0' and temp_hot = '1' and temp_cold = '0') then
                next_state <= state_hot;
            else if (temp_normal = '0' and temp_hot = '0' and temp_cold = '1')
                next_state <= state_cold;
            else 
                next_state <= state_normal;
            end if;
        when state_hot =>
            if (temp_normal = '1' and temp_hot = '0' and temp_cold = '0') then
                next_state <= state_normal;
            else if (temp_normal = '0' and temp_hot = '0' and temp_cold = '1')
                next_state <= state_cold;
            else
                next_state <= state_hot;
            end if;
        when state_cold =>
            if (temp_normal = '1' and temp_hot = '0' and temp_cold = '0') then
                next_state <= state_normal;
            else if (temp_normal = '0' and temp_hot = '1' and temp_cold = '0')
                next_state <= state_hot;
            else
                next_state <= state_cold;
            end if;
        when others =>
          next_state <= state_normal;
      end case;
    end process;
  
    -- Output logic
    process(current_state)
    begin
      case current_state is
        when state_normal =>
            output <= "00";
        when state_hot =>
            output <= "01";
        when state_3 =>
            output <= "10";
        when others =>
            output <= "00";
      end case;
    end process;
end behavioral;
  
-- Outer FSM
entity water_fsm is
    port(
        H : in STD_LOGIC;
        S : in STD_LOGIC;
        CLK : in STD_LOGIC;
        sseg : out STD_LOGIC_VECTOR (2 downto 0);
        W : out STD_LOGIC);
end water_fsm;
  
architecture behavioral of water_fsm is
    component temp_fsm is
      port(
        clk : in std_logic;
        reset : in std_logic;
        temp_hot : in std_logic;
        temp_cold : in std_logic;
        temp_normal : in std_logic;
        output : out std_logic
      );
    end component;
    type state_type is (ST0, ST1, ST2, ST3, ST4, ST5, ST6, ST7);
    signal PS, NS : state_type;
    signal inner_output : std_logic;
  begin
    -- Instantiate the inner FSM
    u1: temp_fsm port map(
      clk => clk,
      output => inner_output);

  