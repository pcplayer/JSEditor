object Form2: TForm2
  Left = 0
  Top = 0
  Caption = 'Use FrameEdgeEditor'
  ClientHeight = 651
  ClientWidth = 945
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 945
    Height = 651
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'TabSheet1'
      inline FrameEdgeEditor1: TFrameEdgeEditor
        Left = 0
        Top = 0
        Width = 937
        Height = 623
        Align = alClient
        TabOrder = 0
        ExplicitWidth = 937
        ExplicitHeight = 623
        inherited EdgeBrowser1: TEdgeBrowser
          Width = 937
          Height = 565
          ExplicitWidth = 937
          ExplicitHeight = 565
        end
        inherited JvToolBar2: TJvToolBar
          Width = 937
          ExplicitWidth = 937
        end
        inherited JvToolBar1: TJvToolBar
          Width = 937
          ExplicitWidth = 937
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'TabSheet2'
      ImageIndex = 1
      object Memo1: TMemo
        Left = 0
        Top = 0
        Width = 937
        Height = 623
        Align = alClient
        Lines.Strings = (
          'Memo1')
        ScrollBars = ssVertical
        TabOrder = 0
      end
    end
  end
  object SaveDialog1: TSaveDialog
    Left = 704
    Top = 8
  end
end
