unit SDQC.Forecourt.WayneFusion;

interface

uses
  SDQC.Util.WayneFusionConstantes,
  SDQC.Forecourt.Abstract;

type
  TWayneFusion = class(TAbstractForecourt)
  protected
    function GetStartPosition(AHaystack, ANeedle: String): Integer;
    function GetStatusReply(AReceivedCommand: String): String;
    function GetPumpGetTotalsReply(AReceivedCommand: String): String;
    function GetPumpGetSaleDetail(AReceivedCommand: String): String;
  public
    function GetReply(AReceivedCommand: String): String; override;
  end;

implementation

uses
  System.SysUtils,
  System.StrUtils;

function TWayneFusion.GetStartPosition(AHaystack: string;
  ANeedle: string): Integer;
begin
  Result := Pos(ANeedle, AHaystack) + Length(ANeedle);
end;

function TWayneFusion.GetPumpGetTotalsReply(AReceivedCommand: string): String;
begin
  Result := EmptyStr; // todo
end;

function TWayneFusion.GetStatusReply(AReceivedCommand: string): String;
const
  NUMBER_LENGTH = 3;
var
  number, startPosition: Integer;
begin
  startPosition := GetStartPosition(AReceivedCommand, COMMAND_PUMP_STATUS);
  number := StrToIntDef(Copy(AReceivedCommand, startPosition, NUMBER_LENGTH), 1);
  Result := Format(sStatusReply, [number]);
end;

function TWayneFusion.GetPumpGetSaleDetail(AReceivedCommand: String): String;
begin
  Randomize;
  if Random(2) = 0 then // simula uma moeda, apenas duas possibilidades
    Result := sSaleDetailReplyTag
  else
    Result := sSaleDetailReplyNoTag;
end;

function TWayneFusion.GetReply(AReceivedCommand: String): String;
begin
  Result := EmptyStr;

  if ContainsStr(AReceivedCommand, COMMAND_PUMP_STATUS) then
    Exit(GetStatusReply(AReceivedCommand));

  if ContainsStr(AReceivedCommand, COMMAND_PUMP_GET_TOTALS) then
    Exit(GetPumpGetTotalsReply(AReceivedCommand));

  if ContainsStr(AReceivedCommand, COMMAND_GET_SALE_DETAIL) then
    Exit(GetPumpGetSaleDetail(AReceivedCommand));

end;

end.
