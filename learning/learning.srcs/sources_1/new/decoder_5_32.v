`timescale 1ns / 1ps

module decoder_5_32(
    input[4:0] in,
    output[31:0] out
    );
    assign out[0] = (in==5'd0);
    assign out[1] = (in==5'd1);
    assign out[2] = (in==5'd2);
    assign out[3] = (in==5'd3);
    assign out[4] = (in==5'd4);
    assign out[5] = (in==5'd5);
    assign out[6] = (in==5'd6);
    assign out[7] = (in==5'd7);
    assign out[8] = (in==5'd8);
    assign out[9] = (in==5'd9);
    assign out[10] = (in==5'd10);
    assign out[11] = (in==5'd11);
    assign out[12] = (in==5'd12);
    assign out[13] = (in==5'd13);
    assign out[14] = (in==5'd14);
    assign out[15] = (in==5'd15);
    assign out[16] = (in==5'd16);
    assign out[17] = (in==5'd17);
    assign out[18] = (in==5'd18);
    assign out[19] = (in==5'd19);
    assign out[20] = (in==5'd20);
    assign out[21] = (in==5'd21);
    assign out[22] = (in==5'd22);
    assign out[23] = (in==5'd23);
    assign out[24] = (in==5'd24);
    assign out[25] = (in==5'd25);
    assign out[26] = (in==5'd26);
    assign out[27] = (in==5'd27);
    assign out[28] = (in==5'd28);
    assign out[29] = (in==5'd29);
    assign out[30] = (in==5'd30);
    assign out[31] = (in==5'd31);

endmodule
