object FormNFesProdutos_EXCLUIR: TFormNFesProdutos_EXCLUIR
  Left = 0
  Top = 0
  Caption = 'NF-e produtos exlcuir'
  ClientHeight = 107
  ClientWidth = 451
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object LabelTituloExcluir: TLabel
    Left = 8
    Top = 14
    Width = 354
    Height = 30
    Caption = 'Deseja realmente excluir o produto?'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object LabelDadosProduto: TLabel
    Left = 8
    Top = 56
    Width = 34
    Height = 15
    Caption = 'Label1'
  end
  object ButtonCancelar: TButton
    Left = 290
    Top = 75
    Width = 75
    Height = 25
    Caption = 'Cancelar'
    TabOrder = 0
    OnClick = ButtonCancelarClick
  end
  object Button2: TButton
    Left = 371
    Top = 75
    Width = 75
    Height = 25
    Caption = 'Confirmar'
    TabOrder = 1
    OnClick = Button2Click
  end
end
