inherited FormClientesGestao: TFormClientesGestao
  Caption = 'Gest'#227'o clientes'
  StyleElements = [seFont, seClient, seBorder]
  OnShow = FormShow
  TextHeight = 15
  inherited PanelTitulo: TPanel
    StyleElements = [seFont, seClient, seBorder]
    inherited LabelTituloForm: TLabel
      Width = 77
      Caption = 'Clientes'
      StyleElements = [seFont, seClient, seBorder]
      ExplicitWidth = 77
    end
    inherited PanelPesquisa: TPanel
      StyleElements = [seFont, seClient, seBorder]
      inherited EditPesquisa: TEdit
        StyleElements = [seFont, seClient, seBorder]
      end
    end
  end
  inherited PanelBotoes: TPanel
    StyleElements = [seFont, seClient, seBorder]
    inherited ImageEditar: TImage
      OnClick = ImageEditarClick
    end
    inherited ImageExcluir: TImage
      OnClick = ImageExcluirClick
      ExplicitLeft = 6
      ExplicitTop = 115
    end
    inherited ImageAdicinar: TImage
      OnClick = ImageAdicinarClick
    end
  end
end
