 //Implement a single-stage pipeline register in SystemVerilog using a standard valid/ready handshake. 

module pipeline_reg #(
    parameter WIDTH = 8
)(
    input  logic clk,
    input  logic rst_n,

    // Input interface
    input  logic             in_valid,
    output logic             in_ready,
    input  logic [WIDTH-1:0] in_data,

    // Output interface
    output logic             out_valid,
    input  logic             out_ready,
    output logic [WIDTH-1:0] out_data
);

logic out_valid_nxt;
logic [WIDTH-1:0] out_data_nxt;

// Sequential
always_ff @(posedge clk or negedge rst_n) begin
    if(!rst_n) begin
        out_valid <= 0;
        out_data  <= 0;
    end
    else begin
        out_valid <= out_valid_nxt;
        out_data  <= out_data_nxt;
    end
end

// Ready logic
assign in_ready = ~out_valid || out_ready;

// Next state logic
assign out_valid_nxt = in_ready ? in_valid : out_valid;
assign out_data_nxt  = (in_valid && in_ready) ? in_data : out_data;

endmodule