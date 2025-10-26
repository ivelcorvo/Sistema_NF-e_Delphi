unit uFormNFes_EDITAR;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UFormTemplateNFes_NOVA_EDITAR, Data.DB,
  Vcl.Imaging.pngimage, Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.Grids, Vcl.DBGrids,
  Vcl.DBCtrls, Vcl.StdCtrls, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TFormNFes_EDITAR = class(TFormTemplateNFes_NOVA_EDITAR)
    procedure ImageAdicinarClick(Sender: TObject);
  private
    procedure CarregarNota;
    procedure CarregaProdutos;
    procedure CarregaNFeProdutos_do_banco;
    procedure CarregaNFeProdutos;
  public
    IDNota: Integer;
    procedure onExibir;
  end;

var
  FormNFes_EDITAR: TFormNFes_EDITAR;

implementation

{$R *.dfm}

uses uDM, uFormNFesProdutos_INSERIR;

procedure TFormNFes_EDITAR.CarregaProdutos;
begin
  try
    with DM.FDQueryProdutosGET do
    begin                                                        
      Close;
      SQL.Text := 'SELECT * FROM PRODUTOS';
      Open;
    end;
    DM.FDMemTableProdutos.CopyDataSet(DM.FDQueryProdutosGET, [coStructure,coAppend]);
  except
    on E:Exception do
      ShowMessage('Houve um erro... Erro: '+E.Message);
  end;
end;

procedure TFormNFes_EDITAR.CarregarNota;
begin
  try
    with DM.FDQueryNotaFiscalGET do
    begin  
      Close;
      SQL.Text := 'SELECT * FROM NOTAS_FISCAIS WHERE ID = :ID';
      ParamByName('ID').AsInteger := IDNota;
      Open;
    end;
  except
    on E:Exception do
    begin
      ShowMessage('Nota não encontrada!');
      ModalResult := mrCancel;
    end;
  end;
end;

procedure TFormNFes_EDITAR.ImageAdicinarClick(Sender: TObject);
var
  form: TFormNFesProdutos_INSERIR;
begin
  inherited;
  
  form := nil;
  
  try
    form          := TFormNFesProdutos_INSERIR.Create(Self);
    form.Position := poScreenCenter;

    form.onExibir;

    if form.ShowModal=mrOk then
      CarregaNFeProdutos;
  finally
    form.Free;
  end;  
end;

procedure TFormNFes_EDITAR.CarregaNFeProdutos_do_banco;
begin
  try
    with DM.FDQueryNotasItensGET do
    begin
      Close;
      SQL.Text := 'SELECT I.ID, I.ID_NOTA, I.ID_PRODUTO, P.NOME AS PRODUTO, P.NCM AS NCM, I.QUANTIDADE, I.VALOR_UNITARIO, I.VALOR_TOTAL '+
                  'FROM NOTAS_ITENS I '+      
                  'JOIN PRODUTOS P ON P.ID = I.ID_PRODUTO '+
                  'WHERE I.ID_NOTA = :ID_NOTA '+
                  'ORDER BY I.ID';
      ParamByName('ID_NOTA').AsInteger := IDNota;
      Open;      
    end;
    DM.FDMemTableNFeProdutos.CopyDataSet(DM.FDQueryNotasItensGET,[coStructure,coAppend]);
  except
    on E:Exception do
      ShowMessage('Houve um erro... Erro: '+E.Message);
  end;
end;

procedure TFormNFes_EDITAR.CarregaNFeProdutos;
begin
  DataSourceNFeProdutos.DataSet := DM.FDMemTableNFeProdutos;
  DBGridProdutosNFe.DataSource  := DataSourceNFeProdutos;
end;

procedure TFormNFes_EDITAR.onExibir;
begin
  CarregarNota;
  CarregaProdutos;
  CarregaNFeProdutos_do_banco; // copia do banco e depois copia para um fdmemtable
  CarregaNFeProdutos;
end;

end.
