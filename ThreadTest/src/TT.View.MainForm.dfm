object MainForm: TMainForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'Thread Test'
  ClientHeight = 299
  ClientWidth = 173
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'Crimson Text'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 21
  object ListMemo: TMemo
    Left = 8
    Top = 8
    Width = 161
    Height = 283
    Lines.Strings = (
      'ListMemo')
    TabOrder = 0
  end
end
