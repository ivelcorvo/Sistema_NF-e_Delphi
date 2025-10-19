inherited FormClientes_INSERIR: TFormClientes_INSERIR
  Caption = 'Adicionar cliente'
  StyleElements = [seFont, seClient, seBorder]
  OnCreate = FormCreate
  TextHeight = 15
  inherited LabelNome: TLabel
    StyleElements = [seFont, seClient, seBorder]
  end
  inherited LabelTipoPessoa: TLabel
    StyleElements = [seFont, seClient, seBorder]
  end
  inherited Label_CPF_CNPJ: TLabel
    Width = 53
    Caption = 'CPF_CNPJ'
    StyleElements = [seFont, seClient, seBorder]
    ExplicitWidth = 53
  end
  inherited LabelIE: TLabel
    StyleElements = [seFont, seClient, seBorder]
  end
  inherited LabelEndereco: TLabel
    StyleElements = [seFont, seClient, seBorder]
  end
  inherited LabelNumero: TLabel
    StyleElements = [seFont, seClient, seBorder]
  end
  inherited LabelBairrao: TLabel
    StyleElements = [seFont, seClient, seBorder]
  end
  inherited LabelCidade: TLabel
    StyleElements = [seFont, seClient, seBorder]
  end
  inherited LabelEmail: TLabel
    StyleElements = [seFont, seClient, seBorder]
  end
  inherited LabelUF: TLabel
    StyleElements = [seFont, seClient, seBorder]
  end
  inherited LabelCEP: TLabel
    StyleElements = [seFont, seClient, seBorder]
  end
  inherited LabelTelefone: TLabel
    StyleElements = [seFont, seClient, seBorder]
  end
  inherited EditNome: TEdit
    StyleElements = [seFont, seClient, seBorder]
  end
  inherited MaskEdit_CPF_CNPJ: TMaskEdit
    StyleElements = [seFont, seClient, seBorder]
  end
  inherited ComboBoxTipoPessoa: TComboBox
    Left = 8
    Width = 148
    StyleElements = [seFont, seClient, seBorder]
    OnChange = ComboBoxTipoPessoaChange
    ExplicitLeft = 8
    ExplicitWidth = 148
  end
  inherited EditIE: TEdit
    StyleElements = [seFont, seClient, seBorder]
  end
  inherited EditEndereco: TEdit
    StyleElements = [seFont, seClient, seBorder]
  end
  inherited EditNumero: TEdit
    StyleElements = [seFont, seClient, seBorder]
  end
  inherited EditBairrao: TEdit
    StyleElements = [seFont, seClient, seBorder]
  end
  inherited EditCidade: TEdit
    StyleElements = [seFont, seClient, seBorder]
  end
  inherited EditEmail: TEdit
    StyleElements = [seFont, seClient, seBorder]
  end
  inherited ComboBoxUF: TComboBox
    StyleElements = [seFont, seClient, seBorder]
  end
  inherited MaskEditCEP: TMaskEdit
    StyleElements = [seFont, seClient, seBorder]
  end
  inherited EditTelefone: TEdit
    StyleElements = [seFont, seClient, seBorder]
  end
  inherited ButtonSalvar: TButton
    OnClick = ButtonSalvarClick
  end
  inherited ButtonCancelar: TButton
    OnClick = ButtonCancelarClick
  end
end
