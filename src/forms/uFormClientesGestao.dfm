inherited FormClientesGestao: TFormClientesGestao
  Caption = 'FormClientesGestao'
  StyleElements = [seFont, seClient, seBorder]
  TextHeight = 15
  inherited PageControl1: TPageControl
    ExplicitLeft = 0
    ExplicitTop = 57
    ExplicitWidth = 1152
    ExplicitHeight = 384
  end
  inherited PanelTitulo: TPanel
    StyleElements = [seFont, seClient, seBorder]
    ExplicitLeft = 0
    ExplicitWidth = 1208
    inherited LabelTituloForm: TLabel
      Width = 77
      Caption = 'Clientes'
      StyleElements = [seFont, seClient, seBorder]
      ExplicitWidth = 77
    end
    inherited PanelPesquisa: TPanel
      StyleElements = [seFont, seClient, seBorder]
      ExplicitLeft = 584
      inherited EditPesquisa: TEdit
        StyleElements = [seFont, seClient, seBorder]
      end
    end
  end
  inherited PanelBotoes: TPanel
    StyleElements = [seFont, seClient, seBorder]
    ExplicitLeft = 1152
    ExplicitTop = 57
    ExplicitHeight = 384
  end
end
