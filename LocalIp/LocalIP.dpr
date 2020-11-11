program LocalIP;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  System.Classes,
  IdStack;

function GetLocalIp: string;
var
  sl: TStringList;
  s: string;
begin
  TIdStack.IncUsage;
  sl := TStringList.Create;
  try
    sl.AddStrings(GStack.LocalAddresses);
    for s in sl do
      Writeln(s);
  finally
    TIdStack.DecUsage;
    sl.Free;
  end;
end;

begin
  try
//    Writeln(GetLocalIp);
    GetLocalIp;
    Readln;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
