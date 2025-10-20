inherited FormProdutos_EDITAR: TFormProdutos_EDITAR
  Caption = 'Editar produto'
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
  inherited LabelNCM: TLabel
    StyleElements = [seFont, seClient, seBorder]
  end
  inherited LabelCFOP: TLabel
    StyleElements = [seFont, seClient, seBorder]
  end
  inherited LabelUnidade: TLabel
    StyleElements = [seFont, seClient, seBorder]
  end
  inherited EditNomeProduto: TEdit
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
  inherited ComboBoxUnidade: TComboBox
    StyleElements = [seFont, seClient, seBorder]
  end
  inherited EditPrecoProduto: TEdit
    StyleElements = [seFont, seClient, seBorder]
  end
  inherited EditNCM: TEdit
    StyleElements = [seFont, seClient, seBorder]
  end
  inherited EditCFOP: TEdit
    StyleElements = [seFont, seClient, seBorder]
  end
end
