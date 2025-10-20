object FormTemplateProdutos_INSERIR_EDITAR: TFormTemplateProdutos_INSERIR_EDITAR
  Left = 0
  Top = 0
  Caption = 'FormTemplateProdutos_INSERIR_EDITAR'
  ClientHeight = 161
  ClientWidth = 451
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object LabelNomeProduto: TLabel
    Left = 8
    Top = 11
    Width = 79
    Height = 15
    Caption = 'Nome produto'
  end
  object LabelPrecoProduto: TLabel
    Left = 8
    Top = 67
    Width = 30
    Height = 15
    Caption = 'Pre'#231'o'
  end
  object LabelEstoqueProduto: TLabel
    Left = 135
    Top = 67
    Width = 45
    Height = 15
    Caption = 'Estoque '
  end
  object LabelNCM: TLabel
    Left = 215
    Top = 67
    Width = 28
    Height = 15
    Caption = 'NCM'
  end
  object LabelCFOP: TLabel
    Left = 290
    Top = 67
    Width = 30
    Height = 15
    Caption = 'CFOP'
  end
  object LabelUnidade: TLabel
    Left = 339
    Top = 67
    Width = 44
    Height = 15
    Caption = 'Unidade'
  end
  object EditNomeProduto: TEdit
    Left = 8
    Top = 32
    Width = 433
    Height = 23
    TabOrder = 0
  end
  object EditEstoqueProduto: TEdit
    Left = 135
    Top = 88
    Width = 74
    Height = 23
    TabOrder = 2
    OnKeyPress = EditEstoqueProdutoKeyPress
  end
  object ButtonCancelar: TButton
    Left = 285
    Top = 126
    Width = 75
    Height = 25
    Caption = 'Cancelar'
    TabOrder = 6
  end
  object ButtonSalvar: TButton
    Left = 366
    Top = 126
    Width = 75
    Height = 25
    Caption = 'Salvar'
    TabOrder = 7
  end
  object ComboBoxUnidade: TComboBox
    Left = 339
    Top = 88
    Width = 102
    Height = 23
    Style = csDropDownList
    TabOrder = 5
    Items.Strings = (
      'UN'
      'KG'
      'LT'
      'CX')
  end
  object EditPrecoProduto: TEdit
    Left = 8
    Top = 88
    Width = 121
    Height = 23
    TabOrder = 1
    OnKeyPress = EditPrecoProdutoKeyPress
  end
  object EditNCM: TEdit
    Left = 215
    Top = 88
    Width = 67
    Height = 23
    MaxLength = 8
    TabOrder = 3
    OnKeyPress = EditNCMKeyPress
  end
  object EditCFOP: TEdit
    Left = 288
    Top = 88
    Width = 45
    Height = 23
    MaxLength = 4
    TabOrder = 4
    OnKeyPress = EditCFOPKeyPress
  end
end
