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
  private
    procedure CarregaComboBoxProdutos;
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

  DBLookupComboBoxProduto.ListSource := DataSource;
  DBLookupComboBoxProduto.KeyField   := 'ID';
  DBLookupComboBoxProduto.ListField  := 'NOME';
end;

procedure TFormNFesProdutos_INSERIR.DBLookupComboBoxProdutoClick(
  Sender: TObject);
var
  idSelecionado:Integer;
begin
  inherited;
  if (DBLookupComboBoxProduto.KeyValue <> Null) then
  begin
    idSelecionado := DBLookupComboBoxProduto.KeyValue;

    with DBLookupComboBoxProduto.ListSource.DataSet do
    begin
      // fazer uma função para a multiplicação e reaproveita aqui e onde precisar
      // passar os dados para os imputs
      dasd
    end;



  end;
end;

procedure TFormNFesProdutos_INSERIR.ButtonAdicionarClick(Sender: TObject);
begin
  inherited;
  try
//    if (ComboBoxProduto.text='') or (EditQuantidade.text='') then
//    begin
//      ShowMessage('Produto e quantidade são obrigatórios!');
//      Exit;
//    end;

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
