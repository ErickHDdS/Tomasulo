library verilog;
use verilog.vl_types.all;
entity FPregisters is
    port(
        clock           : in     vl_logic;
        dataIn          : in     vl_logic_vector(15 downto 0);
        dataAddress     : in     vl_logic_vector(2 downto 0);
        writeEnable     : in     vl_logic;
        R1              : out    vl_logic_vector(15 downto 0);
        R2              : out    vl_logic_vector(15 downto 0);
        R3              : out    vl_logic_vector(15 downto 0);
        R4              : out    vl_logic_vector(15 downto 0);
        R5              : out    vl_logic_vector(15 downto 0);
        R6              : out    vl_logic_vector(15 downto 0);
        R7              : out    vl_logic_vector(15 downto 0)
    );
end FPregisters;
