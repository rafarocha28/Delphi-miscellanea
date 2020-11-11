unit Log.Fuel;

interface

uses Log.Abstract;

type
  TPFCBILogFuel = class(TPFCBILog)
  protected
    procedure Init; override;
  end;

implementation

{ TPFCBILogFuellings }

procedure TPFCBILogFuel.Init;
begin
  inherited;
  FileProperties.Modifier := 'ABASTECIMENTOS';
end;

end.
