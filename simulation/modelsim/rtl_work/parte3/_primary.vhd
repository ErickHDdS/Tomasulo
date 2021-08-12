library verilog;
use verilog.vl_types.all;
entity parte3 is
    port(
        clock           : in     vl_logic;
        enable          : in     vl_logic;
        done            : out    vl_logic;
        regValue        : out    vl_logic_vector(15 downto 0)
    );
end parte3;
