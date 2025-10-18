object FormTemplateProdutos_INSERIR_EDITAR: TFormTemplateProdutos_INSERIR_EDITAR
  Left = 0
  Top = 0
  Caption = 'FormTemplateProdutos_INSERIR_EDITAR'
  ClientHeight = 167
  ClientWidth = 490
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
    Left = 280
    Top = 67
    Width = 45
    Height = 15
    Caption = 'Estoque '
  end
  object EditNomeProduto: TEdit
    Left = 8
    Top = 32
    Width = 473
    Height = 23
    TabOrder = 0
  end
  object EditPrecoProduto: TEdit
    Left = 8
    Top = 88
    Width = 201
    Height = 23
    TabOrder = 1
  end
  object EditEstoqueProduto: TEdit
    Left = 280
    Top = 88
    Width = 201
    Height = 23
    TabOrder = 2
  end
  object ButtonCancelar: TButton
    Left = 325
    Top = 130
    Width = 75
    Height = 25
    Caption = 'Cancelar'
    TabOrder = 3
  end
  object ButtonSalvar: TButton
    Left = 406
    Top = 130
    Width = 75
    Height = 25
    Caption = 'Salvar'
    TabOrder = 4
  end
end
