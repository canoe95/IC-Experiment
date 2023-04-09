// ¼Ä´æÆ÷¶ÁÐ´
`define RegAddrBus 4:0
`define RegDataBus 31:0
`define RegNum 31:0
`define RstDisable 0
`define RstEnable 1
`define ZeroWord 32'h0

`define ReadEnable 1
`define ReadDisable 0
`define WriteEnable 1
`define WriteDisable 0

// È¡ÖµÄ£¿éinst
`define InstAddrBus 31:0
`define InstBus 31:0
`define CeDisable 0

`define Aluop_OnehotBus 13:0
`define ZeroRegAddr 5'd0
// Ö¸Áî 5:0 ±àºÅ
`define FuncAdd  6'b100000
`define FuncAddu 6'b100001
`define FuncSub  6'b100010
`define FuncSubu 6'b100011
`define FuncSlt  6'b101010
`define FuncSltu 6'b101011
`define FuncAnd  6'b100100
`define FuncOr   6'b100101
`define FuncXor  6'b100110
`define FuncNor  6'b100111
`define FuncZero 6'b000000
`define FuncSll  6'b000000
`define FuncSrl  6'b000010
`define FuncSra  6'b000011
// ËãÊý¡¢Âß¼­ÔËËã
`define OpZero   6'b000000
`define Op1Zero  5'b00000
`define SaZero   5'b00000
`define OpLui    6'b001111

// ÒëÂë½á¹û
`define AluopAdd  14'b10_0000_0000_0000
`define AluopAddu 14'b01_0000_0000_0000
`define AluopSub  14'b00_1000_0000_0000
`define AluopSubu 14'b00_0100_0000_0000
`define AluopSlt  14'b00_0010_0000_0000
`define AluopSltu 14'b00_0001_0000_0000
`define AluopAnd  14'b00_0000_1000_0000
`define AluopOr   14'b00_0000_0100_0000
`define AluopXor  14'b00_0000_0010_0000
`define AluopNor  14'b00_0000_0001_0000
`define AluopSll  14'b00_0000_0000_1000
`define AluopSrl  14'b00_0000_0000_0100
`define AluopSra  14'b00_0000_0000_0010
`define AluopLui  14'b00_0000_0000_0001
`define AluopZero 14'b00_0000_0000_0000