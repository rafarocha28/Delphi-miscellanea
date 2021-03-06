unit SDQC.View.SerialConfig;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.CheckLst;

type
  TSerialConfigForm = class(TForm)
    SerialConfigGroupBox: TGroupBox;
    ComNumberLabel: TLabel;
    BaudRateLabel: TLabel;
    DataBitsLabel: TLabel;
    ParityLabel: TLabel;
    StopBitsLabel: TLabel;
    SWFlowOptions: TLabel;
    ComNumberCombo: TComboBox;
    BaudRateCombo: TComboBox;
    DataBitsCombo: TComboBox;
    ParityCombo: TComboBox;
    StopBitsCombo: TComboBox;
    FlowOptionsCombo: TComboBox;
    HWFlowLabel: TLabel;
    HWFlowOptionsCheckListBox: TCheckListBox;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SerialConfigForm: TSerialConfigForm;

implementation

{$R *.dfm}

procedure TSerialConfigForm.FormCreate(Sender: TObject);
begin
  AutoSize := True;
end;

end.
