unit SSS.MainForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, OoMisc, AdPort;

type
  TMainForm = class(TForm)
    ApdComPort: TApdComPort;
    SendButton: TButton;
    ReplyMemo: TMemo;
    ClosePortButton: TButton;
    procedure FormShow(Sender: TObject);
    procedure SendButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ApdComPortTriggerAvail(CP: TObject; Count: Word);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ClosePortButtonClick(Sender: TObject);
  private
    FTankNumber: Byte;
    FReply: String;
    FClosed: Boolean;
    procedure CheckTankNumber;
  protected
    property TankNumber: Byte read FTankNumber write FTankNumber;
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

uses
  System.StrUtils;

{$R *.dfm}

procedure TMainForm.ApdComPortTriggerAvail(CP: TObject; Count: Word);
var
  i: Word;
  c: AnsiChar;
  s: AnsiString;
begin
  s := '';
  if Length(FReply) = 26 then
    FReply := EmptyStr;
  try
    for i := 1 to Count do
    begin
      c := ApdComPort.GetChar;
      if c in [#1..#126] then
        s := s + c;
    end;
  finally
    FReply := FReply + String(s);
    //ReplyMemo.Lines.Add('Recebido ' + String(s));
    //ReplyMemo.Lines.Add('Recebido ' + FReply);
  end;
end;

procedure TMainForm.CheckTankNumber;
begin
  if FTankNumber > 4 then
    FTankNumber := 1;
end;

procedure TMainForm.ClosePortButtonClick(Sender: TObject);
var
  comNumber: Word;
begin
  comNumber := ApdComPort.ComNumber;
  //ApdComPort.ComNumber := 0;
  ApdComPort.Open := False;
  FClosed := True;
  ReplyMemo.Lines.Clear;
  ReplyMemo.Lines.Add(DupeString('-', 15));
  ReplyMemo.Lines.Add(Format('Fechada comunicação com a COM%d', [comNumber]));
  ReplyMemo.Lines.Add(DupeString('-', 15));
end;

procedure TMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  ApdComPort.Open := False;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  FTankNumber := 1;
end;

procedure TMainForm.FormShow(Sender: TObject);
begin
  with ApdComPort do
  begin
    Baud := 1200;
    DataBits := 7;
    Parity := pOdd;
    StopBits := 1;

    //Open := True;
  end;

  FReply := EmptyStr;
  FClosed := False;
end;

procedure TMainForm.SendButtonClick(Sender: TObject);
var
  cmd: String;
  i: byte;
begin
  CheckTankNumber;

  if FClosed then
    ApdComPort.ComNumber := 0;

  if not ApdComPort.Open then
    ApdComPort.Open := True;
  try
    cmd := Format('*4%.2d*', [FTankNumber]);
    ApdComPort.Output := AnsiString(cmd);
    ReplyMemo.Lines.Add('Enviado ' + cmd);

    i := 1;
    repeat
      Sleep(50);
      Application.ProcessMessages;
      inc(i);
    until i = 10;

    ReplyMemo.Lines.Add('Recebido ' + FReply);

  finally
    Inc(FTankNumber);
  end;
end;

end.
