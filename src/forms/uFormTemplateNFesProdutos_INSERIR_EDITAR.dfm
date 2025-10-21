object FormTemplateNFesProdutos_INSERIR_EDITAR: TFormTemplateNFesProdutos_INSERIR_EDITAR
  Left = 0
  Top = 0
  Caption = 'FormTemplateNFesProdutos_INSERIR_EDITAR'
  ClientHeight = 106
  ClientWidth = 672
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
    Left = 335
    Top = 11
    Width = 62
    Height = 15
    Caption = 'Quantidade'
  end
  object LabelPreco: TLabel
    Left = 415
    Top = 11
    Width = 30
    Height = 15
    Caption = 'Pre'#231'o'
  end
  object LabelTotal: TLabel
    Left = 542
    Top = 11
    Width = 26
    Height = 15
    Caption = 'Total'
  end
  object EditQuantidade: TEdit
    Left = 335
    Top = 32
    Width = 74
    Height = 23
    TabOrder = 0
    OnKeyPress = EditQuantidadeKeyPress
  end
  object EditPreco: TEdit
    Left = 415
    Top = 32
    Width = 121
    Height = 23
    TabStop = False
    ReadOnly = True
    TabOrder = 1
  end
  object EditTotal: TEdit
    Left = 542
    Top = 32
    Width = 121
    Height = 23
    TabStop = False
    ReadOnly = True
    TabOrder = 2
  end
  object ButtonCancelar: TButton
    Left = 507
    Top = 74
    Width = 75
    Height = 25
    Caption = 'Cancelar'
    TabOrder = 3
  end
  object ButtonAdicionar: TButton
    Left = 588
    Top = 74
    Width = 75
    Height = 25
    Caption = 'Adicionar'
    TabOrder = 4
  end
  object DBLookupComboBoxProduto: TDBLookupComboBox
    Left = 8
    Top = 32
    Width = 321
    Height = 23
    TabOrder = 5
  end
  object DataSource: TDataSource
    Left = 224
    Top = 32
  end
end
