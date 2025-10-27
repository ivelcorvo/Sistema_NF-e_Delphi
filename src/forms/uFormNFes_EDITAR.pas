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
    procedure ButtonCancelarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ButtonSalvarClick(Sender: TObject);
    procedure ImageEditarClick(Sender: TObject);
    procedure ImageExcluirClick(Sender: TObject);
  private
    procedure CarregarNota;
    procedure CarregaProdutos;
    procedure CarregaNFeProdutos_do_banco;
    procedure CarregaNFeProdutos;
    procedure CarregaCliente;
    procedure PreencheCamposeParaEditar;
  public
    IDNota: Integer;
    procedure onExibir;
  end;

var
  FormNFes_EDITAR: TFormNFes_EDITAR;

implementation

{$R *.dfm}

uses uDM, uFormNFesProdutos_INSERIR, uUtils, uFormNFesProdutos_EDITAR,
  uFormNFesProdutos_EXCLUIR;

procedure TFormNFes_EDITAR.ButtonCancelarClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TFormNFes_EDITAR.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  if DM.FDMemTableProdutos.Active then
    DM.FDMemTableProdutos.Close;
  if DM.FDQueryProdutosGET.Active then
    DM.FDQueryProdutosGET.Close;
  if DM.FDQueryNotasItensGET.Active then
    DM.FDQueryNotasItensGET.Close;
  if DM.FDMemTableNFeProdutos.Active then
    DM.FDMemTableNFeProdutos.Close;
  if DM.FDQueryClientesGET.Active then
    DM.FDQueryClientesGET.Close;
end;

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

procedure TFormNFes_EDITAR.ImageEditarClick(Sender: TObject);
var
  form: TFormNFesProdutos_EDITAR;
  IDProduto: Integer;
begin
  inherited;
  form := nil;
  try
    with DM.FDMemTableNFeProdutos do
    begin
      if (not Active) or (RecordCount=0) or (IsEmpty) then
      begin
        ShowMessage('Nenhum item selecionado!');
        Exit;
      end
      else
        IDProduto := FieldByName('ID_PRODUTO').AsInteger;
    end;

    form           := TFormNFesProdutos_EDITAR.Create(Self);
    form.Position  := poScreenCenter;
    form.IDProduto := IDProduto;

    form.onExibir;

    if form.ModalResult=mrCancel then
      Exit;

    if form.ShowModal=mrOk then
      CarregaNFeProdutos;

  finally
    form.Free;
  end;
end;

procedure TFormNFes_EDITAR.ImageExcluirClick(Sender: TObject);
var
  form: TFormNFesProdutos_EXCLUIR;
  IDProduto: Integer;
  NMProduto: string;
begin
  inherited;
  form := nil;
  try
    with DM.FDMemTableNFeProdutos do
    begin
      if (not Active) or (RecordCount=0) or (IsEmpty) then
      begin
        ShowMessage('Nenhum item selecionado!');
        Exit;
      end
      else
      begin
        IDProduto := FieldByName('ID_PRODUTO').AsInteger;
        NMProduto := FieldByName('PRODUTO').AsString;
      end;
    end;

    form                           := TFormNFesProdutos_EXCLUIR.Create(Self);
    form.Position                  := poScreenCenter;
    form.IDProduto                 := IDProduto;
    form.LabelDadosProduto.Caption := 'Nome: '+NMProduto+'.';

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

procedure TFormNFes_EDITAR.ButtonSalvarClick(Sender: TObject);
var
  campos_em_branco: string;
  vl_total_nota: Double;
begin
  inherited;

  vl_total_nota := 0;

  campos_em_branco := '';
  if (VarIsNull(DBLookupComboBoxCliente.KeyValue)) or (EditCFOP.Text='') or (EditNatureza.Text='') then
  begin
    campos_em_branco := 'Por favor, preencha os campos: ';
    if (VarIsNull(DBLookupComboBoxCliente.KeyValue)) then
      campos_em_branco := campos_em_branco + 'Cliente, ';
    if (EditCFOP.text='') then
      campos_em_branco := campos_em_branco + 'CFOP, ';
    if (EditNatureza.text='') then
      campos_em_branco := campos_em_branco + 'Natureza, ';

    RemoveUltimoElemento(campos_em_branco,', ');
    ShowMessage(campos_em_branco);
    Exit;
  end;

  with DM.FDMemTableNFeProdutos do
  begin
    if (not Active) or (RecordCount=0) or (IsEmpty) then
    begin
      ShowMessage('Nota sem itens! Por favor adicione.');
      Exit;
    end;
  end;

  DM.FDConnection.StartTransaction;

  try
    // ATUALIZA NOTA
    with DM.FDQueryNotasFiscaisRequest do
    begin
      Close;
      SQL.Clear;
      SQL.Add('UPDATE NOTAS_FISCAIS SET ');
      SQL.Add('ID_CLIENTE = :ID_CLIENTE, ');
      SQL.Add('DATA_EMISSAO = :DATA_EMISSAO, ');
      SQL.Add('CFOP_PADRAO = :CFOP_PADRAO, ');
      SQL.Add('NATUREZA_OPERACAO = :NATUREZA_OPERACAO ');
      SQL.Add('WHERE ID = :ID');
      ParamByName('ID_CLIENTE').AsInteger       := DBLookupComboBoxCliente.KeyValue;
      ParamByName('DATA_EMISSAO').AsDate        := DateTimeDataEmisao.Date;
      ParamByName('CFOP_PADRAO').AsString       := EditCFOP.Text;
      parambyname('NATUREZA_OPERACAO').AsString := EditNatureza.Text;
      ParamByName('ID').AsInteger               := IDNota;
      ExecSQL;
    end;

    // DELETA TODOS OS ITENS DA NOTA (ESTÃO SALVOS EM MEMORIA);
    with DM.FDQueryNotasItensRequest do
    begin
      Close;
      SQL.Text := 'DELETE FROM NOTAS_ITENS WHERE ID_NOTA = :ID_NOTA';
      ParamByName('ID_NOTA').AsInteger := IDNota;
      ExecSQL
    end;

    // ADICIONA TODOS OS ITENS DAD NOTA (OS ANTIGOS E NOVOS)
    with DM.FDQueryNotasItensRequest do
    begin
      DM.FDMemTableNFeProdutos.First;
      while not DM.FDMemTableNFeProdutos.Eof do
      begin
        Close;
        SQL.Text := 'INSERT INTO NOTAS_ITENS (ID_NOTA,ID_PRODUTO,QUANTIDADE,VALOR_UNITARIO) '+
                    'VALUES (:ID_NOTA,:ID_PRODUTO,:QUANTIDADE,:VALOR_UNITARIO)';
        ParamByName('ID_NOTA').AsInteger      := IDNota;
        ParamByName('ID_PRODUTO').AsInteger   := DM.FDMemTableNFeProdutos.FieldByName('ID_PRODUTO').AsInteger;
        ParamByName('QUANTIDADE').AsInteger   := DM.FDMemTableNFeProdutos.FieldByName('QUANTIDADE').AsInteger;
        ParamByName('VALOR_UNITARIO').AsFloat := DM.FDMemTableNFeProdutos.FieldByName('VALOR_UNITARIO').AsFloat;

        vl_total_nota := vl_total_nota + DM.FDMemTableNFeProdutos.FieldByName('VALOR_TOTAL').AsFloat;

        ExecSQL;

        DM.FDMemTableNFeProdutos.Next;
      end;
    end;

    // ATUALIZA VALOR_TOTAL  NOTA
    with DM.FDQueryNotasFiscaisRequest do
    begin
      Close;
      SQL.Text := 'UPDATE NOTAS_FISCAIS SET VALOR_TOTAL = :VALOR_TOTAL WHERE ID = :ID';
      ParamByName('VALOR_TOTAL').AsFloat := vl_total_nota;
      ParamByName('ID').AsInteger        := IDNota;
      ExecSQL;
    end;

    DM.FDConnection.Commit;
    ShowMessage('Nota atualizada com sucesso!');
    ModalResult := mrOk;
  except
    on E:Exception do
    begin
      DM.FDConnection.Rollback;
      ShowMessage('Não foi possível salvar a nota. Houve um erro... Erro: '+E.Message);
    end;
  end;
end;

procedure TFormNFes_EDITAR.CarregaCliente;
begin
  try
    with DM.FDQueryClientesGET do
    begin
      Close;
      SQL.Text := 'SELECT * FROM CLIENTES';
      Open;
    end;
    DataSourceClientes.DataSet         := DM.FDQueryClientesGET;
    DBLookupComboBoxCliente.ListSource := DataSourceClientes;
    DBLookupComboBoxCliente.KeyField   := 'ID';
    DBLookupComboBoxCliente.ListField  := 'NOME';
  except
    on E:Exception do
      ShowMessage('Houve um erro... Erro: '+E.Message);
  end;
end;

procedure TFormNFes_EDITAR.PreencheCamposeParaEditar;
begin
  with DM.FDQueryNotaFiscalGET do
  begin
    DBLookupComboBoxCliente.KeyValue := FieldByName('ID_CLIENTE').AsInteger;
    DateTimeDataEmisao.Date          := FieldByName('DATA_EMISSAO').AsDateTime;
    EditCFOP.Text                    := IntToStr(FieldByName('CFOP_PADRAO').AsInteger);
    EditNatureza.Text                := FieldByName('NATUREZA_OPERACAO').AsString;
  end;
end;

procedure TFormNFes_EDITAR.onExibir;
begin
  CarregarNota;
  CarregaProdutos;
  CarregaNFeProdutos_do_banco; // copia do banco(estrutura e dados) e depois passa para um fdmemtable
  CarregaNFeProdutos;
  CarregaCliente;
  PreencheCamposeParaEditar;
end;

end.
