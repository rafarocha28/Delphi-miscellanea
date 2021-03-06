program SDQC;

uses
  Forms,
  Vcl.Themes,
  Vcl.Styles,
  SDQC.Util.VeederRootConstantes in '..\source\SDQC.Util.VeederRootConstantes.pas',
  SDQC.Util.WayneFusionConstantes in '..\source\SDQC.Util.WayneFusionConstantes.pas',
  SDQC.Forecourt.WayneFusion in '..\source\SDQC.Forecourt.WayneFusion.pas',
  SDQC.Forecourt.VeederRoot in '..\source\SDQC.Forecourt.VeederRoot.pas',
  SDQC.Forecourt.ForecourtSimulator in '..\source\SDQC.Forecourt.ForecourtSimulator.pas',
  SDQC.Enum.RunMode in '..\source\SDQC.Enum.RunMode.pas',
  SDQC.View.Main in '..\source\SDQC.View.Main.pas' {MainForm},
  SDQC.Util.LogFacade in '..\source\SDQC.Util.LogFacade.pas',
  SDQC.Forecourt.Factory in '..\source\SDQC.Forecourt.Factory.pas',
  SDQC.Forecourt.Abstract in '..\source\SDQC.Forecourt.Abstract.pas',
  Util.Log in '..\source\Util.Log.pas',
  Util.Kkversion in '..\source\Util.Kkversion.pas',
  Util.HH in '..\source\Util.HH.pas',
  SDQC.Config in '..\source\SDQC.Config.pas',
  SDQC.View.SerialConfig in '..\source\SDQC.View.SerialConfig.pas' {SerialConfigForm};

{$R *.res}

begin
  {$WARN SYMBOL_PLATFORM OFF}
  ReportMemoryLeaksOnShutdown := DebugHook <> 0;
  {$WARN SYMBOL_PLATFORM ON}
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Windows10 Blue');
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TSerialConfigForm, SerialConfigForm);
  Application.Run;
end.
