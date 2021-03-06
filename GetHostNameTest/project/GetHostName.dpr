program GetHostName;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  IdStack,
  Util.MyIdStackWindows in '..\src\Util.MyIdStackWindows.pas';

const
  THostNameList: array [1..5] of string = ('EZServerCE', 'DESK589', 'DESK188',
    'localhost', 'M�quina que n�o existe');

procedure DoStuff;
var
  i: Integer;
  list: TIdStackLocalAddressList;
  addr: TIdStackLocalAddress;
begin
  with TMyIdStackWindows.Create do
  try
    for i := Low(THostNameList) to High(THostNameList) do
    begin
      Writeln('Host name = ', THostNameList[i]);
      Writeln('IP        = ', GetHostByName(THostNameList[i]));
    end;
    list := TIdStackLocalAddressList.Create;
    GetLocalAddressList(list);
    for i := 0 to Pred(list.Count) do
    begin
      addr := list.Addresses[i];
      Writeln(addr.IPAddress);
    end;
  finally
    Free;
  end;
end;

begin
  try
    DoStuff;
    Readln;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
