unit LP.MainForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ToolWin, Vcl.ComCtrls,
  Vcl.WinXCtrls, Vcl.ExtCtrls, Vcl.StdCtrls, System.Generics.Collections,
  Log.Abstract, Log.Exceptions, Log.Fuel, Log.Geral;

type
  TMainLogsForm = class(TForm)
    Panel: TPanel;
    ActivityIndicator: TActivityIndicator;
    ToggleSwitch: TToggleSwitch;
    Memo: TMemo;
    TopPanel: TPanel;
    GeralLabel: TLabel;
    FuelLabel: TLabel;
    procedure ToggleSwitchClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    FLogList: TObjectList<TPFCBILog>;
    procedure LogMessage(AMessage: String);
  protected
    procedure WriteLog(AMessage: String);
    property LogList: TObjectList<TPFCBILog> read FLogList;
  public
    { Public declarations }
  end;

var
  MainLogsForm: TMainLogsForm;

implementation

{$R *.dfm}

uses AsyncCalls;

procedure TMainLogsForm.FormCreate(Sender: TObject);
begin
  FLogList := TObjectList<TPFCBILog>.Create;
  with FLogList do
  begin
    Add(TPFCBILogGeral.Create);
    Add(TPFCBILogFuel.Create);
  end;
end;

procedure TMainLogsForm.FormShow(Sender: TObject);
var
  log: TPFCBILog;
begin
  for log in LogList do
    if log is TPFCBILogGeral then
      GeralLabel.Caption := log.FileName
    else if log is TPFCBILogFuel then
      FuelLabel.Caption := log.FileName;
end;

procedure TMainLogsForm.LogMessage(AMessage: String);
var
  log: TPFCBILog;
  s: String;
begin
  for log in FLogList do
  begin
    s := Format('%s - Teste %s', [AMessage, log.ClassName]);
    log.Write(s);
    Memo.Lines.Add(s);
  end;
end;

procedure TMainLogsForm.ToggleSwitchClick(Sender: TObject);
begin
  if ToggleSwitch.State = tssOn then
  begin
    TAsyncCalls.VCLSync(
      procedure
      begin
        WriteLog('ON');
      end);
  end
  else
  begin
    TAsyncCalls.VCLSync(
      procedure
      begin
        WriteLog('OFF');
      end);
  end;
end;

procedure TMainLogsForm.WriteLog(AMessage: String);
var
  log: TPFCBILog;
  s: String;
begin
  for log in FLogList do
  begin
    s := Format('%s - Teste %s', [AMessage, log.ClassName]);
    log.Write(s);
    Memo.Lines.Add(s);
  end;
end;
end.
