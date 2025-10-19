object FormTemplateClientes_INSERIR_EDITAR: TFormTemplateClientes_INSERIR_EDITAR
  Left = 0
  Top = 0
  Caption = 'FormTemplateClientes_INSERIR_EDITAR'
  ClientHeight = 402
  ClientWidth = 430
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object LabelNome: TLabel
    Left = 11
    Top = 17
    Width = 33
    Height = 15
    Caption = 'Nome'
  end
  object LabelTipoPessoa: TLabel
    Left = 11
    Top = 129
    Width = 79
    Height = 15
    Caption = 'Tipo de pessoa'
  end
  object Label_CPF_CNPJ: TLabel
    Left = 162
    Top = 129
    Width = 51
    Height = 15
    Caption = 'CPF CNPJ'
  end
  object LabelIE: TLabel
    Left = 323
    Top = 129
    Width = 9
    Height = 15
    Caption = 'IE'
  end
  object LabelEndereco: TLabel
    Left = 11
    Top = 241
    Width = 49
    Height = 15
    Caption = 'Endere'#231'o'
  end
  object LabelNumero: TLabel
    Left = 354
    Top = 241
    Width = 44
    Height = 15
    Caption = 'N'#250'mero'
  end
  object LabelBairrao: TLabel
    Left = 84
    Top = 297
    Width = 37
    Height = 15
    Caption = 'Bairrao'
  end
  object LabelCidade: TLabel
    Left = 11
    Top = 185
    Width = 37
    Height = 15
    Caption = 'Cidade'
  end
  object LabelEmail: TLabel
    Left = 11
    Top = 71
    Width = 34
    Height = 15
    Caption = 'E-Mail'
  end
  object LabelUF: TLabel
    Left = 354
    Top = 185
    Width = 14
    Height = 15
    Caption = 'UF'
  end
  object LabelCEP: TLabel
    Left = 11
    Top = 297
    Width = 21
    Height = 15
    Caption = 'CEP'
  end
  object LabelTelefone: TLabel
    Left = 314
    Top = 71
    Width = 45
    Height = 15
    Caption = 'Telefone'
  end
  object EditNome: TEdit
    Left = 11
    Top = 38
    Width = 404
    Height = 23
    TabOrder = 0
  end
  object MaskEdit_CPF_CNPJ: TMaskEdit
    Left = 162
    Top = 150
    Width = 155
    Height = 23
    ReadOnly = True
    TabOrder = 4
    Text = ''
  end
  object ComboBoxTipoPessoa: TComboBox
    Left = 11
    Top = 150
    Width = 145
    Height = 23
    Style = csDropDownList
    TabOrder = 3
    Items.Strings = (
      'Pessoa F'#237'sica'
      'Pessoa Jur'#237'dica'
      ''
      '')
  end
  object EditIE: TEdit
    Left = 323
    Top = 150
    Width = 92
    Height = 23
    ReadOnly = True
    TabOrder = 5
  end
  object EditEndereco: TEdit
    Left = 11
    Top = 262
    Width = 337
    Height = 23
    TabOrder = 8
  end
  object EditNumero: TEdit
    Left = 354
    Top = 262
    Width = 61
    Height = 23
    TabOrder = 9
  end
  object EditBairrao: TEdit
    Left = 84
    Top = 318
    Width = 331
    Height = 23
    TabOrder = 11
  end
  object EditCidade: TEdit
    Left = 11
    Top = 206
    Width = 337
    Height = 23
    TabOrder = 6
  end
  object EditEmail: TEdit
    Left = 11
    Top = 92
    Width = 297
    Height = 23
    TabOrder = 1
  end
  object ComboBoxUF: TComboBox
    Left = 354
    Top = 206
    Width = 61
    Height = 23
    Style = csDropDownList
    TabOrder = 7
  end
  object MaskEditCEP: TMaskEdit
    Left = 11
    Top = 318
    Width = 67
    Height = 23
    EditMask = '99999-999;1;_'
    MaxLength = 9
    TabOrder = 10
    Text = '     -   '
  end
  object EditTelefone: TEdit
    Left = 314
    Top = 92
    Width = 101
    Height = 23
    TabOrder = 2
  end
  object ButtonSalvar: TButton
    Left = 338
    Top = 366
    Width = 77
    Height = 25
    Caption = 'Salvar'
    TabOrder = 13
  end
  object ButtonCancelar: TButton
    Left = 255
    Top = 366
    Width = 77
    Height = 25
    Caption = 'Cancelar'
    TabOrder = 12
  end
end
