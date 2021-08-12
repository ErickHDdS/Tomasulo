library verilog;
use verilog.vl_types.all;
entity IQ is
    port(
        Clock           : in     vl_logic;
        enableOut       : out    vl_logic;
        instructionOut  : out    vl_logic_vector(15 downto 0);
        done            : in     vl_logic;
        disponivel      : in     vl_logic
    );
end IQ;
