module readptr #(
parameter addressize =4
)(
input rclk,
input rst,
input rinc,
input [addressize :0] r_wptr2,
output reg [addressize:0] rbin,
output reg [addressize:0] rgray,
output reg rempty
);
wire[addressize:0] rbinnext;
wire[addressize:0] rgraynext;
wire remptyval;

assign rbinnext = (rinc && !rempty ) ? (rbin+1) : rbin;
assign rgraynext = rbinnext^(rbinnext>>1);
assign remptyval = (rgraynext==r_wptr2);

always@(posedge rclk or posedge rst)
begin
if(rst)
begin
rbin<=0;
rgray<=0;
rempty<=1;
end
else
begin
rbin<=rbinnext;
rgray<=rgraynext;
rempty<=remptyval;
end 
end
endmodule


