object MainForm: TMainForm
  Left = 0
  Top = 0
  Caption = 'UniDac x FireDac'
  ClientHeight = 542
  ClientWidth = 1058
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object FireDacButton: TButton
    Left = 8
    Top = 8
    Width = 81
    Height = 25
    Caption = '&FireDac'
    TabOrder = 0
    OnClick = FireDacButtonClick
  end
  object UniDacButton: TButton
    Left = 95
    Top = 8
    Width = 75
    Height = 25
    Caption = '&UniDac'
    TabOrder = 1
    OnClick = UniDacButtonClick
  end
  object ClearButton: TButton
    Left = 257
    Top = 8
    Width = 75
    Height = 25
    Caption = '&Clear'
    Enabled = False
    TabOrder = 2
    OnClick = ClearButtonClick
  end
  object ResultListView: TListView
    AlignWithMargins = True
    Left = 3
    Top = 40
    Width = 1052
    Height = 373
    Margins.Top = 40
    Align = alClient
    Columns = <>
    ReadOnly = True
    RowSelect = True
    TabOrder = 3
    ViewStyle = vsReport
  end
  object LogMemo: TMemo
    AlignWithMargins = True
    Left = 3
    Top = 419
    Width = 1052
    Height = 120
    Align = alBottom
    ReadOnly = True
    ScrollBars = ssBoth
    TabOrder = 4
  end
  object BothButton: TButton
    Left = 176
    Top = 8
    Width = 75
    Height = 25
    Caption = '&Both'
    TabOrder = 5
    OnClick = BothButtonClick
  end
  object TimeCheckBox: TCheckBox
    Left = 352
    Top = 12
    Width = 49
    Height = 17
    Caption = '&Time'
    Checked = True
    State = cbChecked
    TabOrder = 6
    OnClick = Changed
  end
  object MemoCheckBox: TCheckBox
    Left = 407
    Top = 12
    Width = 58
    Height = 17
    Caption = '&Memory'
    Checked = True
    State = cbChecked
    TabOrder = 7
    OnClick = Changed
  end
  object SaveButton: TButton
    Left = 480
    Top = 8
    Width = 75
    Height = 25
    Caption = '&Save'
    TabOrder = 8
    OnClick = SaveButtonClick
  end
  object UniConnection1: TUniConnection
    ProviderName = 'InterBase'
    Port = 3050
    Database = 'rodocamp'
    SpecificOptions.Strings = (
      'InterBase.Charset=WIN1252')
    Username = 'sysdba'
    Server = 'localhost'
    LoginPrompt = False
    Left = 264
    Top = 112
    EncryptedPassword = '92FF9EFF8CFF8BFF9AFF8DFF94FF9AFF86FF'
  end
  object FDConnection1: TFDConnection
    Params.Strings = (
      'Database=rodocamp'
      'User_Name=sysdba'
      'Password=masterkey'
      'Server=localhost'
      'CharacterSet=WIN1252'
      'DriverID=FB'
      'Port=3050')
    LoginPrompt = False
    Left = 248
    Top = 176
  end
  object FDQuery1: TFDQuery
    Connection = FDConnection1
    FetchOptions.AssignedValues = [evRowsetSize]
    FetchOptions.RowsetSize = 0
    Left = 32
    Top = 96
  end
  object UniQuery1: TUniQuery
    Connection = UniConnection1
    Left = 144
    Top = 112
  end
  object InterBaseUniProvider1: TInterBaseUniProvider
    Left = 136
    Top = 208
  end
  object FDPhysFBDriverLink1: TFDPhysFBDriverLink
    Left = 24
    Top = 184
  end
  object FDTransaction1: TFDTransaction
    Connection = FDConnection1
    Left = 88
    Top = 352
  end
  object UniTransaction1: TUniTransaction
    DefaultConnection = UniConnection1
    Left = 264
    Top = 352
  end
  object transMasterUpdate: TUniTransaction
    DefaultConnection = UniConnection1
    Left = 384
    Top = 352
  end
  object FileSaveDialog: TFileSaveDialog
    FavoriteLinks = <>
    FileName = 'UnixDac.csv'
    FileTypes = <
      item
        DisplayName = 'Comma-separated values (*.csv)'
        FileMask = '*.csv'
      end>
    Options = []
    Left = 592
    Top = 152
  end
end
