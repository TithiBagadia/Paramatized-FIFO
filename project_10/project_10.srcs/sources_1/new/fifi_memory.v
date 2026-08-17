
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.07.2026 14:25:14
// Design Name: 
// Module Name: fifi_memory
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module fifi_memory #(
parameter datasize=8,
parameter addressize=4
)(input wclk,
 input  rclk,
 input wen,
 input ren,
 input [datasize-1:0]wdata,
 input [addressize-1:0] waddr,
 input [addressize-1:0]raddr,
 output reg [datasize-1:0] rdata
 
 
    );
    reg[datasize-1:0] mem[0:(2**addressize)-1];
   
always @(posedge wclk)
begin
if(wen)
begin
mem[waddr] <= wdata;

end
end
    
    always@(posedge rclk)
    begin
    if(ren)
    begin
     rdata <= mem[raddr];
    end
    end
 
endmodule
