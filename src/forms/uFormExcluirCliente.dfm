object FormExcluirCliente: TFormExcluirCliente
  Left = 0
  Top = 0
  Caption = 'Excluir cliente'
  ClientHeight = 141
  ClientWidth = 484
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object LabelTituloExcluir: TLabel
    Left = 8
    Top = 16
    Width = 338
    Height = 30
    Caption = 'Deseja realmente excluir o cliente?'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object LabelDadosCliente: TLabel
    Left = 8
    Top = 64
    Width = 98
    Height = 15
    Caption = 'LabelDadosCliente'
  end
  object ButtonCancelar: TButton
    Left = 320
    Top = 108
    Width = 75
    Height = 25
    Caption = 'Cancelar'
    TabOrder = 0
    OnClick = ButtonCancelarClick
  end
  object ButtonConfirmar: TButton
    Left = 401
    Top = 108
    Width = 75
    Height = 25
    Caption = 'Confirmar'
    TabOrder = 1
    OnClick = ButtonConfirmarClick
  end
end
