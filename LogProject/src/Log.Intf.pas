unit Log.Intf;

interface

uses
  Log.Level;

type
  ILog = interface
    ['{44A3871E-897C-44A0-A986-99B2CFE35FF6}']
    function Write(const AMessage: string; const ALogType: TLogType)
      : Boolean; overload;
    function Write(const AMessage: String; const Args: array of const;
      const ALogType: TLogType): Boolean; overload;
    function Write(const AMessage: String): Boolean; overload;
    function Write(const AMessage: String; const Args: array of const)
      : Boolean; overload;
    function DeleteLogs(AQuantity: Cardinal): Boolean;
    function GetLogLevel: TLogLevel;
    procedure SetLogLevel(Value: TLogLevel);
    function GetFileName: String;
    procedure SetFileName(Value: String);
    property Level: TLogLevel read GetLogLevel write SetLogLevel;
    property FileName: String read GetFileName write SetFileName;
  end;

implementation

end.
