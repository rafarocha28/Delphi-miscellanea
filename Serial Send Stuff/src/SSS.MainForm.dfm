object MainForm: TMainForm
  Left = 0
  Top = 0
  Caption = 'Serial Send Stuff'
  ClientHeight = 300
  ClientWidth = 635
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object SendButton: TButton
    Left = 152
    Top = 267
    Width = 75
    Height = 25
    Caption = 'Send'
    TabOrder = 0
    OnClick = SendButtonClick
  end
  object ReplyMemo: TMemo
    Left = 8
    Top = 8
    Width = 625
    Height = 253
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Consolas'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
  end
  object ClosePortButton: TButton
    Left = 432
    Top = 267
    Width = 75
    Height = 25
    Caption = 'Close Port'
    TabOrder = 2
    OnClick = ClosePortButtonClick
  end
  object ApdComPort: TApdComPort
    Baud = 1200
    DataBits = 7
    AutoOpen = False
    TraceName = 'APRO.TRC'
    LogName = 'APRO.LOG'
    OnTriggerAvail = ApdComPortTriggerAvail
    Left = 504
    Top = 72
  end
end
