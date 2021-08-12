library verilog;
use verilog.vl_types.all;
entity Tomasulo is
    port(
        Clock           : in     vl_logic;
        done            : out    vl_logic;
        enable          : in     vl_logic;
        regValue        : out    vl_logic_vector(15 downto 0)
    );
end Tomasulo;
