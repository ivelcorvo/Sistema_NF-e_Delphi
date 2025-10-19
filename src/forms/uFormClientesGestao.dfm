inherited FormClientesGestao: TFormClientesGestao
  Caption = 'FormClientesGestao'
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
    inherited ImageAdicinar: TImage
      OnClick = ImageAdicinarClick
    end
  end
end
