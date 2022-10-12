-- Entidade top level
library ieee;
use ieee.std_logic_1164.all;

entity timer_top is
    port (
        clk, nRst   :   in  std_logic;
        u_sec, d_sec:  out  std_logic_vector(0 to 6);
        u_min, d_min:  out  std_logic_vector(0 to 6);
        u_hr, d_hr  :  out  std_logic_vector(0 to 6)
    );
end entity timer_top;

architecture rtl of timer_top is
    signal segundo, minuto, hora :    integer;
begin
    
    decod_s:    entity work.decodificador(rtl)
        port map(segundo, d_sec, u_sec);

    decod_m:    entity work.decodificador(rtl)
        port map(minuto, d_min, u_min);

    decod_h:    entity work.decodificador(rtl)
        port map(hora, d_hr, u_hr);

    timer_0:    entity work.timer(rtl)
        generic map(50e6)
        port map(clk, nRst, segundo, minuto, hora);    
    
end architecture rtl;