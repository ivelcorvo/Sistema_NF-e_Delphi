object FormExcluirProduto: TFormExcluirProduto
  Left = 0
  Top = 0
  Caption = 'Excluir produto'
  ClientHeight = 112
  ClientWidth = 502
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object LabelTituloExcluir: TLabel
    Left = 8
    Top = 8
    Width = 359
    Height = 30
    Caption = 'Deseja Realmente excluir o produto?'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblNMProduto: TLabel
    Left = 8
    Top = 49
    Width = 76
    Height = 15
    Caption = 'lblNMProduto'
  end
  object ButtonCancelar: TButton
    Left = 328
    Top = 83
    Width = 75
    Height = 25
    Caption = 'Cancelar'
    TabOrder = 0
    OnClick = ButtonCancelarClick
  end
  object ButtonConfirmar: TButton
    Left = 419
    Top = 83
    Width = 75
    Height = 25
    Caption = 'Confirmar'
    TabOrder = 1
    OnClick = ButtonConfirmarClick
  end
end
