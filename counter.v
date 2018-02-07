module counter(
    input clock,
    input reset,
    output a1,
    output a2,
    output b1,
    output b2,
    output c1,
    output c2,
    output d1,
    output d2,
    output e1,
    output e2,
    output f1,
    output f2,
    output g1,
    output g2,
    output reg [3:0]first,
    output reg [3:0]second
);

wire [3:0]an;

always @ (posedge clock or posedge reset)
    begin
        if (reset) begin
            first <= 0;
            second <= 0;
    end else if (first==4'd9) begin
        first <= 0;
        if (second == 4'd9) //99 reached
            second <= 0;
        else
            second <= second + 1;
    end else
    first <= first + 1;
  end

localparam N = 18;
reg [N-1:0]count;

always @ (posedge clock or posedge reset)
    begin
        if (reset)
            count <= 0;
        else
            count <= count + 1;
    end

reg [6:0]sseg;
reg [3:0]an_temp;
always @ (*)
    begin
        case(count[N-1:N-2])
            2'b00:
            begin
                sseg = first;
                an_temp = 4'b1110;
            end

            2'b01:
            begin
                sseg = second;
                an_temp = 4'b1101;
            end
        endcase
    end
assign an = an_temp;

reg [6:0] sseg_temp1;
reg [6:0] sseg_temp2;
always @ (*)
    begin
        if(sseg == second) begin
            case(sseg)
                4'd0 : sseg_temp1 = 7'b1000000; //0
                4'd1 : sseg_temp1 = 7'b1111001; //1
                4'd2 : sseg_temp1 = 7'b0100100; //2
                4'd3 : sseg_temp1 = 7'b0110000; //3
                4'd4 : sseg_temp1 = 7'b0011001; //4
                4'd5 : sseg_temp1 = 7'b0010010; //5
                4'd6 : sseg_temp1 = 7'b0000010; //6
                4'd7 : sseg_temp1 = 7'b1111000; //7
                4'd8 : sseg_temp1 = 7'b0000000; //8
                4'd9 : sseg_temp1 = 7'b0010000; //9
                default : sseg_temp1 = 7'b0111111; //dash
            endcase
        end else begin
            case(sseg)
                4'd0 : sseg_temp2 = 7'b1000000; //0
                4'd1 : sseg_temp2 = 7'b1111001; //1
                4'd2 : sseg_temp2 = 7'b0100100; //2
                4'd3 : sseg_temp2 = 7'b0110000; //3
                4'd4 : sseg_temp2 = 7'b0011001; //4
                4'd5 : sseg_temp2 = 7'b0010010; //5
                4'd6 : sseg_temp2 = 7'b0000010; //6
                4'd7 : sseg_temp2 = 7'b1111000; //7
                4'd8 : sseg_temp2 = 7'b0000000; //8
                4'd9 : sseg_temp2 = 7'b0010000; //9
                default : sseg_temp2 = 7'b0111111; //dash
            endcase
        end
    end

assign {g1, f1, e1, d1, c1, b1, a1} = sseg_temp1;
assign {g2, f2, e2, d2, c2, b2, a2} = sseg_temp2;

endmodule
