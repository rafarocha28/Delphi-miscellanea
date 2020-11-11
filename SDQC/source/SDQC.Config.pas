unit SDQC.Config;

interface

uses
  AdPort;

type
  {$SCOPEDENUMS ON}
  TSDQCParity = (None, Odd, Even, Mark, Space);
  TSDQCHardwareFlow = (UseDTR, UseRTS, RequireDSR, RequireCTS);
  TSDQCSoftwareFlow = (None, Receive, Transmit, Both);
  {$SCOPEDENUMS OFF}

  TSDQCHardwareFlowSet = set of TSDQCHardwareFlow;

  TSerialConfiguration = record
  public
    ComNumber: Word;
    BaudRate : Cardinal;
    DataBits : Word;
    Parity   : TSDQCParity;
    StopBits : Word;
    HWFlowOptions: TSDQCHardwareFlowSet;
    SWFlowOptions: TSDQCSoftwareFlow;
    procedure AssignToApdComPort(AApdComPort: TApdComPort);
  end;

implementation

procedure TSerialConfiguration.AssignToApdComPort(AApdComPort: TApdComPort);
begin
  AApdComPort.ComNumber := ComNumber;
  AApdComPort.Baud := BaudRate;
  AApdComPort.DataBits := DataBits;
  AApdComPort.StopBits := StopBits;
  AApdComPort.Parity := TParity(Ord(Parity));
  AApdComPort.SWFlowOptions := TSWFlowOptions(Ord(SWFlowOptions));

  if TSDQCHardwareFlow.UseDTR in HWFlowOptions then
    AApdComPort.HWFlowOptions := AApdComPort.HWFlowOptions + [hwfUseDTR];
  if TSDQCHardwareFlow.UseRTS in HWFlowOptions then
    AApdComPort.HWFlowOptions := AApdComPort.HWFlowOptions + [hwfUseRTS];
  if TSDQCHardwareFlow.RequireDSR in HWFlowOptions then
   AApdComPort.HWFlowOptions := AApdComPort.HWFlowOptions + [hwfRequireDSR];
  if TSDQCHardwareFlow.RequireCTS in HWFlowOptions then
    AApdComPort.HWFlowOptions := AApdComPort.HWFlowOptions + [hwfRequireCTS];
end;

end.
