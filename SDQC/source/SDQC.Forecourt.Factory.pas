unit SDQC.Forecourt.Factory;

interface

uses
  System.Classes,
  System.Generics.Collections,
  SDQC.Forecourt.ForecourtSimulator;

type
  TForecourtFactory = class
  private
    FClassIndex: Byte;
    FItemsOwner: TComponent;
  protected const
    FORECOURT_CLASSES = 2;
  protected
    property ClassIndex: Byte read FClassIndex write FClassIndex;
  public
    constructor Create;
    function NextInstance: IForecourtSimulator;
    function Count: Integer;
    property ItemsOwner: TComponent read FItemsOwner write FItemsOwner;
  end;

implementation

uses
  System.SysUtils,
  SDQC.Forecourt.VeederRoot,
  SDQC.Forecourt.WayneFusion;

{ TForecourtFactory }

function TForecourtFactory.Count: Integer;
begin
  Result := FORECOURT_CLASSES;
end;

constructor TForecourtFactory.Create;
begin
  inherited;
  FClassIndex := 0;
end;

function TForecourtFactory.NextInstance: IForecourtSimulator;
begin
  case ClassIndex of
    0: Result := TVeederRoot.Create(ItemsOwner);
    1: Result := TWayneFusion.Create(ItemsOwner);
  else
    Result := nil;
  end;

  Inc(FClassIndex);
  if ClassIndex > Pred(Self.Count) then
    ClassIndex := 0;
end;

end.
