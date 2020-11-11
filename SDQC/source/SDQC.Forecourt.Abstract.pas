unit SDQC.Forecourt.Abstract;

interface

uses SDQC.Forecourt.ForecourtSimulator;

type
  TAbstractForecourt = class abstract(TAggregatedObject, IForecourtSimulator)
  public
    function GetReply(AReceivedCommand: String): String; virtual; abstract;
  end;

implementation

end.
