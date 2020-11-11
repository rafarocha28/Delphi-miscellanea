program UnixFire;

uses
  Vcl.Forms,
  Main in 'Main.pas' {MainForm},
  WinService in 'WinService.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
