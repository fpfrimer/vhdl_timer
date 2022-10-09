-- Testbench para o relógio timer.vhd
library ieee;
use ieee.std_logic_1164.all;

entity timer_tb is
end entity;

architecture sim of timer_tb is

    constant clockFreq      :   integer := 10;   -- Entrada de clock do projeto, para simulação
    constant clkPer         :   time    := 1000 ms / clockFreq; -- Período de clock

    signal clk, nRst        :   std_logic   := '0';

    signal s, m, h          :   integer;

begin

    -- Dispositivo em teste (Device under test):
    -- i_timer:    entity work.timer(rtl)  
    i_timer:    entity work.timer_procedimento(rtl) 
        generic map(clockFreq)
        port map(clk, nRst, s, m, h);

    -- Geração do clock na simulação
    clk <= not clk after clkPer / 2;

    -- Geração do sinal de reset logo no início da simulação:
    process is
    begin
        wait until rising_edge(clk);
        wait until rising_edge(clk);

        -- Sair do reset:
        nRst <= '1';
    end process;

end architecture;