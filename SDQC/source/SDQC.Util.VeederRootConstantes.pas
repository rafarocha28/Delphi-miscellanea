unit SDQC.Util.VeederRootConstantes;

interface

const
  SOH: char = #$01;
  STX: char = #$02;
  ETX: char = #$03;

  VEEDER_ROOT_PARAM = '-veeder_root';
  VEEDER_PARAM = '-veeder';
  OPW_PARAM = '-opw';

  ERROR_REPLY = '9999&FB';

  VEEDER_TANK_REPORT_COMPUTER_FORMAT = 'i201';
  VEEDER_TANK_REPORT_DISPLAY_FORMAT = 'I201';

  VEEDER_TANK_REPORT_EXAMPLE_COMPUTER_FORMAT =
    'i201001501231349010000007422AC223422988F643' +
    'DD274641339CE8????????41CF9BA900000000&&EE51';

  VEEDER_SET_TIME_OF_DAY_COMPUTER_FORMAT = 's50100';
  VEEDER_SET_TIME_OF_DAY_DISPLAY_FORMAT = 's50100';

  // Respostas est�o simplificadas
  VEEDER_SET_TIME_OF_DAY_RESPONSE_COMPUTER_FORMAT = 'i50100';
  VEEDER_SET_TIME_OF_DAY_RESPONSE_DISPLAY_FORMAT = 'I50100';

  VEEDER_DEFAULT_PORT = 10002;

  OPW_FILE = 'opw.bin';

  {

  i201 TT YY MM DD HH mm TT p ssss NN FFFFFFFF && CCCC
  i201 00 15 01 23 13 49 01 0 0000 07
    422AC223 // 1 volume
    422988F6 // 2 tc volume
    43DD2746 // 3 ullage
    41339CE8 // 4 height
    ???????? // 5 water
    41CF9BA9 // 6 temperature
    00000000 // 7 water volume
  && EE51

  }
  // checksums falsos
  TankReportRepliesComputerFormat: array [1..16] of string = (
  {01} 'i2010116111711520110000074545879A455A58E246DF3F0E43C6D0AA00000000C2918E3900000000&&EEA5',
  {02} 'i2010216103112300200000074587080045981C15462A18D8445E29970000000041C34CA800000000&&CCCC',
  {03} 'i20103161031123003000000745D05800454D92A4464077A3442891840000000041C1816300000000&&CCCC',
  {04} 'i20104161031123004000000745F69000454EFE0046400DA844297FEA0000000041C3DB6000000000&&CCCC',
  {05} 'i20105161031123005000000745B058004581849A46344EDC444643820000000041C552A700000000&&CCCC',
  {06} 'i2010616103112300600000074550500045BDF5AE4614B40A4483DFE341E8EA6041C9FD7B42011562&&CCCC',
  {07} 'i20107161031123007000000745ABE00045BDF5AE4614B40A4483DFE341E8EA6041C9FD7B42011562&&CCCC',
  {08} 'i201081610311230080000007461C3C00455A58E246DF3F0E43C6D0AA00000000C2918E3900000000&&CCCC',
  {09} 'i2010916103112300900000074603BC0045981C15462A18D8445E29970000000041C34CA800000000&&CCCC',
  {10} 'i20110161031123010000000744CEC000454D92A4464077A3442891840000000041C1816300000000&&CCCC',
  {11} 'i20111161031123011000000745917000454EFE0046400DA844297FEA0000000041C3DB6000000000&&CCCC',
  {12} 'i20112161031123012000000745CC78004581849A46344EDC444643820000000041C552A700000000&&CCCC',
  {13} 'i20113161031123013000000745E7900045BDF5AE4614B40A4483DFE341E8EA6041C9FD7B42011562&&CCCC',
  {14} 'i2011416103112301400000074605200045BDF5AE4614B40A4483DFE341E8EA6041C9FD7B42011562&&CCCC',
  {15} 'i20115161031123015000000746167800455A58E246DF3F0E43C6D0AA00000000C2918E3900000000&&CCCC',
  {16} 'i201161610311230160000007451A400045981C15462A18D8445E29970000000041C34CA800000000&&CCCC'
  ); // message length = 89 bytes (SOH + 87 caracters + ETX)

  (*
    Lista de Volumes (em litros)
    {01} 1234 = 449A4000
    {02} 4321 = 45870800
    {03} 6667 = 45D05800
    {04} 7890 = 45F69000
    {05} 5643 = 45B05800
    {06} 3333 = 45505000
    {07} 5500 = 45ABE000
    {08} 9999 = 461C3C00
    {09} 8431 = 4603BC00
    {10} 1654 = 44CEC000
    {11} 4654 = 45917000
    {12} 6543 = 45CC7800
    {13} 7410 = 45E79000
    {14} 8520 = 46052000
    {15} 9630 = 46167800
    {16} 2468 = 451A4000
  *)

  TankReportRepliesDisplayFormat: array [1..16] of string = (
  {01} '  1  GASOLINA COMUM        1234      5026    15142    760.1      0.0    24.23<#13><#10>',
//       '  1	 Etanol Comum	         3662	     3647	   26956	  451.5		           24'
  {02} '  2  GASOLINA COMUM        4321      5026    15142    760.1      0.0    24.23<#13><#10>',
  {03} '  3  GASOLINA COMUM        6667      5026    15142    760.1      0.0    24.23<#13><#10>',
  {04} '  4  GASOLINA COMUM        7890      5026    15142    760.1      0.0    24.23<#13><#10>',
  {05} '  5  GASOLINA COMUM        5643      5026    15142    760.1      0.0    24.23<#13><#10>',
  {06} '  6  GASOLINA COMUM        3333      5026    15142    760.1      0.0    24.23<#13><#10>',
  {07} '  7  GASOLINA COMUM        5500      5026    15142    760.1      0.0    24.23<#13><#10>',
  {08} '  8  GASOLINA COMUM        9999      5026    15142    760.1      0.0    24.23<#13><#10>',
  {09} '  9  GASOLINA COMUM        8431      5026    15142    760.1      0.0    24.23<#13><#10>',
  {10} ' 10  GASOLINA COMUM        1654      5026    15142    760.1      0.0    24.23<#13><#10>',
  {11} ' 11  GASOLINA COMUM        4654      5026    15142    760.1      0.0    24.23<#13><#10>',
  {12} ' 12  GASOLINA COMUM        6543      5026    15142    760.1      0.0    24.23<#13><#10>',
  {13} ' 13  GASOLINA COMUM        7410      5026    15142    760.1      0.0    24.23<#13><#10>',
  {14} ' 14  GASOLINA COMUM        8520      5026    15142    760.1      0.0    24.23<#13><#10>',
  {15} ' 15  GASOLINA COMUM        9630      5026    15142    760.1      0.0    24.23<#13><#10>',
  {16} ' 16  GASOLINA COMUM        2468      5026    15142    760.1      0.0    24.23<#13><#10>'
  );

resourcestring
  sDisplayFormatHeader =
    '<#13><#10>%s<#13><#10>    11-10-13 16:06<#13><#10><#13><#10>'+
    'POSTO POLEZEL LTDA<#13><#10>R.PAULA BUENO,25<#13><#10>TAQ.CAMPINAS-SP<#13><#10>'+
    'CNPJ 500831530001-18<#13><#10><#13><#10>INVENTARIO NO TNQ       <#13><#10><#13><#10>'+
    'TANQ PRODUCTO               VOL    VOL CT   A COMP   ALTURA    AGUA      TEMP<#13><#10>';
implementation

end.
