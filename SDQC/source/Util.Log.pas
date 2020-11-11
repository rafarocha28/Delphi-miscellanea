unit Util.Log;

interface

uses
  System.SysUtils;

type
  TLogType = (ltError, ltWarning, ltInformation, ltDebug);
  TLogLevel = set of TLogType;

  TPFLog = class
  private
    FLogFileName: TFileName;
    FFileNameModifier: TFileName;
  protected const
    DEFAULT_RELATIVE_PATH = '..\log\';
    DEFAULT_EXTENSION = '.log';
    DEFAULT_MODIFIER = 'pf';
  protected
    FLevel: TLogLevel;
    function GetFileName: TFileName; virtual;
    procedure SetFileName(const Value: TFileName); virtual;
    function LogToStr(const ALogType: TLogType): string; virtual;
  public
    constructor Create;
    procedure Write(const AMessage: string; const ALogType: TLogType); overload;
    procedure Write(const AMessage: String; const Args: array of const;
      const ALogType: TLogType); overload;
    procedure Write(const AMessage: String); overload;
    procedure Write(const AMessage: String;
      const Args: array of const); overload;
    property LogFileName: TFileName read GetFileName write SetFileName;
    property Level: TLogLevel read FLevel;
    property LogFileNameModifier: TFileName read FFileNameModifier
      write FFileNameModifier;
  end;

  const
    LOG_DEBUG_PARAM = 'logdebug';
    LOG_ERORR_PARAM = 'logerror';
    LOG_WARNING_PARAM = 'logwarning';
    LOG_INFORMATION_PARAM = 'loginfo';

implementation

uses
  System.StrUtils,
  Vcl.Forms;

{ TPFLog }

constructor TPFLog.Create;
begin
  inherited;
  if FindCmdLineSwitch(LOG_DEBUG_PARAM) then
    FLevel := [ltError, ltWarning, ltInformation, ltDebug]
  else if FindCmdLineSwitch(LOG_ERORR_PARAM) then
    FLevel := [ltError]
  else if FindCmdLineSwitch(LOG_WARNING_PARAM) then
    FLevel := [ltError, ltWarning]
  else // if FindCmdLineSwitch(LOG_INFORMATION_PARAM) then
    FLevel := [ltError, ltWarning, ltInformation];

  FLogFileName := EmptyStr;
  FFileNameModifier := EmptyStr;
end;

function TPFLog.GetFileName: TFileName;
var
  modifier: TFileName;
begin
  modifier := IfThen(SameText(FFileNameModifier, EmptyStr), DEFAULT_MODIFIER,
    FFileNameModifier);

  if SameText(FLogFileName, EmptyStr) then
    Result := ExpandFileName(ExtractFilePath(Application.ExeName) +
      DEFAULT_RELATIVE_PATH + modifier +
      FormatDateTime('YYYYMMDD', Date) + DEFAULT_EXTENSION)
  else
    Result := FLogFileName;
end;

procedure TPFLog.SetFileName(const Value: TFileName);
var
  aux: TFileName;
begin
  aux := Value;
  if SameText(ExtractFileExt(aux), EmptyStr) then
    ChangeFileExt(aux, DEFAULT_EXTENSION);

  FLogFileName := aux;
end;

procedure TPFLog.Write(const AMessage: string; const Args: array of const;
  const ALogType: TLogType);
begin
  Write(Format(AMessage, Args), ALogType);
end;

procedure TPFLog.Write(const AMessage: string);
begin
  Write(AMessage, ltInformation);
end;

procedure TPFLog.Write(const AMessage: string; const Args: array of const);
begin
  Write(Format(AMessage, Args), ltInformation);
end;

procedure TPFLog.Write(const AMessage: string; const ALogType: TLogType);
var
  i: Integer;
  s1: string;
  Arq: TextFile;
  FileName: TFileName;
begin
  if ALogType in FLevel then
  begin
    FileName := GetFileName;
    ForceDirectories(ExtractFilePath(FileName));
    AssignFile(Arq, FileName);
    try
      if FileExists(FileName) then
        Append(Arq)
      else
        Rewrite(Arq);

      s1 := '';

      for i := 1 to Length(AMessage) do
        case AMessage[i] of
          #13:
            s1 := s1 + '<#13>';
          #10:
            s1 := s1 + '<#10>';
        else
          s1 := s1 + AMessage[i];
        end;

      Writeln(Arq, Format('%s | %-5s | %s',
        [FormatDateTime('hh:nn:ss:zzz', Now), LogToStr(ALogType), s1]));
    finally
      CloseFile(Arq);
    end;
  end;
end;

function TPFLog.LogToStr(const ALogType: TLogType): String;
begin
  case ALogType of
    ltError:
      Result := 'Erro';
    ltWarning:
      Result := 'Aviso';
    ltInformation:
      Result := 'Info';
    ltDebug:
      Result := 'Debug';
  end;
end;

end.
