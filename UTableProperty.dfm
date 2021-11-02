object FmTableProperty: TFmTableProperty
  Left = 348
  Top = 326
  BorderStyle = bsDialog
  Caption = #34920#26684#23646#24615#35774#32622
  ClientHeight = 393
  ClientWidth = 265
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    AlignWithMargins = True
    Left = 4
    Top = 10
    Width = 257
    Height = 381
    Margins.Left = 4
    Margins.Top = 10
    Margins.Right = 4
    Margins.Bottom = 2
    Align = alClient
    Caption = #34920#26684
    TabOrder = 0
    ExplicitLeft = 8
    ExplicitTop = 7
    ExplicitWidth = 161
    ExplicitHeight = 248
    object Label1: TLabel
      Left = 64
      Top = 64
      Width = 33
      Height = 13
      Caption = #34892#25968
    end
    object Label2: TLabel
      Left = 64
      Top = 121
      Width = 33
      Height = 13
      Caption = #21015#25968
    end
    object Label3: TLabel
      Left = 64
      Top = 184
      Width = 33
      Height = 13
      Caption = #23485#24230
    end
    object Label4: TLabel
      Left = 64
      Top = 248
      Width = 33
      Height = 13
      Caption = #20301#32622
    end
    object SpinEdit1: TJvSpinEdit
      Left = 64
      Top = 83
      Width = 121
      Height = 21
      Value = 4.000000000000000000
      ImeName = #35895#27468#25340#38899#36755#20837#27861' 2'
      TabOrder = 0
    end
    object SpinEdit2: TJvSpinEdit
      Left = 64
      Top = 140
      Width = 121
      Height = 21
      Value = 4.000000000000000000
      ImeName = #35895#27468#25340#38899#36755#20837#27861' 2'
      TabOrder = 1
    end
    object SpinEdit3: TJvSpinEdit
      Tag = 100
      Left = 64
      Top = 203
      Width = 121
      Height = 21
      Value = 600.000000000000000000
      ImeName = #35895#27468#25340#38899#36755#20837#27861' 2'
      TabOrder = 2
    end
    object ComboBox1: TComboBox
      Left = 64
      Top = 267
      Width = 121
      Height = 21
      ItemIndex = 0
      TabOrder = 3
      Text = #24038#23545#40784
      Items.Strings = (
        #24038#23545#40784
        #23621#20013
        #21491#23545#40784)
    end
  end
  object BtnOK: TBitBtn
    Left = 83
    Top = 360
    Width = 75
    Height = 25
    Caption = #30830#23450
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object BtnCancel: TBitBtn
    Left = 172
    Top = 360
    Width = 75
    Height = 25
    Cancel = True
    Caption = #21462#28040
    ModalResult = 2
    TabOrder = 2
  end
end
