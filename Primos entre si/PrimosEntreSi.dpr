program PrimosEntreSi;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.Math,
  System.SysUtils;

function Coprime(const A: Integer; const B: Integer): Boolean;
var
  i, biggest: Integer;
begin
  Result := False;

  if A = B then
    Exit;

  if Abs(A - B) = 1 then
    Exit(True);

  biggest := IfThen(A > B, A, B);

  for i := 2 to (biggest div 2) do
    if (A mod i = 0) and (B mod i = 0) then
      Exit;

  Result := True;

end;

procedure DoStuff;
var
  a, b, i: Integer;
begin
  for i := 0 to 4 do
  begin
    a := Random(100) + 1;
    b := Random(100) + 1;
    if Coprime(a, b) then
      Writeln(a, ' and ', b, ' are coprime integers')
    else
      Writeln(a, ' and ', b, ' are NOT coprime integers')
  end;
end;

begin
  try
    Randomize;
    DoStuff;
    Readln;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
