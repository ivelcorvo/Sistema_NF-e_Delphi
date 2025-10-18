inherited FormProdutos_INSERIR: TFormProdutos_INSERIR
  Caption = 'Adicionar produto'
  StyleElements = [seFont, seClient, seBorder]
  TextHeight = 15
  inherited LabelNomeProduto: TLabel
    StyleElements = [seFont, seClient, seBorder]
  end
  inherited LabelPrecoProduto: TLabel
    StyleElements = [seFont, seClient, seBorder]
  end
  inherited LabelEstoqueProduto: TLabel
    StyleElements = [seFont, seClient, seBorder]
  end
  inherited EditNomeProduto: TEdit
    StyleElements = [seFont, seClient, seBorder]
  end
  inherited EditPrecoProduto: TEdit
    StyleElements = [seFont, seClient, seBorder]
  end
  inherited EditEstoqueProduto: TEdit
    StyleElements = [seFont, seClient, seBorder]
  end
  inherited ButtonCancelar: TButton
    OnClick = ButtonCancelarClick
  end
  inherited ButtonSalvar: TButton
    OnClick = ButtonSalvarClick
  end
end
