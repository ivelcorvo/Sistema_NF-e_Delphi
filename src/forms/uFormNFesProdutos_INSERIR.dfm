inherited FormNFesProdutos_INSERIR: TFormNFesProdutos_INSERIR
  Caption = 'NF-e produto'
  StyleElements = [seFont, seClient, seBorder]
  TextHeight = 15
  inherited LabelProduto: TLabel
    StyleElements = [seFont, seClient, seBorder]
  end
  inherited LabelQuantidade: TLabel
    StyleElements = [seFont, seClient, seBorder]
  end
  inherited LabelPreco: TLabel
    StyleElements = [seFont, seClient, seBorder]
  end
  inherited LabelTotal: TLabel
    StyleElements = [seFont, seClient, seBorder]
  end
  inherited EditQuantidade: TEdit
    StyleElements = [seFont, seClient, seBorder]
  end
  inherited EditPreco: TEdit
    StyleElements = [seFont, seClient, seBorder]
  end
  inherited EditTotal: TEdit
    StyleElements = [seFont, seClient, seBorder]
  end
  inherited ButtonCancelar: TButton
    OnClick = ButtonCancelarClick
  end
  inherited ButtonAdicionar: TButton
    OnClick = ButtonAdicionarClick
  end
  inherited DBLookupComboBoxProduto: TDBLookupComboBox
    OnClick = DBLookupComboBoxProdutoClick
  end
end
