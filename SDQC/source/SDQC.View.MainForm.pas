unit SDQC.View.MainForm;

interface

uses
  WinApi.Windows, Messages, System.SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ScktComp, ExtCtrls,
  SDQC.Enum.RunMode;

type
  TMainForm = class(TForm)
    ServerSocket1: TServerSocket;
    TextToBeReceivedLabel: TLabel;
    TextToBeReceivedEdit: TEdit;
    ContainsCheckBox: TCheckBox;
    ReplyLabel: TLabel;
    SOHETXCheckBox: TCheckBox;
    ReplyMemo: TMemo;
    LedShape: TShape;
    LedLabel: TLabel;
    ConnectedIPLabel: TLabel;
    PortLabel: TLabel;
    PortEdit: TEdit;
    ActivateButton: TButton;
    procedure ActivateButtonClick(Sender: TObject);
    procedure ServerSocket1ClientRead(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure ServerSocket1ClientConnect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure FormShow(Sender: TObject);
    procedure ServerSocket1ClientDisconnect(Sender: TObject;
      Socket: TCustomWinSocket);
  private
    FRunMode: TRunMode;
    procedure SetRunMode(const ARunMode: TRunMode);
    procedure PrepareOpw;
    procedure PrepareWayne;
    procedure PrepareOther;
    procedure SendReply(ASocket: TCustomWinSocket); overload;
    procedure SendReply(AReplyText: String;
      ASocket: TCustomWinSocket); overload;
    procedure ReadOpw(AReceivedText: AnsiString; ASocket: TCustomWinSocket);
    procedure ReadOthers(AReceivedText: AnsiString; ASocket: TCustomWinSocket);
    procedure ReadWayne(AReceivedText: AnsiString; ASocket: TCustomWinSocket);
  protected
    property RunMode: TRunMode read FRunMode write SetRunMode;
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

uses
  System.StrUtils,
  SDQC.Util.VeederRootConstantes,
  SDQC.Util.WayneFusionConstantes,
  SDQC.Forecourt.WayneFusion,
  SDQC.Forecourt.VeederRoot;

resourcestring
  sConnectedIPNone = 'IP Conectado: nenhum';
  sDeactivated = 'DESATIVADO';
  sActivate = 'Ativar';
  sDeactivate = 'Desativar';
  sActivated = 'ATIVADO';
  sInvalidPort = 'Porta inválida';
  sNoReplyToSend = 'Nenhuma resposta para enviar';
  sConnectedIP = 'IP Conectado: ';
  sReceivedExpected = 'Recebido: %s%sEsperado:%s';
  sReceveidExpectedToContain = 'Recebido: %s%sEsperado conter:%s';
  sDefaultMainFormCaption = 'Simulador de Qualquer Coisa - Ethernet';

{$R *.dfm}

procedure TMainForm.ReadWayne(AReceivedText: AnsiString;
  ASocket: TCustomWinSocket);
var
  wayneFusion: TWayneFusion;
  reply: String;
begin
  reply := EmptyStr;
  wayneFusion := TWayneFusion.Create(Self);
  try
    reply := wayneFusion.GetReply(String(AReceivedText));
    SendReply(reply, ASocket);
  finally
    FreeAndNil(wayneFusion);
  end;
end;

procedure TMainForm.ReadOthers(AReceivedText: AnsiString;
  ASocket: TCustomWinSocket);
begin
  if not ContainsCheckBox.Checked then
  begin
    if not AnsiSameText(AReceivedText, Trim(TextToBeReceivedEdit.Text)) then
    begin
      ShowMessage(Format(sReceivedExpected,
        [AReceivedText, sLineBreak, TextToBeReceivedEdit.Text]));
      Exit;
    end;
  end
  else if not AnsiContainsStr(AReceivedText, Trim(TextToBeReceivedEdit.Text)) then
  begin
    ShowMessage(Format(sReceveidExpectedToContain,
      [AReceivedText, sLineBreak, TextToBeReceivedEdit.Text]));
    Exit;
  end;

  SendReply(ASocket);
end;

procedure TMainForm.ReadOpw(AReceivedText: AnsiString;
  ASocket: TCustomWinSocket);
var
  tankNumber: Integer;
  header: String;
  reply: String;
  veederRoot: TVeederRoot;
begin
  veederRoot := TVeederRoot.Create(Self);
  try
    reply := veederRoot.GetReply(String(AReceivedText));
    SendReply(reply, ASocket);
  finally
    FreeAndNil(veederRoot);
  end;
end;

procedure TMainForm.ActivateButtonClick(Sender: TObject);
var
  porta: Integer;
begin
  if not TryStrToInt(PortEdit.Text, porta) then
  begin
    ShowMessage(sInvalidPort);
    Exit;
  end;

  ServerSocket1.Port := porta;

  ServerSocket1.Active := not ServerSocket1.Active;

  if ServerSocket1.Active then
  begin
    ActivateButton.Caption := sDeactivate;
    LedShape.Brush.Color := clGreen;
    LedLabel.Caption := sActivate;
  end
  else
  begin
    ActivateButton.Caption := sActivate;
    LedShape.Brush.Color := clRed;
    LedLabel.Caption := sDeactivated;
    ConnectedIPLabel.Caption := sConnectedIPNone
  end;

  Application.ProcessMessages;
end;

procedure TMainForm.FormShow(Sender: TObject);
var
  i: Integer;
  parameter: String;
begin
  parameter := EmptyStr;
  RunMode := rmNone;
  for i := 1 to ParamCount do
  begin
    parameter := Trim(ParamStr(i));
    if (parameter = VEEDER_ROOT_PARAM) or
      (parameter = VEEDER_PARAM) or
      (parameter = OPW_PARAM) then
      RunMode := rmVeederRoot
    else if (parameter = WAYNE_PARAM) or
      (parameter = FUSION_PARAM) or
      (parameter = WAYNE_FUSION_PARAM) then
      RunMode := rmWayneFusion;
  end;

  if RunMode = rmNone then
    RunMode := rmOther;
end;

procedure TMainForm.SendReply(ASocket: TCustomWinSocket);
var
  s: String;
begin
  s := Trim(ReplyMemo.Text);

  if SameText(s, EmptyStr) then
  begin
    ShowMessage(sNoReplyToSend);
    Exit;
  end;

  s := StringReplace(s, sLineBreak, '', [rfReplaceAll]);

  if SOHETXCheckBox.Checked then
    s := SOH + s + ETX;

//  ASocket.SendText(AnsiString(s));
  SendReply(s, ASocket);
end;

procedure TMainForm.SendReply(AReplyText: string; ASocket: TCustomWinSocket);
begin
  ASocket.SendText(AnsiString(AReplyText));
end;

procedure TMainForm.ServerSocket1ClientConnect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
  ConnectedIPLabel.Caption := sConnectedIP + Socket.RemoteAddress;
  Application.ProcessMessages;
end;

procedure TMainForm.ServerSocket1ClientDisconnect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
  ConnectedIPLabel.Caption := sConnectedIPNone;
  Application.ProcessMessages;
end;

procedure TMainForm.ServerSocket1ClientRead(Sender: TObject;
  Socket: TCustomWinSocket);
var
  s: AnsiString;
begin
  s := Socket.ReceiveText;

  case RunMode of
    rmWayneFusion: ReadWayne(s, Socket);
    rmVeederRoot: ReadOPW(s, Socket);
    rmOther: ReadOthers(s, Socket);
  end;
end;

procedure TMainForm.PrepareOpw;
begin
  Self.Caption := Format('%s - VEEDER ROOT/OPW MODE', [Self.Caption]);
  TextToBeReceivedEdit.Text := VEEDER_TANK_REPORT_COMPUTER_FORMAT;
  ContainsCheckBox.Checked := True;
  ReplyMemo.Text := VEEDER_TANK_REPORT_EXAMPLE_COMPUTER_FORMAT;
  SOHETXCheckBox.Checked := True;
  PortEdit.Text := IntToStr(VEEDER_DEFAULT_PORT);
end;

procedure TMainForm.PrepareWayne;
begin
  Self.Caption := Format('%s - WAYNE FUSION MODE', [Self.Caption]);
  ContainsCheckBox.Enabled := False;
  SOHETXCheckBox.Enabled := False;

  with TextToBeReceivedEdit do
  begin
    Enabled := False;
    Color := clScrollBar;
  end;

  with ReplyMemo do
  begin
    Enabled := False;
    Color := clScrollBar;
  end;
  PortEdit.Text := IntToStr(WAYNE_DEFAULT_PORT);
end;

procedure TMainForm.PrepareOther;
begin
  Self.Caption := sDefaultMainFormCaption;
  ContainsCheckBox.Enabled := True;
  TextToBeReceivedEdit.Enabled := True;
  SOHETXCheckBox.Enabled := True;
  ReplyMemo.Enabled := True;
  PortEdit.Enabled := True;
  ActivateButton.Enabled := True;
end;

procedure TMainForm.SetRunMode(const ARunMode: TRunMode);
begin
  if FRunMode = ARunMode then
    Exit;

  FRunMode := ARunMode;

  case FRunMode of
    rmWayneFusion: PrepareWayne;
    rmVeederRoot: PrepareOpw;
    rmOther: PrepareOther;
  end;
end;

end.
