unit Log.Abstract;

interface

uses
  System.SysUtils,
  System.SyncObjs,
  Log.Intf,
  Log.Level;

type
  TPFCBILogFileProperties = class
  private
    FFileNameModifier: String;
    FRelativePath: String;
    FExtension: String;
    function GetExtension: String;
    function GetRelativePath: String;
    procedure SetExtension(const Value: String);
    procedure SetRelativePath(const Value: String);
  public
    constructor Create;
    property Modifier: String read FFileNameModifier
      write FFileNameModifier;
    property RelativePath: String read GetRelativePath write SetRelativePath;
    property Extension: String read GetExtension write SetExtension;
  public const
    DEFAULT_RELATIVE_PATH = '..\log\';
    DEFAULT_EXTENSION = '.log';
  end;

  TPFCBILog = class abstract(TAggregatedObject, ILog)
  private
    FLevel: TLogLevel;
    FFileProperties: TPFCBILogFileProperties;
    FLock: TCriticalSection;
    function GetFileNameHelper(ADate: TDateTime): String;
  protected
    function GetLogLevel: TLogLevel;
    procedure SetLogLevel(Value: TLogLevel);
    function GetFileName: String; virtual; final;
    procedure SetFileName(Value: String); virtual; final;
    function GetFolder: String;
    procedure Init; virtual;
  public
    constructor Create;
    destructor Destroy; override;
    function Write(const AMessage: string; const ALogType: TLogType)
      : Boolean; overload;
    function Write(const AMessage: String; const Args: array of const;
      const ALogType: TLogType): Boolean; overload;
    function Write(const AMessage: String): Boolean; overload;
    function Write(const AMessage: String; const Args: array of const)
      : Boolean; overload;
    function DeleteLogs(AQuantity: Cardinal): Boolean;
    procedure AddLogType(ALogType: TLogType);
    procedure RemoveLogType(ALogType: TLogType);
    property Level: TLogLevel read GetLogLevel write SetLogLevel;
    property FileName: String read GetFileName write SetFileName;
    property FileProperties: TPFCBILogFileProperties
      read FFileProperties;
  end;

implementation

uses
  System.Classes, Log.Exceptions;

{ TLog }

procedure TPFCBILog.AddLogType(ALogType: TLogType);
var
  auxLevel: TLogLevel;
begin
  if not(ALogType in Level) then
  begin
    auxLevel := Level;
    Include(auxLevel, ALogType);
    Level := auxLevel;
  end;
end;

constructor TPFCBILog.Create;
begin
  Init;
end;

function TPFCBILog.DeleteLogs(AQuantity: Cardinal): Boolean;
var
  srec: TSearchRec;
  res: Integer;
begin
  Result := False;
  with TStringList.Create do
    try
      res := FindFirst(GetFileNameHelper(0), faAnyFile, srec);
      while res = 0 do
      begin
        Add(srec.Name);
        res := FindNext(srec);
      end;
      FindClose(srec);

      Sorted := True;
      while Count > AQuantity do
      begin
        DeleteFile(GetFolder + Strings[0]);
        Delete(0);
      end;
      Result := True;
    finally
      Free;
    end;
end;

destructor TPFCBILog.Destroy;
begin
  if Assigned(FLock) then
    FLock.Free;
  inherited;
end;

function TPFCBILog.GetFileName: String;
begin
  Result := GetFileNameHelper(Date);
end;

function TPFCBILog.GetFileNameHelper(ADate: TDateTime): String;
begin
  with FileProperties do
  if ADate > 0 then
    Result := Format('%s%sPFCBI_%s_%s%s',
      [IncludeTrailingPathDelimiter(GetCurrentDir), RelativePath, Modifier,
      FormatDateTime('yymmdd', ADate), Extension])
  else
    Result := Format('%s%sPFCBI_%s_*%s',
      [IncludeTrailingPathDelimiter(GetCurrentDir), RelativePath, Modifier,
      Extension]);
end;

function TPFCBILog.GetFolder: String;
begin
  Result := IncludeTrailingPathDelimiter(GetCurrentDir) +
    FileProperties.RelativePath;
end;

function TPFCBILog.GetLogLevel: TLogLevel;
begin
  Result := FLevel;
end;

procedure TPFCBILog.Init;
begin
  FFileProperties := TPFCBILogFileProperties.Create;
  FLock := TCriticalSection.Create;
  FLevel := [TLogType.Error, TLogType.Warning, TLogType.Info,
    TLogType.Diag, TLogType.Debug];
end;

procedure TPFCBILog.RemoveLogType(ALogType: TLogType);
var
  auxLevel: TLogLevel;
begin
  if ALogType in Level then
  begin
    auxLevel := Level;
    Exclude(auxLevel, ALogType);
    Level := auxLevel;
  end;
end;

procedure TPFCBILog.SetFileName(Value: String);
begin
  raise ELogFileNameWrite.Create('Utilize FileProperties para alterar o nome'+
  ' do arquivo');
end;

procedure TPFCBILog.SetLogLevel(Value: TLogLevel);
begin
  if FLevel <> Value then
    FLevel := Value;
end;

function TPFCBILog.Write(const AMessage: String): Boolean;
begin
  Result := Write(AMessage, TLogType.Info);
end;

function TPFCBILog.Write(const AMessage: String;
  const Args: array of const): Boolean;
begin
  Result := Write(Format(AMessage, Args), TLogType.Info);
end;

function TPFCBILog.Write(const AMessage: string;
  const ALogType: TLogType): Boolean;
var
  i: Integer;
  s1: string;
  Arq: TextFile;
  FileName: TFileName;
begin
  Result := False;
  FLock.Enter;
  try
    if ALogType in Level then
    begin
      FileName := GetFileName;
      ForceDirectories(ExtractFilePath(FileName));
      AssignFile(Arq, FileName);
      try
        if FileExists(FileName) then
          Append(Arq)
        else
          Rewrite(Arq);

        s1 := String.Empty;

        // for i := 1 to Length(AMessage) do
        // case AMessage[i] of
        // #13:
        // s1 := s1 + '<#13>';
        // #10:
        // s1 := s1 + '<#10>';
        // else
        // s1 := s1 + AMessage[i];
        // end;

        Writeln(Arq, Format('%s | %-5s | %s', [FormatDateTime('hh:nn:ss:zzz',
          Now), LogType[ALogType], s1]));
        Result := True;
      finally
        CloseFile(Arq);
      end;
    end;
  finally
    FLock.Leave;
  end;
end;

function TPFCBILog.Write(const AMessage: String; const Args: array of const;
  const ALogType: TLogType): Boolean;
begin
  Result := Write(Format(AMessage, Args), ALogType);
end;

{ TPFCBILogFileProperties }

constructor TPFCBILogFileProperties.Create;
begin
  Modifier := String.Empty;
  RelativePath := DEFAULT_RELATIVE_PATH;
  Extension := DEFAULT_EXTENSION;
end;

function TPFCBILogFileProperties.GetExtension: String;
begin
  Result := FExtension;
end;

function TPFCBILogFileProperties.GetRelativePath: String;
begin
  Result := IncludeTrailingPathDelimiter(FRelativePath);
end;

procedure TPFCBILogFileProperties.SetExtension(const Value: String);
begin
  if FExtension <> Value then
  begin
    if Value[1] = '.' then
      FExtension := Value
    else
      FExtension := '.' + Value;
  end;
end;

procedure TPFCBILogFileProperties.SetRelativePath(const Value: String);
begin
  if FRelativePath <> Value then
  begin
    if Copy(Value, 1, 3) = '..\' then
      FRelativePath := Value
    else
      FRelativePath := '..\' + Value;
  end;
end;

end.
