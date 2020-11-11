// Helping hands
unit Util.HH;

interface

function IsEmpty(AString: String; ATrim: Boolean = True): Boolean;

const
  ONE_SECOND = 1000; // em milissegundos
  ONE_MINUTE = ONE_SECOND * 60;
  ONE_HOUR = ONE_MINUTE * 60;
  ONE_DAY = ONE_HOUR * 24;

  KILOBYTE = 1024;
  MEGABYTE = KILOBYTE * KILOBYTE;
  GIGABYTE = MEGABYTE * KILOBYTE;

implementation

uses
  System.SysUtils;

function IsEmpty(AString: String; ATrim: Boolean = True): Boolean;
begin
  if ATrim then
    AString := Trim(AString);
  Result := SameText(AString, EmptyStr);
end;

end.
