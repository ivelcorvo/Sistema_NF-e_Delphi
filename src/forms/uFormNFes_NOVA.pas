unit uFormNFes_NOVA;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UFormTemplateNFes_NOVA_EDITAR, Data.DB,
  Vcl.Imaging.pngimage, Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.DBCtrls;

type
  TFormNFes_NOVA = class(TFormTemplateNFes_NOVA_EDITAR)
    procedure ImageAdicinarClick(Sender: TObject);
    procedure ImageEditarClick(Sender: TObject);
    procedure ImageExcluirClick(Sender: TObject);
    procedure ButtonCancelarClick(Sender: TObject);
    procedure ButtonSalvarClick(Sender: TObject);
  private
    procedure CarregaProdutos;
    procedure CarregaNFeProdutos;
    procedure CarregaEstruturaNFeProdutos;
    procedure CarregarClientes;
  public
    procedure onExibir;
  end;

var
  FormNFes_NOVA: TFormNFes_NOVA;

implementation

{$R *.dfm}

uses uFormNFesProdutos_INSERIR, uDM, uFormNFesProdutos_EDITAR,
  uFormNFesProdutos_EXCLUIR, uUtils;

procedure TFormNFes_NOVA.CarregaProdutos;
begin
  try
    with DM.FDQueryProdutosGET do
    begin
      Close;
      SQL.Text := 'SELECT * FROM PRODUTOS';
      Open;
    end;
    // CRIANDO TABELA NA MEMORIA
    DM.FDMemTableProdutos.CopyDataSet(DM.FDQueryProdutosGET, [coStructure,coAppend]);
  except
    on E:Exception do
      ShowMessage('Houve um erro... Erro: '+E.Message);
  end;
end;

procedure TFormNFes_NOVA.ButtonCancelarClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TFormNFes_NOVA.ButtonSalvarClick(Sender: TObject);
var
  campos_em_branco:string;
  IDNota, NumNota :Integer;
begin
  inherited;

  campos_em_branco := '';
  if (DBLookupComboBoxCliente.KeyValue=Null) or (EditCFOP.Text='') or (EditNatureza.Text='') then
  begin
    campos_em_branco := 'Por favor, preencha os campos: ';
    if (DBLookupComboBoxCliente.KeyValue=Null) then
      campos_em_branco := campos_em_branco + 'Cliente, ';
    if (EditCFOP.text='') then
      campos_em_branco := campos_em_branco + 'CFOP, ';
    if (EditNatureza.text='') then
      campos_em_branco := campos_em_branco + 'Natureza, ';

    RemoveUltimoElemento(campos_em_branco,', ');
    ShowMessage(campos_em_branco);
    Exit;
  end;

  DM.FDConnection.StartTransaction;

  try

    // ADICIONA NOTA
    with DM.FDQueryNotasFiscaisRequest do
    begin
      Close;
      SQL.Text := 'INSERT INTO NOTAS_FISCAIS '+
                  '(ID_CLIENTE, SERIE, DATA_EMISSAO, NATUREZA_OPERACAO, CFOP_PADRAO, VALOR_TOTAL, STATUS) '+
                  'VALUES (:ID_CLIENTE, :SERIE, :DATA_EMISSAO, :NATUREZA_OPERACAO, :CFOP_PADRAO, :VALOR_TOTAL, :STATUS) '+
                  'RETURNING ID, NUMERO';

      ParamByName('ID_CLIENTE').AsInteger       := DBLookupComboBoxCliente.KeyValue;
      ParamByName('SERIE').AsInteger            := 1;
      ParamByName('DATA_EMISSAO').AsDateTime    := DateTimeDataEmisao.Date;
      ParamByName('NATUREZA_OPERACAO').AsString := EditNatureza.Text;
      ParamByName('CFOP_PADRAO').AsString       := EditCFOP.Text;
      ParamByName('VALOR_TOTAL').AsFloat        := 0;
      ParamByName('STATUS').AsString            := 'RASCUNHO';

      Open; // NESSE CASO NÃO TEM EXECSQL PQ TEM UM RETORNO

      try
        IDNota  := FieldByName('ID').AsInteger;
        NumNota := FieldByName('NUMERO').AsInteger;
      finally
        Close;
      end;
    end;

    // ADICIONA OS ITENS DA NOTA

    ADICIONA OS ITENS DA NOTA

    DM.FDConnection.Commit;
    ShowMessage(Format('Nota adicinada com sucesso! Nº: %d',[NumNota]));
    ModalResult := mrOk;
  except
    on E:Exception do
    begin
      ShowMessage('Não foi possível salvar os itens da nota. Houve um erro... Erro: '+E.Message);
      DM.FDConnection.Rollback;
    end;
  end;


end;

procedure TFormNFes_NOVA.CarregaEstruturaNFeProdutos;
begin
  try
    //    DM.FDQueryNotasItensGET.Close;
    //    DM.FDQueryNotasItensGET.Open;
    //    // COPIA APENAS A ESTRUTURA DE FDQueryNotasItensGET
    //    DM.FDMemTableNFeProdutos.CopyDataSet(DM.FDQueryNotasItensGET,[coStructure]);

    with DM.FDMemTableNFeProdutos do
    begin
      Close;
      FieldDefs.Clear;

      FieldDefs.Add('ID_PRODUTO',ftInteger);
      FieldDefs.Add('PRODUTO',ftString,100);
      FieldDefs.Add('NCM',ftInteger);
      FieldDefs.Add('QUANTIDADE',ftInteger);
      FieldDefs.Add('VALOR_UNITARIO',ftFloat);
      FieldDefs.Add('VALOR_TOTAL',ftFloat);

      CreateDataSet;
    end;

  except
    on E:Exception do
      ShowMessage('Houve um erro... Erro: '+E.Message);
  end;
end;

procedure TFormNFes_NOVA.CarregaNFeProdutos;
begin
  DataSourceNFeProdutos.DataSet := DM.FDMemTableNFeProdutos;
  DBGridProdutosNFe.DataSource  := DataSourceNFeProdutos;
end;

procedure TFormNFes_NOVA.CarregarClientes;
begin
  try
    // RETORNA TODOS OS CLIENTES
    with DM.FDQueryClientesGET do
    begin
      Close;
      SQL.Text := 'SELECT * FROM CLIENTES';
      Open;
    end;
    // ALIEMENTA COMBOBOX
    DataSourceClientes.DataSet         := DM.FDQueryClientesGET;
    DBLookupComboBoxCliente.ListSource := DataSourceClientes;
    DBLookupComboBoxCliente.KeyField   := 'ID';
    DBLookupComboBoxCliente.ListField  := 'NOME';
  except
    on E:Exception do
      ShowMessage('Houve um erro... Erro: '+E.Message);
  end;
end;

procedure TFormNFes_NOVA.ImageAdicinarClick(Sender: TObject);
var
  form: TFormNFesProdutos_INSERIR;
begin
  inherited;
  form := nil;
  try
    form          := TFormNFesProdutos_INSERIR.Create(Self);
    form.Position := poScreenCenter;

    form.onExibir;

    if form.ShowModal=mrok then
      CarregaNFeProdutos;

  finally
    form.Free;
  end;
end;

procedure TFormNFes_NOVA.ImageEditarClick(Sender: TObject);
var
  form:TFormNFesProdutos_EDITAR;
  IDProduto: Integer;
begin
  inherited;
  form := nil;
  try

    with DM.FDMemTableNFeProdutos do
    begin
      if (not Active) or (RecordCount=0) or (IsEmpty) then
      begin
        ShowMessage('Nenhum produto selecionado!');
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
      exit;

    if form.ShowModal = mrok then
      CarregaNFeProdutos;

  finally
    form.Free;
  end;
end;

procedure TFormNFes_NOVA.ImageExcluirClick(Sender: TObject);
var
  form:TFormNFesProdutos_EXCLUIR;
  IDProduto:Integer;
  NMProduto:string;
begin
  inherited;
  form := nil;
  try
    with DM.FDMemTableNFeProdutos do
    begin
      if (not Active) or (RecordCount=0) or (IsEmpty) then
      begin
        ShowMessage('Nenhum produto selecionado!');
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
    form.LabelDadosProduto.Caption := 'Nome: '+NMProduto;

    if form.ShowModal=mrOk then
      CarregaNFeProdutos;

  finally
    form.Free;
  end;

end;

procedure TFormNFes_NOVA.onExibir;
begin
  CarregarClientes;
  CarregaProdutos;
  CarregaEstruturaNFeProdutos;
end;

end.
