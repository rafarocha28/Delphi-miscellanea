unit SDQC.Forecourt.VeederRoot;

interface

uses
  SDQC.Forecourt.Abstract;

type
  TVeederRoot = class(TAbstractForecourt)
  protected
    function GetTankReportComputerFormatReply(AReceivedCommand: String): String;
    function GetTankReportDisplayFormatReply(AReceivedCommand: String): String;
  public
    function GetReply(AReceivedCommand: String): String; override;
  end;

implementation

uses
  System.StrUtils,
  System.SysUtils,
  SDQC.Util.VeederRootConstantes;

function TVeederRoot.GetTankReportComputerFormatReply(AReceivedCommand: String)
  : String;
var
  tankNumber: Integer;
begin
  tankNumber := StrToIntDef(Copy(AReceivedCommand,
    Pos(VEEDER_TANK_REPORT_COMPUTER_FORMAT, AReceivedCommand) +
    Length(VEEDER_TANK_REPORT_COMPUTER_FORMAT), 2), 1);

  if (tankNumber < Low(TankReportRepliesComputerFormat)) or
    (tankNumber > High(TankReportRepliesComputerFormat)) then
    Result := ERROR_REPLY
  else
    Result := Format('%s%s%s',
      [SOH, TankReportRepliesComputerFormat[tankNumber], ETX]);
end;

function TVeederRoot.GetTankReportDisplayFormatReply(AReceivedCommand: String)
  : String;
var
  tankNumber: Integer;
  header: String;
begin
  tankNumber := StrToIntDef(Copy(AReceivedCommand,
    Pos(VEEDER_TANK_REPORT_DISPLAY_FORMAT, AReceivedCommand) +
    Length(VEEDER_TANK_REPORT_DISPLAY_FORMAT), 2), 1);

  if (tankNumber < Low(TankReportRepliesDisplayFormat)) or
    (tankNumber > High(TankReportRepliesDisplayFormat)) then
    Result := ERROR_REPLY
  else
  begin
    header := Format(sDisplayFormatHeader, [Copy(AReceivedCommand, 2, 6)]);
    Result := Format('%s%s%s%s',
      [SOH, header, TankReportRepliesDisplayFormat[tankNumber], ETX]);
  end;
end;

function TVeederRoot.GetReply(AReceivedCommand: string): String;
begin
  Result := EmptyStr;

  if ContainsStr(AReceivedCommand, VEEDER_SET_TIME_OF_DAY_COMPUTER_FORMAT) then
    Exit(VEEDER_SET_TIME_OF_DAY_RESPONSE_COMPUTER_FORMAT);

  if ContainsStr(AReceivedCommand, VEEDER_SET_TIME_OF_DAY_DISPLAY_FORMAT) then
    Exit(VEEDER_SET_TIME_OF_DAY_RESPONSE_DISPLAY_FORMAT);

  if ContainsStr(AReceivedCommand, VEEDER_TANK_REPORT_COMPUTER_FORMAT) then
    Exit(GetTankReportComputerFormatReply(AReceivedCommand));

  if ContainsStr(AReceivedCommand, VEEDER_TANK_REPORT_DISPLAY_FORMAT) then
    Exit(GetTankReportDisplayFormatReply(AReceivedCommand));
end;

end.
