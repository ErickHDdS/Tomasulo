library verilog;
use verilog.vl_types.all;
entity FilaInstrucao is
    port(
        clock           : in     vl_logic;
        outLiberado     : out    vl_logic;
        instructionOut  : out    vl_logic_vector(15 downto 0);
        disponibilidade : in     vl_logic
    );
end FilaInstrucao;
