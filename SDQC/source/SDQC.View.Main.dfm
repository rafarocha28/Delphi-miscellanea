object MainForm: TMainForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Simulador de Qualquer Coisa'
  ClientHeight = 495
  ClientWidth = 734
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'Verdana'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  DesignSize = (
    734
    495)
  PixelsPerInch = 96
  TextHeight = 18
  object MainPageControl: TPageControl
    Left = 8
    Top = 8
    Width = 718
    Height = 479
    ActivePage = SerialTabSheet
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 0
    object EthernetTabSheet: TTabSheet
      Caption = 'Ethernet'
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      DesignSize = (
        710
        446)
      object ReceiveEthernetGroupBox: TGroupBox
        Left = 3
        Top = 3
        Width = 704
        Height = 86
        Anchors = [akLeft, akTop, akRight]
        Caption = 'O que ser'#225' recebido?'
        TabOrder = 0
        DesignSize = (
          704
          86)
        object ContainsEthernetCheckBox: TCheckBox
          Left = 16
          Top = 57
          Width = 252
          Height = 17
          Hint = 'Pode ser apenas o come'#231'o, uma parte do meio ou at'#233' mesmo o final'
          Caption = 'Est'#225' contido na mensagem'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
        end
        object TextToBeReceivedEthernetEdit: TEdit
          Left = 16
          Top = 24
          Width = 678
          Height = 26
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 1
          OnEnter = TextToBeReceivedEthernetEditEnter
          OnExit = TextToBeReceivedEthernetEditExit
        end
      end
      object ReplyEthernetGroupBox: TGroupBox
        Left = 3
        Top = 95
        Width = 704
        Height = 234
        Anchors = [akLeft, akTop, akRight]
        Caption = 'O que ser'#225' enviado?'
        TabOrder = 1
        DesignSize = (
          704
          234)
        object ReplyEthernetMemo: TMemo
          Left = 16
          Top = 24
          Width = 677
          Height = 194
          Anchors = [akLeft, akTop, akRight]
          Lines.Strings = (
            '')
          ScrollBars = ssVertical
          TabOrder = 0
        end
      end
      object InfoEthernetGroupBox: TGroupBox
        Left = 3
        Top = 335
        Width = 347
        Height = 108
        Caption = 'Informa'#231#245'es'
        TabOrder = 2
        object LedEthernetShape: TShape
          Left = 11
          Top = 19
          Width = 33
          Height = 41
          Brush.Color = clRed
          Shape = stCircle
        end
        object LedEthernetLabel: TLabel
          Left = 50
          Top = 26
          Width = 106
          Height = 18
          Caption = 'DESATIVADO'
        end
        object ConnectedIPLabel: TLabel
          Left = 50
          Top = 50
          Width = 273
          Height = 18
          AutoSize = False
          Caption = 'IP Conectado: Nenhum'
        end
      end
      object OpenCloseEthernetGroupBox: TGroupBox
        Left = 358
        Top = 335
        Width = 349
        Height = 108
        Caption = 'Comunica'#231#227'o'
        TabOrder = 3
        DesignSize = (
          349
          108)
        object PortLabel: TLabel
          Left = 16
          Top = 26
          Width = 43
          Height = 18
          Anchors = []
          Caption = 'Porta'
          ExplicitTop = 25
        end
        object PortEdit: TEdit
          Left = 74
          Top = 23
          Width = 70
          Height = 26
          Anchors = []
          MaxLength = 5
          NumbersOnly = True
          TabOrder = 0
          Text = '1234'
        end
        object OpenCloseEthernetButton: TButton
          Left = 206
          Top = 22
          Width = 129
          Height = 67
          Caption = 'Ativar'
          TabOrder = 1
          OnClick = OpenCloseEthernetButtonClick
        end
      end
    end
    object SerialTabSheet: TTabSheet
      Caption = 'Serial'
      ImageIndex = 1
      DesignSize = (
        710
        446)
      object ReceiveSerialGroupBox: TGroupBox
        Left = 3
        Top = 3
        Width = 704
        Height = 86
        Anchors = [akLeft, akTop, akRight]
        Caption = 'O que ser'#225' recebido?'
        TabOrder = 0
        DesignSize = (
          704
          86)
        object ContainsSerialCheckBox: TCheckBox
          Left = 16
          Top = 57
          Width = 252
          Height = 17
          Hint = 'Pode ser apenas o come'#231'o, uma parte do meio ou at'#233' mesmo o final'
          Caption = 'Est'#225' contido na mensagem'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
        end
        object TextToBeReceivedSerialEdit: TEdit
          Left = 16
          Top = 24
          Width = 678
          Height = 26
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 1
          OnEnter = TextToBeReceivedSerialEditEnter
          OnExit = TextToBeReceivedSerialEditExit
        end
        object SpecifySizeSerialCheckBox: TCheckBox
          Left = 324
          Top = 57
          Width = 310
          Height = 17
          Hint = 
            'Indicar qual o tamanho da mensagem que ser'#225' recebida. Marque est' +
            'a op'#231#227'o se utilizar algum meio de comunica'#231#227'o que envia caracter' +
            ' a caracter, por exemplo.'
          Caption = 'Especificar tamanho da mensagem'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 2
          OnClick = SpecifySizeSerialCheckBoxClick
        end
        object SpecifySizeSerialEdit: TEdit
          Left = 644
          Top = 53
          Width = 49
          Height = 26
          Enabled = False
          NumbersOnly = True
          TabOrder = 3
          Text = '48'
          OnChange = SpecifySizeSerialEditChange
        end
      end
      object ReplySerialGroupBox: TGroupBox
        Left = 3
        Top = 95
        Width = 704
        Height = 234
        Anchors = [akLeft, akTop, akRight]
        Caption = 'O que ser'#225' enviado?'
        TabOrder = 1
        DesignSize = (
          704
          234)
        object ReplySerialMemo: TMemo
          Left = 16
          Top = 24
          Width = 677
          Height = 194
          Anchors = [akLeft, akTop, akRight]
          Lines.Strings = (
            '')
          ScrollBars = ssVertical
          TabOrder = 0
        end
      end
      object InfoSerialGroupBox: TGroupBox
        Left = 3
        Top = 335
        Width = 347
        Height = 108
        Caption = 'Informa'#231#245'es'
        TabOrder = 2
        object LedSerialShape: TShape
          Left = 11
          Top = 19
          Width = 33
          Height = 41
          Brush.Color = clRed
          Shape = stCircle
        end
        object LedSerialLabel: TLabel
          Left = 50
          Top = 34
          Width = 106
          Height = 18
          Caption = 'DESATIVADO'
        end
      end
      object OpenCloseSerialGroupBox: TGroupBox
        Left = 358
        Top = 335
        Width = 349
        Height = 108
        Caption = 'Comunica'#231#227'o'
        TabOrder = 3
        DesignSize = (
          349
          108)
        object COMLabel: TLabel
          Left = 16
          Top = 26
          Width = 37
          Height = 18
          Anchors = []
          Caption = 'COM'
          ExplicitTop = 25
        end
        object OpenCloseSerialButton: TButton
          Left = 206
          Top = 22
          Width = 129
          Height = 67
          Caption = 'Ativar'
          TabOrder = 0
          OnClick = OpenCloseSerialButtonClick
        end
        object COMEdit: TEdit
          Left = 74
          Top = 23
          Width = 70
          Height = 26
          Anchors = []
          MaxLength = 5
          NumbersOnly = True
          TabOrder = 1
          Text = '1'
        end
        object ConfigSerialButton: TButton
          Left = 16
          Top = 55
          Width = 75
          Height = 25
          Hint = 'Configura'#231#227'o avan'#231'ada'
          Caption = 'Avan'#231'ado'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Verdana'
          Font.Style = []
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 2
          OnClick = ConfigSerialButtonClick
        end
      end
    end
    object MonitorTabSheet: TTabSheet
      Caption = 'Monitor'
      ImageIndex = 2
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      DesignSize = (
        710
        446)
      object MonitorGroupBox: TGroupBox
        Left = 3
        Top = 3
        Width = 704
        Height = 440
        Anchors = [akLeft, akTop, akRight, akBottom]
        Caption = 'O que foi recebido e enviado'
        TabOrder = 0
        object MonitorMemo: TMemo
          Left = 16
          Top = 32
          Width = 673
          Height = 346
          ReadOnly = True
          ScrollBars = ssVertical
          TabOrder = 0
        end
        object ClearMonitorButton: TButton
          Left = 560
          Top = 384
          Width = 129
          Height = 37
          Caption = 'Limpar'
          TabOrder = 1
          OnClick = ClearMonitorButtonClick
        end
      end
    end
  end
  object ServerSocket1: TServerSocket
    Active = False
    Port = 0
    ServerType = stNonBlocking
    OnClientConnect = ServerSocket1ClientConnect
    OnClientDisconnect = ServerSocket1ClientDisconnect
    OnClientRead = ServerSocket1ClientRead
    Left = 504
    Top = 8
  end
  object ApdComPort1: TApdComPort
    Baud = 9600
    TraceName = 'APRO.TRC'
    LogName = 'APRO.LOG'
    OnTriggerAvail = ApdComPort1TriggerAvail
    Left = 568
    Top = 8
  end
end
