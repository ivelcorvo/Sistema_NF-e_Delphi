unit uFormClientesGestao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFormTemplateGestao, Data.DB, Vcl.Grids,
  Vcl.DBGrids, Vcl.StdCtrls, Vcl.Imaging.pngimage, Vcl.ExtCtrls, Vcl.ComCtrls;

type
  TFormClientesGestao = class(TFormTemplateGestao)
    procedure FormShow(Sender: TObject);
    procedure ImageAdicinarClick(Sender: TObject);
    procedure ImageEditarClick(Sender: TObject);
    procedure ImageExcluirClick(Sender: TObject);
    procedure ImagePesquisaClick(Sender: TObject);
    procedure EditPesquisaKeyPress(Sender: TObject; var Key: Char);
  private
    procedure CarregarClientes;
  public
    { Public declarations }
  end;

var
  FormClientesGestao: TFormClientesGestao;

implementation

{$R *.dfm}

uses uDM, uFormClientes_INSERIR, uFormClientes_EDITAR, uFormExcluirCliente;

procedure TFormClientesGestao.CarregarClientes;
begin
  try
    with DM.FDQueryClientesGET do
    begin
      Close;
      SQL.Text := 'SELECT * FROM CLIENTES ORDER BY ID';
      Open;
    end;

    DataSource.DataSet := DM.FDQueryClientesGET;
    DBGrid.DataSource  := DataSource;
  except
    on E:Exception do
      ShowMessage('Houve um erro... Erro: '+E.Message);
  end;
end;

procedure TFormClientesGestao.EditPesquisaKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if key=#13 then
  begin
    key := #0;
    ImagePesquisaClick(Sender);
  end;
end;

procedure TFormClientesGestao.FormShow(Sender: TObject);
begin
  inherited;
  CarregarClientes;
end;

procedure TFormClientesGestao.ImageAdicinarClick(Sender: TObject);
var
  form: TFormClientes_INSERIR;
begin
  inherited;
  form := nil;
  try
    form := TFormClientes_INSERIR.Create(Self);
    form.Position := poScreenCenter;

    if form.ShowModal = mrOk then
      CarregarClientes;
  finally
    form.Free;
  end;
end;

procedure TFormClientesGestao.ImageEditarClick(Sender: TObject);
var
  form: TFormClientes_EDITAR;
  IDCliente: Integer;
begin
  inherited;
  form := nil;
  try
    with DM.FDQueryClientesGET do
    begin
      if (not Active) or (RecordCount=0) or (IsEmpty) then
      begin
        ShowMessage('Nenhum cliente selecionado!');
        Exit;
      end
      else
       IDCliente := FieldByName('ID').AsInteger;
    end;

    form           := TFormClientes_EDITAR.Create(Self);
    form.Position  := poScreenCenter;
    form.IDCliente := IDCliente;
    form.onExibir;

    if form.ModalResult = mrCancel then
      Exit;

    if form.ShowModal = mrOk then
      CarregarClientes;

  finally
    form.free;
  end;

end;

procedure TFormClientesGestao.ImageExcluirClick(Sender: TObject);
var
  form:TFormExcluirCliente;
  IDCLiente: Integer;
  NMCliente: String;
  CPF_CNPJ: String;
begin
  inherited;
  form := nil;

  try
    with DM.FDQueryClientesGET do
    begin
      if (not Active) or (RecordCount=0) or (IsEmpty) then
      begin
        ShowMessage('Nenhum cliente selecionado!');
        Exit;
      end
      else
      begin
        IDCLiente := FieldByName('ID').AsInteger;
        NMCliente := FieldByName('NOME').AsString;
        CPF_CNPJ  := FieldByName('CPF_CNPJ').AsString;
      end;
    end;

    form           := TFormExcluirCliente.Create(Self);
    form.Position  := poScreenCenter;
    form.IDCliente := IDCLiente;

    form.LabelDadosCliente.Caption := 'Nome: '+NMCliente+'. Registro: '+CPF_CNPJ+'.';

    if form.ShowModal= mrOk then
      CarregarClientes;

  finally
    form.Free;
  end;


end;

procedure TFormClientesGestao.ImagePesquisaClick(Sender: TObject);
var
  test:integer;
  sql_pesquisa:String;
begin
  inherited;
  try

    if not(EditPesquisa.Text='') then
    begin
      with DM.FDQueryClientesGET do
      begin
        Close;

        sql_pesquisa := 'SELECT * FROM CLIENTES WHERE '+
        'UPPER(NOME) LIKE :PESQUISA '+
        'OR UPPER(ENDERECO) LIKE :PESQUISA '+
        'OR UPPER(BAIRRO) LIKE :PESQUISA '+
        'OR UPPER(CIDADE) LIKE :PESQUISA '+
        'OR UPPER(EMAIL) LIKE :PESQUISA ';

        test:= Length(EditPesquisa.Text);

        if Length(EditPesquisa.Text)<2 then
          sql_pesquisa := sql_pesquisa + 'OR UPPER(TIPO_PESSOA) LIKE :PESQUISA ';
        if Length(EditPesquisa.Text)<3 then
          sql_pesquisa := sql_pesquisa + 'OR UPPER(UF) LIKE :PESQUISA ';
        if Length(EditPesquisa.Text)<11 then
          sql_pesquisa := sql_pesquisa + 'OR CEP LIKE :PESQUISA OR NUMERO LIKE :PESQUISA ';
        if Length(EditPesquisa.Text)<19 then
          sql_pesquisa := sql_pesquisa + 'OR CPF_CNPJ LIKE :PESQUISA ';
        if Length(EditPesquisa.Text)<21 then
          sql_pesquisa := sql_pesquisa + 'OR IE LIKE :PESQUISA OR TELEFONE LIKE :PESQUISA ';

        SQL.Text := sql_pesquisa;

        if Length(EditPesquisa.Text)<3 then
          ParamByName('PESQUISA').AsString := UpperCase(EditPesquisa.Text)
        else
          ParamByName('PESQUISA').AsString := '%'+UpperCase(EditPesquisa.Text)+'%';

        Open;
      end;
    end
    else
    begin
      CarregarClientes;
    end;
  except
    on E:Exception do
      ShowMessage('Houve um erro... Erro: '+E.Message);
  end;
end;

end.
