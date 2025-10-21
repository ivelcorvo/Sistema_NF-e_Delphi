inherited FormNFes_NOVA: TFormNFes_NOVA
  Caption = 'Nova NF-e'
  StyleElements = [seFont, seClient, seBorder]
  TextHeight = 15
  inherited PanelNFe: TPanel
    StyleElements = [seFont, seClient, seBorder]
    ExplicitWidth = 1335
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
    inherited ComboBoxCliente: TComboBox
      StyleElements = [seFont, seClient, seBorder]
    end
    inherited EditCFOP: TEdit
      StyleElements = [seFont, seClient, seBorder]
    end
    inherited EditNatureza: TEdit
      StyleElements = [seFont, seClient, seBorder]
    end
  end
  inherited PanelBotoes: TPanel
    StyleElements = [seFont, seClient, seBorder]
    ExplicitLeft = 1279
    ExplicitTop = 73
    ExplicitHeight = 407
    inherited ImageAdicinar: TImage
      OnClick = ImageAdicinarClick
    end
  end
end
