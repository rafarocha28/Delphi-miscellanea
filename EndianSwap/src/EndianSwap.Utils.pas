unit EndianSwap.Utils;

interface

function SwapEndian16(Value: smallint): smallint; register;
function SwapEndian32(Value: integer): integer; register;

function SwapEndianString(AString: String): String;

implementation

uses
  System.SysUtils;

function SwapEndian32(Value: integer): integer; register;
asm
  bswap eax;
end;

function SwapEndian16(Value: smallint): smallint; register;
asm
  xchg  al, ah
end;

function SwapEndianString(AString: String): String;
var
  position: Integer;
begin
  Result := EmptyStr;

  if Odd(Length(AString)) then
    Exit;

  position := Pred(Length(AString));
  while position >= 0 do
  begin
    Result := Result + Copy(AString, position, 2);
    Dec(position, 2);
  end;
end;

end.
