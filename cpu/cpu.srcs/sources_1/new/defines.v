//********ȫ�ֵĺ궨��
`define rstenable     1'b1//��λ�ź���Ч
`define rstdisable    1'b0//��λ�ź���Ч
`define zeroword      32'h00000000//32λ��ֵ��
`define  writeenable  1'b1// ʹ��д
`define  writedisable 1'b0//  ��ֹд
`define  readenable   1'b1//  ʹ�ܶ�
`define  readdisable  1'b0//  ��ֹ��
`define  aluopbus     7:0   //����׶ε����aluop_o �Ŀ��
`define	 aluselbus    2:0   //����׶ε����alusel_o �Ŀ��
`define  instvalid    1'b1//  ָ����Ч ���������鷴��
`define	 instinvalid  1'b0//  ָ����Ч
`define  true_v       1'b1//  �߼���
`define  false_v      1'b0//  �߼���
`define  chipenable   1'b1//  оƬʹ��
`define  chipdisable  1'b0//  оƬ��ֹ
`define  regdatabus   31:0
`define  aluop_onehotbus 20:0
`define  zeroregaddr  4'b0000 //id����

`define branch 1'b1 //pcҪת����
`define notbranch 1'b0
`define indelayslot 1'b1 //id ���ӳٲ���
`define notindelayslot 1'b0 //id �����ӳٲ���
//********�����ָ����صĺ궨��
`define  exe_ori      6'b001101  //ָ��ori��ָ����
`define  exe_nop      6'b000000

`define  exe_or_op    8'b00100101
`define  exe_nop_op   8'b00000000

`define  exe_res_logic 3'b001
`define  exe_res_nop  3'b000
//********��ָ��洢��rom�йصĺ궨��
`define  instaddrbus 31:0 //ROM�ĵ�ַ���߿��
`define  instbus     31:0 //ROM���������߿��
`define  instmemnum  131071 //ROM��ʵ�ʴ�СΪ128KB
`define  instmemnumlog2 17  //ROMʵ��ʹ�õĵ�ַ�߿��
//********��ͨ�üĴ���regfile�йصĺ궨��
`define  regaddrbus  4:0  //regfileģ��ĵ�ַ�߿��
`define  regbus      31:0  //regfileģ��������߿��
`define  regwidth    32    //ͨ�üĴ����Ŀ��
`define  doubleregwidth  64//������ͨ�üĴ����Ŀ��
`define  doubleregbus    63:0//������ͨ�üĴ����������߿��
`define  regnum      32    //ͨ�üĴ���������
`define  regnumlog2  5     //Ѱַͨ�üĴ���ʹ�õĵ�ַλ��
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