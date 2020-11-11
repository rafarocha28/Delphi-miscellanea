unit SDQC.Util.LogFacade;

interface

uses
  System.Generics.Collections,
  Vcl.StdCtrls,
  Util.Log;

type
  TLogFacade = class
  private
    FMemoList: TObjectList<TCustomMemo>;
    FPFLog: TPFLog;
  protected
    property MemoList: TObjectList<TCustomMemo> read FMemoList;
    property PFLog: TPFLog read FPFLog;
  public
    constructor Create;
    destructor Destroy; override;
    procedure AddMemo(AMemo: TCustomMemo);
    procedure RemoveMemo(AMemo: TCustomMemo);
    procedure Write(AMsg: String); overload;
    procedure Write(AMsg: String; AArgs: array of const); overload;
    procedure WriteHeader(AMsg: String); overload;
    procedure WriteHeader(AMsg: String; AArgs: array of const); overload;
  end;

implementation

uses
  System.StrUtils,
  System.SysUtils,
  Vcl.Forms;
{ TLogFacade }

procedure TLogFacade.AddMemo(AMemo: TCustomMemo);
begin
  FMemoList.Add(AMemo);
end;

constructor TLogFacade.Create;
begin
  inherited;
  FMemoList := TObjectList<TCustomMemo>.Create(False);
  FPFLog := TPFLog.Create;
  FPFLog.LogFileNameModifier := 'sdqc';
end;

destructor TLogFacade.Destroy;
begin
  FPFLog.Free;
  FMemoList.Free;
  inherited;
end;

procedure TLogFacade.RemoveMemo(AMemo: TCustomMemo);
begin
  FMemoList.Remove(AMemo);
end;

procedure TLogFacade.Write(AMsg: String);
var
  cm: TCustomMemo;
begin
  PFLog.Write(AMsg, ltInformation);

  for cm in FMemoList do
    cm.Lines.Add(AMsg);
  Application.ProcessMessages;
end;

procedure TLogFacade.Write(AMsg: String; AArgs: array of const);
begin
  Write(Format(AMsg, AArgs));
end;

procedure TLogFacade.WriteHeader(AMsg: string);
begin
  Write(DupeString('*', 50));
  Write(AMsg);
  Write(DupeString('*', 50));
end;

procedure TLogFacade.WriteHeader(AMsg: string; AArgs: array of const);
begin
  WriteHeader(Format(AMsg, AArgs));
end;

end.
