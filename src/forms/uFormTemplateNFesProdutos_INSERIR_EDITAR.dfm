object FormTemplateNFesProdutos_INSERIR_EDITAR: TFormTemplateNFesProdutos_INSERIR_EDITAR
  Left = 0
  Top = 0
  Caption = 'FormTemplateNFesProdutos_INSERIR_EDITAR'
  ClientHeight = 166
  ClientWidth = 435
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object LabelProduto: TLabel
    Left = 8
    Top = 11
    Width = 43
    Height = 15
    Caption = 'Produto'
  end
  object LabelQuantidade: TLabel
    Left = 99
    Top = 67
    Width = 62
    Height = 15
    Caption = 'Quantidade'
  end
  object LabelPreco: TLabel
    Left = 179
    Top = 67
    Width = 30
    Height = 15
    Caption = 'Pre'#231'o'
  end
  object LabelTotal: TLabel
    Left = 306
    Top = 67
    Width = 26
    Height = 15
    Caption = 'Total'
  end
  object LabelNCM: TLabel
    Left = 7
    Top = 67
    Width = 28
    Height = 15
    Caption = 'NCM'
  end
  object EditQuantidade: TEdit
    Left = 99
    Top = 88
    Width = 74
    Height = 23
    TabOrder = 2
    OnKeyPress = EditQuantidadeKeyPress
  end
  object EditPreco: TEdit
    Left = 179
    Top = 88
    Width = 121
    Height = 23
    TabStop = False
    Enabled = False
    ReadOnly = True
    TabOrder = 3
  end
  object EditTotal: TEdit
    Left = 306
    Top = 88
    Width = 121
    Height = 23
    TabStop = False
    Enabled = False
    ReadOnly = True
    TabOrder = 4
  end
  object ButtonCancelar: TButton
    Left = 271
    Top = 129
    Width = 75
    Height = 25
    Caption = 'Cancelar'
    TabOrder = 5
  end
  object ButtonAdicionar: TButton
    Left = 352
    Top = 129
    Width = 75
    Height = 25
    Caption = 'Adicionar'
    TabOrder = 6
  end
  object DBLookupComboBoxProduto: TDBLookupComboBox
    Left = 8
    Top = 32
    Width = 419
    Height = 23
    TabOrder = 0
  end
  object EditNCM: TEdit
    Left = 7
    Top = 88
    Width = 86
    Height = 23
    Enabled = False
    MaxLength = 8
    TabOrder = 1
    OnKeyPress = EditNCMKeyPress
  end
  object DataSource: TDataSource
    Left = 8
    Top = 112
  end
end
