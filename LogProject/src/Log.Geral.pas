unit Log.Geral;

interface

uses
  Vcl.Forms,
  Log.Abstract;

type
  TPFCBILogGeral = class(TPFCBILog)
  private
    FForm: TForm;
    class var FInstance: TPFCBILogGeral;
  protected
    class procedure Initialize;
  public
    class function NewInstance: TObject; override;
    class function HasInstance: Boolean;
    procedure ShowForm;
  end;

implementation

{ TPFCBILogGeral }

class function TPFCBILogGeral.HasInstance: Boolean;
begin
  Result := FInstance <> nil;
end;

class procedure TPFCBILogGeral.Initialize;
begin
  with FInstance do
  begin
    Init;
    FileProperties.Modifier := 'GERAL';
  end;
end;

class function TPFCBILogGeral.NewInstance: TObject;
begin
  if not HasInstance then
  begin
    FInstance := inherited NewInstance as TPFCBILogGeral;
    FInstance.Initialize;
  end;

  Result := FInstance;
end;

procedure TPFCBILogGeral.ShowForm;
begin
  if FForm <> nil then
    exit;

  FForm := TForm.Create(Application);
  with FForm do
    try
      ShowModal;

    finally
      Free;
      FForm := nil;
    end;
end;

end.
