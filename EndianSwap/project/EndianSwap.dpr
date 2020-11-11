program EndianSwap;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  EndianSwap.Utils in '..\src\EndianSwap.Utils.pas',
  EndianSwap.Constants in'..\src\EndianSwap.Constants.pas';

var
  measure: String;
  position,
  loopCount: Integer;

procedure PrepareIndexes(i: Integer);
begin
  position := 5;
  case i of
    Low(MeasureData):
    begin
      loopCount := 6;
      position := 15;
    end;
    High(MeasureData): loopCount := 3;
  else
    loopCount := 7;
  end;
end;

procedure WriteHeader(i: Integer);
begin
  measure := MeasureData[i];
  Writeln('Header ', StrToInt('$' + measure[1] + measure[2]));
  Writeln;
end;

procedure ProcessData;
var
  subStr: String;

  i, j,
  value,
  tankNumber: Integer;
begin
  tankNumber := 1;
  for i := Low(MeasureData) to High(MeasureData) do
  begin
    if i > Low(MeasureData) then
      Writeln;
    WriteHeader(i);

    PrepareIndexes(i);

    for j := 0 to Pred(loopCount) do
    begin
      subStr := Copy(measure, position, STEP);
      value := StrToInt('$'+subStr);
      Write(Format('Tank %.2d SubStr %s ', [tankNumber, subStr]));
      Writeln('SwapEndian32 = ', SwapEndian32(value));
      //Writeln;
      inc(position, STEP);
      inc(tankNumber);
    end;
  end;
end;

begin
  try
    ProcessData;
    Readln;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.