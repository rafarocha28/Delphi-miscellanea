unit ParamTest.Thread.WriteFile;

interface

uses
  System.Classes;

type
  TWriteFile = class(TThread)
  protected
    procedure Execute; override;
    procedure WriteFile;
  end;

implementation

{ TWriteFile }

uses
  Vcl.Forms,
  ParamTest.Utils;

procedure TWriteFile.Execute;
begin
  while not Terminated do
  begin
    WriteFile;
    Sleep(150);
    Application.ProcessMessages;
  end;
end;

procedure TWriteFile.WriteFile;
var
  s, s1: String;
begin
  for i := Low(HexVolumes) to High(HexVolumes) do
  begin
    s1 := Format('  %s = %f',
      [HexVolumes[i], HexIEEE754ToDecimalDouble(HexVolumes[i])]);

    s := Format('%s [%6.6d] | %s',
      [FormatDateTime('hh:nn:ss:zzz', Now), GetCurrentThreadId(), s1]);

    Writeln(s);
    Application.ProcessMessages;
  end;
end;

end.
