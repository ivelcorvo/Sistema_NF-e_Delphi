unit uFormNFesProdutos_EDITAR;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  uFormTemplateNFesProdutos_INSERIR_EDITAR, Data.DB, Vcl.DBCtrls, Vcl.StdCtrls;

type
  TFormNFesProdutos_EDITAR = class(TFormTemplateNFesProdutos_INSERIR_EDITAR)
    procedure ButtonCancelarClick(Sender: TObject);
    procedure EditQuantidadeChange(Sender: TObject);
    procedure ButtonAdicionarClick(Sender: TObject);
  private
    procedure CarregarProduto;
    procedure CarregaComboBoxProdutos;
    procedure MultiplicaQuantidadePreco;
  public
    IDProduto:Integer;
    procedure onExibir;
  end;

var
  FormNFesProdutos_EDITAR: TFormNFesProdutos_EDITAR;

implementation

{$R *.dfm}

uses uDM;

procedure TFormNFesProdutos_EDITAR.CarregaComboBoxProdutos;
begin
  DataSource.DataSet := DM.FDMemTableProdutos;

  // NÃOSEI PQ ASSIM NÃO FUNCIONA
  //  with DBLookupComboBoxProduto do
  //  begin
  //    ListSource := DataSource;
  //    KeyField   := 'ID';
  //    ListField  := 'NOME';
  //  end;

  DBLookupComboBoxProduto.ListSource := DataSource;
  DBLookupComboBoxProduto.KeyField   := 'ID';
  DBLookupComboBoxProduto.ListField  := 'NOME';
end;

procedure TFormNFesProdutos_EDITAR.MultiplicaQuantidadePreco;
var
  total:Double;
  quantidade:Integer;
begin
  if (DBLookupComboBoxProduto.KeyValue <> Null) then
  begin
    if (EditQuantidade.Text = '') then
      quantidade := 0
    else
      quantidade := StrToInt(EditQuantidade.Text);

    total := StrToFloat(EditPreco.text)*quantidade;
    EditTotal.Text := FloatToStr(total);
  end;
end;

procedure TFormNFesProdutos_EDITAR.ButtonAdicionarClick(Sender: TObject);
begin
  inherited;
  try
    with DM.FDMemTableNFeProdutos DO
    begin
      if (Locate('ID_PRODUTO',IDProduto)) then
      begin
        Edit;
        FieldByName('QUANTIDADE').AsInteger := StrToInt(EditQuantidade.Text);
        FieldByName('VALOR_TOTAL').AsFloat  := StrToInt(EditQuantidade.Text) * FieldByName('VALOR_UNITARIO').AsFloat;
        Post;
      end;
    end;
    ShowMessage('Item atualizado com sucesso!');
    ModalResult := mrOk;
  except
    on E:Exception do
      ShowMessage('Houve um erro... Erro: '+E.Message);
  end;
end;

procedure TFormNFesProdutos_EDITAR.ButtonCancelarClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TFormNFesProdutos_EDITAR.CarregarProduto;
begin
  try
    if DM.FDMemTableNFeProdutos.Locate('ID_PRODUTO',IDProduto,[]) then
    begin
      DBLookupComboBoxProduto.KeyValue := IDProduto;
      DBLookupComboBoxProduto.Enabled  := False;
      EditPreco.Text                   := FloatToStr(DBLookupComboBoxProduto.ListSource.DataSet.FieldByName('PRECO').AsFloat);
      EditQuantidade.Text              := IntToStr(DM.FDMemTableNFeProdutos.FieldByName('quantidade').AsInteger);
      EditNCM.Text                     := IntToStr(DBLookupComboBoxProduto.ListSource.DataSet.FieldByName('NCM').AsInteger);
      MultiplicaQuantidadePreco;
    end
    else
    begin
      ShowMessage('Produto não encontrado!');
      ModalResult := mrCancel;
    end;

  except
    on E:Exception do
  end;
end;

procedure TFormNFesProdutos_EDITAR.EditQuantidadeChange(Sender: TObject);
begin
  inherited;
  MultiplicaQuantidadePreco;
end;

procedure TFormNFesProdutos_EDITAR.onExibir;
begin
  CarregaComboBoxProdutos;
  CarregarProduto;
end;

end.
