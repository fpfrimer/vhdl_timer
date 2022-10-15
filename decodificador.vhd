-- Decodificador para mostrar as horas do relógio nos display do kit de10 lite
library ieee;
use ieee.std_logic_1164.all;

entity decodificador is
	 generic(maximo	:	integer := 60);
    port (
        contador    :   in  integer range 0 to maximo;    -- pode ser h, m, s
        dezena      :   out std_logic_vector(0 to 6);
        unidade     :   out std_logic_vector(0 to 6)
    );
end entity decodificador;

architecture rtl of decodificador is
    -- Procedimento para decodificar dezena ou unidade do s, m ou h
    procedure decodificando(
        constant valor  :   in  integer;
        signal   saida  :   out std_logic_vector(0 to 6)
    ) is
    begin
        case(valor) is
            when 0 => saida <= not "1111110";
            when 1 => saida <= not "0110000";
            when 2 => saida <= not "1101101";
            when 3 => saida <= not "1111001";
            when 4 => saida <= not "0110011";
            when 5 => saida <= not "1011011";
            when 6 => saida <= not "1011111";
            when 7 => saida <= not "1110000";
            when 8 => saida <= not "1111111";
            when 9 => saida <= not "1111011";

            when others => saida <= not "0000000";
        end case;

    end procedure;

begin

    process(contador) is
        variable d, u : integer;
    begin
        d := contador / 10;
        u := contador mod 10;
        decodificando(d, dezena);
        decodificando(u, unidade);
    end process;
    
    
    
end architecture rtl;