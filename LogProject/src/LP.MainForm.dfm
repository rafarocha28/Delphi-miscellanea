object MainLogsForm: TMainLogsForm
  Left = 0
  Top = 0
  Caption = 'Teste Logs'
  ClientHeight = 299
  ClientWidth = 571
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 15
  object Panel: TPanel
    Left = 0
    Top = 57
    Width = 571
    Height = 242
    Align = alClient
    TabOrder = 0
    ExplicitTop = 29
    ExplicitHeight = 270
    DesignSize = (
      571
      242)
    object ActivityIndicator: TActivityIndicator
      Left = 98
      Top = 40
      IndicatorSize = aisLarge
    end
    object ToggleSwitch: TToggleSwitch
      Left = 98
      Top = 186
      Width = 73
      Height = 20
      TabOrder = 1
      OnClick = ToggleSwitchClick
    end
    object Memo: TMemo
      Left = 312
      Top = 6
      Width = 249
      Height = 227
      Anchors = [akTop, akRight, akBottom]
      ScrollBars = ssVertical
      TabOrder = 2
      ExplicitHeight = 235
    end
  end
  object TopPanel: TPanel
    Left = 0
    Top = 0
    Width = 571
    Height = 57
    Align = alTop
    TabOrder = 1
    object GeralLabel: TLabel
      Left = 24
      Top = 13
      Width = 55
      Height = 15
      Caption = 'GeralLabel'
    end
    object FuelLabel: TLabel
      Left = 24
      Top = 34
      Width = 50
      Height = 15
      Caption = 'FuelLabel'
    end
  end
end
