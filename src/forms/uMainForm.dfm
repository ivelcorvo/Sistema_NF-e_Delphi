object MainForm: TMainForm
  Left = 0
  Top = 0
  Align = alClient
  ClientHeight = 441
  ClientWidth = 624
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Menu = MainMenu1
  WindowState = wsMaximized
  TextHeight = 15
  object MainMenu1: TMainMenu
    Left = 304
    Top = 224
    object Gesto1: TMenuItem
      Caption = 'Gest'#227'o'
      object GestaoOPClientes: TMenuItem
        Caption = 'Clientes'
        ShortCut = 112
      end
      object GestaoOPProdutos: TMenuItem
        Caption = 'Produtos'
        ShortCut = 113
      end
    end
  end
end
