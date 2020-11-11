unit SDQC.Forecourt.ForecourtSimulator;

interface

type
  IForecourtSimulator = interface
    ['{500DEBFE-3438-442A-A9D8-B56A9B133B88}']
    function GetReply(AReceivedCommand: String): String;
  end;

implementation

end.
