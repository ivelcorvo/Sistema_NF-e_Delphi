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

end.
