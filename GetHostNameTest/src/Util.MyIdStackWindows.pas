unit Util.MyIdStackWindows;

interface

uses
  IdStackWindows;

type
  TMyIdStackWindows = class(TIdStackWindows)
  public
    function GetHostByName(AName: String): String;
  end;

implementation

uses
  IdStack;

{ TMyIdStackWindows }

function TMyIdStackWindows.GetHostByName(AName: String): String;
begin
  try
    Result := HostByName(AName);
  except
    on e: EIdSocketError do
      Result := 'Not found';
  end;
end;

end.
