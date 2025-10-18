object DM: TDM
  Height = 480
  Width = 640
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
    Top = 152
  end
end
