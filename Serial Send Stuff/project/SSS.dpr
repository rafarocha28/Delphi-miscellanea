program SSS;

uses
  Vcl.Forms,
  SSS.MainForm in '..\src\SSS.MainForm.pas' {MainForm},
  Vcl.Themes,
  Vcl.Styles;

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'Serial Send Stuff';
  TStyleManager.TrySetStyle('Windows10 Blue');
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
