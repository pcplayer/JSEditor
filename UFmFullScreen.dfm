object FmFullScreen: TFmFullScreen
  Left = 232
  Top = 311
  Caption = 'FmFullScreen'
  ClientHeight = 416
  ClientWidth = 592
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Image1: TImage
    Left = 0
    Top = 0
    Width = 592
    Height = 366
    Align = alClient
    PopupMenu = PopupMenu1
    OnDblClick = Image1DblClick
    OnMouseDown = Image1MouseDown
    OnMouseMove = Image1MouseMove
    OnMouseUp = Image1MouseUp
  end
  object PanelTool: TPanel
    Left = 0
    Top = 366
    Width = 592
    Height = 50
    Align = alBottom
    TabOrder = 0
    object RzBitBtn1: TBitBtn
      Left = 312
      Top = 16
      Width = 75
      Height = 25
      Action = AcOK
      Caption = #30830#23450
      TabOrder = 0
    end
    object RzBitBtn2: TBitBtn
      Left = 408
      Top = 16
      Width = 75
      Height = 25
      Action = AcCancel
      Caption = #21462#28040
      TabOrder = 1
    end
  end
  object Panel1: TPanel
    Left = 8
    Top = 8
    Width = 305
    Height = 113
    Alignment = taLeftJustify
    Caption = #23631#24149#25130#22270#65306#25302#21160#40736#26631#36873#25321#25130#22270#21306#22495#21518#21452#20987#40736#26631#23436#25104#25130#22270#12290
    ParentBackground = False
    TabOrder = 1
    OnMouseMove = Panel1MouseMove
  end
  object ActionList1: TActionList
    Left = 400
    Top = 168
    object AcOK: TAction
      Caption = #30830#23450
    end
    object AcCancel: TAction
      Caption = #21462#28040
    end
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 300
    OnTimer = Timer1Timer
    Left = 240
    Top = 184
  end
  object PopupMenu1: TPopupMenu
    Left = 112
    Top = 272
    object N1: TMenuItem
      Caption = #25130#22270#21040#21098#36148#26495
      OnClick = N1Click
    end
  end
end
