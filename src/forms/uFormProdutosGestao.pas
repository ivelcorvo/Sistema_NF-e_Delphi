unit uFormProdutosGestao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFormTemplateGestao, Data.DB, Vcl.Grids,
  Vcl.DBGrids, Vcl.StdCtrls, Vcl.Imaging.pngimage, Vcl.ExtCtrls, Vcl.ComCtrls;

type
  TFormProdutosGestao = class(TFormTemplateGestao)
    procedure FormShow(Sender: TObject);
    procedure ImageAdicinarClick(Sender: TObject);
    procedure ImagePesquisaClick(Sender: TObject);
    procedure EditPesquisaKeyPress(Sender: TObject; var Key: Char);
    procedure ImageEditarClick(Sender: TObject);
    procedure ImageExcluirClick(Sender: TObject);
  private
    procedure CarregarProdutos;
  public
    { Public declarations }
  end;

var
  FormProdutosGestao: TFormProdutosGestao;

implementation

{$R *.dfm}

uses uDM, uFormProdutos_EDITAR, uFormProdutos_INSERIR, uFormExcluirProduto;

procedure TFormProdutosGestao.CarregarProdutos;
begin
  try
    with DM.FDQueryProdutosGET do
    begin
      Close;
      SQL.Text :='SELECT * FROM PRODUTOS ORDER BY ID';
      Open;
    end;
    DataSource.DataSet := DM.FDQueryProdutosGET;
    DBGrid.DataSource  := DataSource;
  except
    on E:Exception do
      ShowMessage('Houve um Erro... Erro: '+E.Message);
  end;
end;

procedure TFormProdutosGestao.EditPesquisaKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if key=#13 then
  begin
    key :=#0;
    ImagePesquisaClick(Sender);
  end;
end;

procedure TFormProdutosGestao.FormShow(Sender: TObject);
begin
  inherited;
  CarregarProdutos;
end;

procedure TFormProdutosGestao.ImageAdicinarClick(Sender: TObject);
var
  form:TFormProdutos_INSERIR;
begin
  inherited;
  form := nil;
  try
    form          := TFormProdutos_INSERIR.Create(Self);
    form.Position := poScreenCenter;

    if form.ShowModal = mrOk then
      CarregarProdutos;
  finally
    form.Free;
  end;
end;

procedure TFormProdutosGestao.ImageEditarClick(Sender: TObject);
var
  form: TFormProdutos_EDITAR;
  IDProduto: Integer;
begin
  inherited;
  form := nil;
  try
    with DM.FDQueryProdutosGET do
    begin;
      if (not Active) or (RecordCount=0) or (IsEmpty) then
      begin
        ShowMessage('Nenhum produto selecionado!');
        exit;
      end
      else
        IDProduto := FieldByName('ID').AsInteger;      
    end;

    form           := TFormProdutos_EDITAR.Create(Self);
    form.Position  := poScreenCenter;
    form.IDProduto := IDProduto;
    form.onExibir;

    if form.ModalResult = mrCancel then
      exit;

    if form.ShowModal = mrOk then
      CarregarProdutos;

  finally
    form.Free;
  end;
end;

procedure TFormProdutosGestao.ImageExcluirClick(Sender: TObject);
var
  form:TFormExcluirProduto;
  IDProduto: Integer;
  NMProduto: string;
  NCMProduto: string;
  CFOPProduto: string;
begin
  inherited;
  form := nil;
  try
    with dm.FDQueryProdutosGET do
    begin
      if (not Active) or (RecordCount=0) or (IsEmpty) then
      begin
        ShowMessage('Nenhum produto selecionado!');
        exit;
      end
      else
      begin
        IDProduto   := FieldByName('ID').AsInteger;
        NMProduto   := FieldByName('NOME').AsString;
        NCMProduto  := FieldByName('NCM').AsString;
        CFOPProduto := FieldByName('CFOP').AsString;
      end;
    end;

    form                      := TFormExcluirProduto.Create(Self);
    form.Position             := poScreenCenter;
    form.IDProduto            := IDProduto;

    form.LabelDescricaoProduto.Caption := 'Nome: '+NMProduto+'. NCM: '+NCMProduto+'. CFOP: '+CFOPProduto+'.' ;

    if form.ShowModal=mrOk then
      CarregarProdutos;
                  
  finally
    form.Free;
  end;
end;

procedure TFormProdutosGestao.ImagePesquisaClick(Sender: TObject);
begin
  inherited;
  try
    with DM.FDQueryProdutosGET do
    begin

      if not (EditPesquisa.Text='') then
      begin
        Close;
        SQL.Text := 'SELECT * FROM PRODUTOS WHERE '+
        'UPPER(NOME) LIKE :PESQUISA';
        ParamByName('PESQUISA').AsString := '%'+UpperCase(EditPesquisa.Text)+'%';
        Open;
      end
      else
        CarregarProdutos;

    end;
  except
    on E:Exception do
      ShowMessage('Houve um Erro... Erro: '+E.Message);
  end;
end;

end.
