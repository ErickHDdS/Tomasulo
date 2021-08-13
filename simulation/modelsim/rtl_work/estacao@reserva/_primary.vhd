library verilog;
use verilog.vl_types.all;
entity estacaoReserva is
    port(
        instruction     : in     vl_logic_vector(15 downto 0);
        Clock           : in     vl_logic;
        Adderin         : in     vl_logic;
        R1              : in     vl_logic_vector(15 downto 0);
        R2              : in     vl_logic_vector(15 downto 0);
        R3              : in     vl_logic_vector(15 downto 0);
        R4              : in     vl_logic_vector(15 downto 0);
        R5              : in     vl_logic_vector(15 downto 0);
        R6              : in     vl_logic_vector(15 downto 0);
        R7              : in     vl_logic_vector(15 downto 0);
        instOutEnable   : out    vl_logic;
        instOut         : out    vl_logic_vector(15 downto 0);
        done            : out    vl_logic;
        dout            : out    vl_logic_vector(15 downto 0);
        disponivel      : out    vl_logic;
        doneInst        : out    vl_logic_vector(15 downto 0)
    );
end estacaoReserva;
