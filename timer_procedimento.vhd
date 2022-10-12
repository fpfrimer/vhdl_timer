-- Simples relógio em VHDL
library ieee;
use ieee.std_logic_1164.all;

-- Entidade de projeto
entity timer_procedimento is
    generic(clockFreq   :   integer := 50e6);   -- Valor do clock de entrada, DE10 lite = 50 MHz
    port (
        clk     :   in      std_logic;      -- Sinal de clock de entrada
        nRst    :   in      std_logic;      -- Sinal de reset, ativo em nível baixo
        s, m, h :   inout   integer         -- Sinais para contar e mostrar o tempo
    );
end entity;

architecture rtl of timer_procedimento is
    
    signal ticks    :   integer;   -- Utilizando para contar os ciclos para 1 s

    -- Procedimento para incrmentar sinais
    procedure incrementa(
        signal      contador    :   inout   integer;    -- Sinal a ser incrementado por 1
        constant    maximo      :   in      integer;    -- Valor máximo do sinal
        constant    habilita    :   in      boolean;    -- Habilita o incremento
        variable    estouro     :   out     boolean) is -- indica quando houve estouro
    begin

        estouro := false;
        if habilita then
            if contador = maximo - 1 then
                estouro := true;
                contador <= 0;
            else
                contador <= contador + 1;
            end if;
        end if;
    end procedure;

begin
    
    process(clk, nRst) is
        variable controle   :   boolean;    -- Indica estouro ou quando uma contagem está habilitada
    begin

        if nRst = '0' then
            -- Reset do timer
            ticks <= 0;
            s <= 0;
            m <= 0;
            h <= 0;
        elsif rising_edge(clk) then
            -- Contagem
            incrementa(ticks, clockFreq, true, controle);
            incrementa(s, 60, controle, controle);
            incrementa(m, 60, controle, controle);
            incrementa(h, 24, controle, controle);

            
        end if;

    end process;
    
end architecture rtl;