-- Simples relógio em VHDL
library ieee;
use ieee.std_logic_1164.all;

-- Entidade de projeto
entity timer is
    generic(clockFreq   :   integer := 50e6);   -- Valor do clock de entrada, DE10 lite = 50 MHz
    port (
        clk     :   in      std_logic;      -- Sinal de clock de entrada
        nRst    :   in      std_logic;      -- Sinal de reset, ativo em nível baixo
        s, m, h :   inout   integer range 0 to 60       -- Sinais para contar e mostrar o tempo
    );
end entity timer;

architecture rtl of timer is
    signal ticks    :   integer range 0 to clockFreq;   -- Utilizando para contar os ciclos para 1 s
begin
    
    process(clk, nRst) is
    begin

        if nRst = '0' then
            -- Reset do timer
            ticks <= 0;
            s <= 0;
            m <= 0;
            h <= 0;
        elsif rising_edge(clk) then
            -- Contagem
            if ticks = clockFreq - 1 then   -- Conta 1 s
                ticks <= 0;
                if s = 59 then              -- Conta 1 min
                    s <= 0;
                    if m = 59 then          -- Conta 1 h
                        m <= 0;
                        if h = 23 then      -- Conta 1 dia
                            h <= 0;
                        else
                            h <= h + 1;
                        end if;
                    else
                        m <= m + 1;
                    end if;
                else
                    s <= s + 1;
                end if;
            else 
                ticks <= ticks + 1;
            end if;
        end if;

    end process;
    
end architecture rtl;