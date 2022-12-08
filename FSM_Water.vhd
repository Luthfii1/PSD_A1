LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

-- Outer FSM
ENTITY water_fsm IS
    PORT (
        H : IN STD_LOGIC; -- Sensor Tangan
        S : IN STD_LOGIC; -- Kran Air
        CLK : IN STD_LOGIC;
        sseg : OUT STD_LOGIC_VECTOR (2 DOWNTO 0);
        W : OUT STD_LOGIC_VECTOR(1 DOWNTO 0)); -- Air keluar dalam "01" = cold, "10" = normal, "11" = hot
END water_fsm;

ARCHITECTURE behavioral OF water_fsm IS
    COMPONENT temp_fsm IS
        PORT (
            clk : IN STD_LOGIC;
            reset : IN STD_LOGIC;
            temp_hot : IN STD_LOGIC;
            temp_cold : IN STD_LOGIC;
            temp_normal : IN STD_LOGIC;
            output : OUT STD_LOGIC_VECTOR(1 DOWNTO 0)
        );
    END COMPONENT;
    TYPE state_type IS (ST0, ST1, ST2, ST3, ST4);
    SIGNAL current_state, next_state : state_type;
    SIGNAL inner_output : STD_LOGIC_VECTOR;
BEGIN
    -- Instantiate the inner FSM
    u1 : temp_fsm PORT MAP(
        clk => clk,
        reset => reset,
        temp_hot => temp_hot,
        temp_cold => temp_cold,
        temp_normal => temp_normal,
        output => inner_output);

    -- The outer FSM logic
    PROCESS (clk, reset)
    BEGIN
        IF (reset = '1') THEN
            current_state <= ST0;
        ELSIF (rising_edge(clk)) THEN
            current_state <= next_state;
        END IF;
    END PROCESS;

    -- Input logic
    H <= '0';
    S <= '0';

    -- The FSM state transitions
    PROCESS (current_state, inner_output)
    BEGIN
        CASE current_state IS
            WHEN ST0 => -- State Awal
                IF (H = '1') THEN
                    next_state <= ST1;
                END IF;

            WHEN ST1 => -- State Normal
                S <= '1';
                IF (S = '1' AND inner_output = "001") THEN
                    next_state <= ST2; -- Ke State Cold
                ELSIF (S = '1' AND inner_output = "011") THEN
                    next_state <= ST3; -- Ke State Hot
                END IF;

            WHEN ST2 => -- State Cold
                IF (S = '1' AND inner_output = "010") THEN
                    next_state <= ST1; -- Ke State Normal
                ELSIF (S = '1' AND inner_output = "011") THEN
                    next_state <= ST3; -- Ke State Hot
                END IF;

            WHEN ST3 => -- State Hot
                IF (S = '1' AND inner_output = "010") THEN
                    next_state <= ST1; -- Ke State Normal
                ELSIF (S = '1' AND inner_output = "001") THEN
                    next_state <= ST2; -- Ke State Cold
                END IF;

            WHEN ST4 => -- State Akhir
                IF (H = '0') THEN
                    next_state <= ST0;
                END IF;
        END CASE;
    END PROCESS;

    -- Output logic
    W <= "00";
    sseg <= "000";
    PROCESS (current_state, inner_output)
    BEGIN
        CASE current_state IS
            WHEN ST0 => W <= "00" -- Tidak Keluar Air
                AND sseg <= "000"
        END IF;

        WHEN ST1 =>
        IF (inner_output = "001") THEN
            W <= "01"; -- Air Dingin
            sseg <= "001";
        ELSIF (inner_output = "010") THEN
            W <= "10"; -- Air Normal
            sseg <= "010";
        ELSIF (inner_output = "011") THEN
            W <= "11"; -- Air Panas
            sseg <= "011";
        END IF;

        WHEN ST2 =>
        IF (inner_output = "001") THEN
            W <= "01"; -- Air Dingin
            sseg <= "001";
        ELSIF (inner_output = "010") THEN
            W <= "10"; -- Air Normal
            sseg <= "010";
        ELSIF (inner_output = "011") THEN
            W <= "11"; -- Air Panas
            sseg <= "011";
        END IF;

        WHEN ST3 =>
        IF (inner_output = "001") THEN
            W <= "01"; -- Air Dingin
            sseg <= "001";
        ELSIF (inner_output = "010") THEN
            W <= "10"; -- Air Normal
            sseg <= "010";
        ELSIF (inner_output = "011") THEN
            W <= "11"; -- Air Panas
            sseg <= "011";
        END IF;

        WHEN ST4 => W <= "00" -- Tidak Keluar Air
        AND sseg <= "000"
    END IF;
END CASE;
END PROCESS;

END behavioral;