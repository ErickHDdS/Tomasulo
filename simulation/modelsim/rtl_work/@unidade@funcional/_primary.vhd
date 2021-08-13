library verilog;
use verilog.vl_types.all;
entity UnidadeFuncional is
    port(
        clock           : in     vl_logic;
        instruction     : in     vl_logic_vector(15 downto 0);
        iIn             : in     vl_logic;
        instructionIn   : in     vl_logic_vector(2 downto 0);
        instructionOut  : out    vl_logic_vector(2 downto 0);
        done            : out    vl_logic;
        InstAtual       : out    vl_logic_vector(15 downto 0);
        \out\           : out    vl_logic_vector(15 downto 0);
        disponivelUnidadeFuncional: out    vl_logic;
        R1              : in     vl_logic_vector(15 downto 0);
        R2              : in     vl_logic_vector(15 downto 0)
    );
end UnidadeFuncional;
