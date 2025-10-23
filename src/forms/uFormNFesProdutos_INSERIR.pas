unit uFormNFesProdutos_INSERIR;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  uFormTemplateNFesProdutos_INSERIR_EDITAR, Vcl.StdCtrls, Vcl.DBCtrls, Data.DB;

type
  TFormNFesProdutos_INSERIR = class(TFormTemplateNFesProdutos_INSERIR_EDITAR)
    procedure ButtonCancelarClick(Sender: TObject);
    procedure ButtonAdicionarClick(Sender: TObject);
    procedure DBLookupComboBoxProdutoClick(Sender: TObject);
    procedure EditQuantidadeChange(Sender: TObject);
  private
    procedure CarregaComboBoxProdutos;
    procedure MultiplicaQuantidadePreco;
  public
    procedure onExibir;
  end;

var
  FormNFesProdutos_INSERIR: TFormNFesProdutos_INSERIR;

implementation

{$R *.dfm}

uses uFormNFes_NOVA, uDM;

procedure TFormNFesProdutos_INSERIR.CarregaComboBoxProdutos;
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

procedure TFormNFesProdutos_INSERIR.MultiplicaQuantidadePreco;
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

procedure TFormNFesProdutos_INSERIR.DBLookupComboBoxProdutoClick(Sender: TObject);
begin
  inherited;
  if (DBLookupComboBoxProduto.KeyValue <> Null) then
  begin
    with DBLookupComboBoxProduto.ListSource.DataSet do
    begin
      EditPreco.text := FloatToStr(FieldByName('PRECO').AsFloat);
      MultiplicaQuantidadePreco;
    end;
  end;
end;

procedure TFormNFesProdutos_INSERIR.EditQuantidadeChange(Sender: TObject);
begin
  inherited;
  MultiplicaQuantidadePreco;
end;

procedure TFormNFesProdutos_INSERIR.ButtonAdicionarClick(Sender: TObject);
var
  id:Integer;
  valor_unitario:Double;
begin
  inherited;
  try
    if (DBLookupComboBoxProduto.KeyValue=Null) or (EditQuantidade.text='') then
    begin
      ShowMessage('Produto e quantidade são obrigatórios!');
      Exit;
    end;

    with DBLookupComboBoxProduto.ListSource.DataSet do
    begin
      id             := FieldByName('ID').AsInteger;
      valor_unitario := FieldByName('PRECO').asFloat;
    end;

    with DM.FDMemTableNFeProdutos do
    begin
      Open;
      Append;
      FieldByName('ID_PRODUTO').AsInteger   := id;
      FieldByName('PRODUTO').AsString       := DBLookupComboBoxProduto.Text;
      FieldByName('VALOR_UNITARIO').AsFloat := valor_unitario;
      FieldByName('QUANTIDADE').AsInteger   := StrToInt(EditQuantidade.text);
      FieldByName('VALOR_TOTAL').AsFloat    := valor_unitario * StrToInt(EditQuantidade.text);
      Post;
    end;

    ModalResult := mrOk

  except
    on E:Exception do
      ShowMessage('Houve um erro... Erro: '+E.Message);
  end;
end;

procedure TFormNFesProdutos_INSERIR.ButtonCancelarClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TFormNFesProdutos_INSERIR.onExibir;
begin
  CarregaComboBoxProdutos;
end;


end.
