//********全局的宏定义
`define rstenable     1'b1//复位信号有效
`define rstdisable    1'b0//复位信号无效
`define zeroword      32'h00000000//32位数值零
`define  writeenable  1'b1// 使能写
`define  writedisable 1'b0//  禁止写
`define  readenable   1'b1//  使能读
`define  readdisable  1'b0//  禁止读
`define  aluopbus     7:0   //译码阶段的输出aluop_o 的宽度
`define	 aluselbus    2:0   //译码阶段的输出alusel_o 的宽度
`define  instvalid    1'b1//  指令有效 这两个和书反的
`define	 instinvalid  1'b0//  指令无效
`define  true_v       1'b1//  逻辑真
`define  false_v      1'b0//  逻辑假
`define  chipenable   1'b1//  芯片使能
`define  chipdisable  1'b0//  芯片禁止
`define  regdatabus   31:0
`define  aluop_onehotbus 20:0
`define  zeroregaddr  4'b0000 //id中用

`define branch 1'b1 //pc要转移吗？
`define notbranch 1'b0
`define indelayslot 1'b1 //id 在延迟槽中
`define notindelayslot 1'b0 //id 不在延迟槽中
//********与具体指令相关的宏定义
`define  exe_ori      6'b001101  //指令ori的指令码
`define  exe_nop      6'b000000

`define  exe_or_op    8'b00100101
`define  exe_nop_op   8'b00000000

`define  exe_res_logic 3'b001
`define  exe_res_nop  3'b000
//********与指令存储器rom有关的宏定义
`define  instaddrbus 31:0 //ROM的地址总线宽度
`define  instbus     31:0 //ROM的数据总线宽度
`define  instmemnum  131071 //ROM的实际大小为128KB
`define  instmemnumlog2 17  //ROM实际使用的地址线宽度
//********与通用寄存器regfile有关的宏定义
`define  regaddrbus  4:0  //regfile模块的地址线宽度
`define  regbus      31:0  //regfile模块的数据线宽度
`define  regwidth    32    //通用寄存器的宽度
`define  doubleregwidth  64//两倍的通用寄存器的宽度
`define  doubleregbus    63:0//两倍的通用寄存器的数据线宽度
`define  regnum      32    //通用寄存器的数量
`define  regnumlog2  5     //寻址通用寄存器使用的地址位数
`define  nopregaddr  5'b00000
//////////////////////////////////////////
`define  funcadd     6'b100000
`define  funcaddu    6'b100001
`define  funcsub     6'b100010
`define  funcsubu    6'b100011
`define  funcslt     6'b101010
`define  funcsltu    6'b101011
`define  funcand     6'b100100
`define  funcor      6'b100101
`define  funcxor     6'b100110
`define  funcnor     6'b100111
`define  funczero    6'b000000
`define  funcsll     6'b000000
`define  funcsrl     6'b000010
`define  funcsra     6'b000011

`define  funcjr     6'b001000

`define  opzero      6'b000000
`define  oplzero     5'b00000
`define  sazero      5'b00000
`define  oplui       6'b001111

`define  opaddiu     6'b001001
`define  oplw        6'b100011
`define  opsw        6'b101011
`define  opbeq       6'b000100
`define  opbne       6'b000101
`define  opjr        6'b000000
`define  opjal       6'b000011

/////////////////////////////////////////////////
`define  aluopadd   21'b10_0000_0000_0000_0000_000
`define  aluopaddu  21'b01_0000_0000_0000_0000_000
`define  aluopsub   21'b00_1000_0000_0000_0000_000
`define  aluopsubu  21'b00_0100_0000_0000_0000_000
`define  aluopslt   21'b00_0010_0000_0000_0000_000
`define  aluopsltu  21'b00_0001_0000_0000_0000_000
`define  aluopand   21'b00_0000_1000_0000_0000_000
`define  aluopor    21'b00_0000_0100_0000_0000_000
`define  aluopxor   21'b00_0000_0010_0000_0000_000
`define  aluopnor   21'b00_0000_0001_0000_0000_000
`define  aluopsll   21'b00_0000_0000_1000_0000_000
`define  aluopsrl   21'b00_0000_0000_0100_0000_000
`define  aluopsra   21'b00_0000_0000_0010_0000_000
`define  aluoplui   21'b00_0000_0000_0001_0000_000
`define  aluopzero  21'b00_0000_0000_0000_0000_000

`define  aluopaddiu 21'b00_0000_0000_0000_1000_000
`define  aluoplw    21'b00_0000_0000_0000_0100_000
`define  aluopsw    21'b00_0000_0000_0000_0010_000
`define  aluopbeq   21'b00_0000_0000_0000_0001_000
`define  aluopbne   21'b00_0000_0000_0000_0000_100
`define  aluopjr    21'b00_0000_0000_0000_0000_010
`define  aluopjal   21'b00_0000_0000_0000_0000_001  