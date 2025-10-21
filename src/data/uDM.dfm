object DM: TDM
  Height = 797
  Width = 1197
  object FDConnection: TFDConnection
    Params.Strings = (
      
        'Database=C:\Users\Levi\OneDrive\'#193'rea de Trabalho\DEV\Delphi\MY_P' +
        'ROJECTS\Sistema_NF-e_Delphi\db\DB_PROJETO_NF-E.FDB'
      'User_Name=SYSDBA'
      'Password=Ayla0311'
      'DriverID=FB')
    Connected = True
    Left = 24
  end
  object FDQuery: TFDQuery
    Connection = FDConnection
    Left = 96
  end
  object DataSource: TDataSource
    Left = 160
  end
  object FDQueryProdutosGET: TFDQuery
    Connection = FDConnection
    Left = 16
    Top = 104
  end
  object FDQueryProdutosRequest: TFDQuery
    Connection = FDConnection
    Left = 16
    Top = 160
  end
  object FDQueryProdutoGET: TFDQuery
    Connection = FDConnection
    Left = 48
    Top = 104
  end
  object FDQueryClientesGET: TFDQuery
    Connection = FDConnection
    Left = 352
    Top = 104
  end
  object FDQueryClienteGET: TFDQuery
    Connection = FDConnection
    Left = 384
    Top = 104
  end
  object FDQueryClientesRequest: TFDQuery
    Connection = FDConnection
    Left = 352
    Top = 160
  end
  object FDQueryNotasFiscaisGET: TFDQuery
    Connection = FDConnection
    SQL.Strings = (
      'SELECT '
      '  NF.ID,'
      '  NF.NUMERO,'
      '  NF.SERIE,'
      '  NF.DATA_EMISSAO,'
      '  NF.VALOR_TOTAL,'
      '  NF.STATUS,'
      '  C.NOME AS CLIENTE'
      'FROM NOTAS_FISCAIS NF'
      'JOIN CLIENTES C ON C.ID = NF.ID_CLIENTE'
      'ORDER BY NF.DATA_EMISSAO DESC'
      '')
    Left = 520
    Top = 104
  end
  object FDQueryNotaFiscalGET: TFDQuery
    Connection = FDConnection
    Left = 552
    Top = 104
  end
  object FDQueryNotasFiscaisRequest: TFDQuery
    Connection = FDConnection
    Left = 520
    Top = 160
  end
  object FDQueryNotasItensGET: TFDQuery
    Connection = FDConnection
    SQL.Strings = (
      'SELECT '
      '  I.ID,'
      '  I.ID_NOTA,'
      '  I.ID_PRODUTO,'
      '  P.NOME AS PRODUTO,'
      '  I.QUANTIDADE,'
      '  I.VALOR_UNITARIO,'
      '  I.VALOR_TOTAL'
      'FROM NOTAS_ITENS I'
      'JOIN PRODUTOS P ON P.ID = I.ID_PRODUTO'
      'WHERE I.ID_NOTA = :ID_NOTA'
      'ORDER BY I.ID'
      '')
    Left = 808
    Top = 104
    ParamData = <
      item
        Name = 'ID_NOTA'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
  end
  object FDQueryNotaItemGET: TFDQuery
    Connection = FDConnection
    Left = 840
    Top = 104
  end
  object FDQueryNotasItensRequest: TFDQuery
    Connection = FDConnection
    Left = 808
    Top = 160
  end
  object FDMemTableProdutos: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 120
    Top = 104
  end
  object FDMemTableNFeProdutos: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 920
    Top = 104
  end
end
