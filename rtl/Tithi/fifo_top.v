
module fifo_top #(
    parameter datasize = 8,
    parameter addressize = 4
)(
input wclk,
input rclk,
input rinc,
input winc,
input rst,
input [datasize-1:0] wdata,
output [datasize-1:0] rdata,
output wfull,
output rempty
);

wire [addressize:0] wbin;
wire [addressize:0] rbin;
wire [addressize:0] wgray;
wire [addressize:0] rgray;
wire [addressize:0] w_rptr2;
wire [addressize:0] r_wptr2;
wire wen;
wire ren;

assign wen = winc && !wfull;
assign ren = rinc && !rempty;

writeptr #(
    .addressize(addressize)
) writeptr1 (
    .wclk(wclk),
    .winc(winc),
    .rst(rst),
    .w_rptr2(w_rptr2),
    .wbin(wbin),
    .wgray(wgray),
    .wfull(wfull)
);

readptr #(
    .addressize(addressize)
) readptr1 (
    .rclk(rclk),
    .rst(rst),
    .rinc(rinc),
    .r_wptr2(r_wptr2),
    .rbin(rbin),
    .rgray(rgray),
    .rempty(rempty)
);

syncwptr_rd #(
    .addressize(addressize)
) syncwptr_rd1 (
    .rclk(rclk),
    .wgray(wgray),
    .rst(rst),
    .r_wptr2(r_wptr2)
);

syncrptr_wd #(
    .addressize(addressize)
) syncrptr_wd1 (
    .wclk(wclk),
    .rgray(rgray),
    .rst(rst),
    .w_rptr2(w_rptr2)
);

fifi_memory #(
    .datasize(datasize),
    .addressize(addressize)
) fifomemory1 (
    .wclk(wclk),
    .rclk(rclk),
    .wen(wen),
    .ren(ren),
    .wdata(wdata),
    .waddr(wbin[addressize-1:0]),
    .raddr(rbin[addressize-1:0]),
    .rdata(rdata)
);

endmodule