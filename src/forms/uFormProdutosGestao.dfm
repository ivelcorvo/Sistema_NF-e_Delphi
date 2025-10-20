inherited FormProdutosGestao: TFormProdutosGestao
  Caption = 'Gest'#227'o produtos'
  StyleElements = [seFont, seClient, seBorder]
  OnShow = FormShow
  TextHeight = 15
  inherited PanelTitulo: TPanel
    StyleElements = [seFont, seClient, seBorder]
    inherited LabelTituloForm: TLabel
      Width = 90
      Caption = 'Produtos'
      StyleElements = [seFont, seClient, seBorder]
      ExplicitWidth = 90
    end
    inherited PanelPesquisa: TPanel
      StyleElements = [seFont, seClient, seBorder]
      inherited ImagePesquisa: TImage
        OnClick = ImagePesquisaClick
      end
      inherited EditPesquisa: TEdit
        StyleElements = [seFont, seClient, seBorder]
        OnKeyPress = EditPesquisaKeyPress
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
    end
    inherited ImageAdicinar: TImage
      OnClick = ImageAdicinarClick
    end
  end
end
