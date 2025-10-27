object FormNFes_EXCLUIR: TFormNFes_EXCLUIR
  Left = 0
  Top = 0
  Caption = 'Excluir NF-e'
  ClientHeight = 112
  ClientWidth = 426
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
    Width = 324
    Height = 30
    Caption = 'Deseja realmente exlcluir a NF-e?'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object LabelDadosNfe: TLabel
    Left = 8
    Top = 53
    Width = 78
    Height = 15
    Caption = 'Dados da NF-e'
  end
  object ButtonCancelar: TButton
    Left = 264
    Top = 78
    Width = 75
    Height = 25
    Caption = 'Cancelar'
    TabOrder = 0
    OnClick = ButtonCancelarClick
  end
  object ButtonConfirmar: TButton
    Left = 345
    Top = 78
    Width = 75
    Height = 25
    Caption = 'Confirmar'
    TabOrder = 1
    OnClick = ButtonConfirmarClick
  end
end
