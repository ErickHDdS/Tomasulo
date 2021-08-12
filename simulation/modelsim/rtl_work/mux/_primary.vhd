library verilog;
use verilog.vl_types.all;
entity mux is
    port(
        R1              : in     vl_logic_vector(15 downto 0);
        R2              : in     vl_logic_vector(15 downto 0);
        R3              : in     vl_logic_vector(15 downto 0);
        R4              : in     vl_logic_vector(15 downto 0);
        R5              : in     vl_logic_vector(15 downto 0);
        R6              : in     vl_logic_vector(15 downto 0);
        R7              : in     vl_logic_vector(15 downto 0);
        Raddr           : in     vl_logic_vector(2 downto 0);
        Rout            : out    vl_logic_vector(15 downto 0)
    );
end mux;
