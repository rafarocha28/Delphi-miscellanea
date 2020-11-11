program LogTest;

uses
  Vcl.Forms,
  LP.MainForm in 'LP.MainForm.pas' {MainLogsForm},
  Log.Intf in 'Log.Intf.pas',
  Log.Level in 'Log.Level.pas',
  Log.Abstract in 'Log.Abstract.pas',
  Log.Exceptions in 'Log.Exceptions.pas',
  Log.Fuel in 'Log.Fuel.pas',
  Log.Geral in 'Log.Geral.pas',
  AsyncCalls in 'AsyncCalls.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainLogsForm, MainLogsForm);
  Application.Run;
end.
