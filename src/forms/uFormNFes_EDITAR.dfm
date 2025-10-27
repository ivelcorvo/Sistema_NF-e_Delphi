inherited FormNFes_EDITAR: TFormNFes_EDITAR
  Caption = 'Editar NF-e'
  StyleElements = [seFont, seClient, seBorder]
  OnClose = FormClose
  TextHeight = 15
  inherited PanelNFe: TPanel
    StyleElements = [seFont, seClient, seBorder]
    inherited Label1: TLabel
      StyleElements = [seFont, seClient, seBorder]
    end
    inherited LabelDataEmisao: TLabel
      StyleElements = [seFont, seClient, seBorder]
    end
    inherited LabelCFOP: TLabel
      StyleElements = [seFont, seClient, seBorder]
    end
    inherited LabelNatureza: TLabel
      StyleElements = [seFont, seClient, seBorder]
    end
    inherited EditCFOP: TEdit
      StyleElements = [seFont, seClient, seBorder]
    end
    inherited EditNatureza: TEdit
      StyleElements = [seFont, seClient, seBorder]
    end
    inherited ButtonCancelar: TButton
      OnClick = ButtonCancelarClick
    end
    inherited ButtonSalvar: TButton
      OnClick = ButtonSalvarClick
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
