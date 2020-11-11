unit Log.Level;

interface

type
{$SCOPEDENUMS ON}
  TLogType = (Error, Warning, Info, Diag, Debug);
{$SCOPEDENUMS OFF}
  TLogLevel = set of TLogType;

resourcestring
  sLogTypeError = 'Error';
  sLogTypeWarning = 'Warning';
  sLogTypeInformation = 'Info';
  sLogTypeDiag = 'Diag';
  sLogTypeDebug = 'Debug';
const
  LogType: array[Low(TLogType) .. High(TLogType)] of String = (sLogTypeError,
    sLogTypeWarning, sLogTypeInformation, sLogTypeDiag, sLogTypeDebug);

implementation

end.
