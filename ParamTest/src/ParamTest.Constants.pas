unit ParamTest.Constants;

interface

const
  HELP_PARAM0 = '?';
  HELP_PARAM1 = 'h';
  HELP_PARAM2 = 'help';

  HelpParams: array [0..2] of string = (
    HELP_PARAM0, HELP_PARAM1, HELP_PARAM2
  );

  KILOBYTE = 1024;
  MEGABYTE = KILOBYTE * KILOBYTE;
  GIGABYTE = MEGABYTE * KILOBYTE;

  HexVolumes: array [0..15] of string = (
    '449A4000', '45870800','45D05800', '45F69000', '45B05800', '45505000',
    '45ABE000', '461C3C00', '4603BC00', '44CEC000', '45917000', '45CC7800',
    '45E79000', '46052000', '46167800', '451A4000');

type
  TIEEE754 = record
    case Byte of
      0: (AsInteger: Cardinal);
      1: (AsFloat: Single);
    end;

function HexIEEE754ToDecimalDouble(AHex: String): Double;

implementation

uses
  System.SysUtils;

function HexIEEE754ToDecimalDouble(AHex: String): Double;
var
  ieee754: TIEEE754;
begin
  if not (AHex[1] = '$') then
    AHex := '$' + AHex;

  ieee754.AsInteger := StrToInt(AHex);

  Result := ieee754.AsFloat;
end;

end.