unit uFormNFesGestao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFormTemplateGestao, Data.DB, Vcl.Grids,
  Vcl.DBGrids, Vcl.StdCtrls, Vcl.Imaging.pngimage, Vcl.ExtCtrls, Vcl.ComCtrls;

type
  TFormNFesGestao = class(TFormTemplateGestao)
    ImageTransmitir: TImage;
    procedure ImageAdicinarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ImageEditarClick(Sender: TObject);
  private
    procedure CarregarNFes;
  public

  end;

var
  FormNFesGestao: TFormNFesGestao;

implementation

{$R *.dfm}

uses uDM, uFormNFes_NOVA, uFormNFes_EDITAR;

procedure TFormNFesGestao.CarregarNFes;
begin
  try
    with DM.FDQueryNotasFiscaisGET do
    begin
      Close;
      SQL.Text := 'SELECT NF.ID, NF.NUMERO, NF.SERIE, NF.DATA_EMISSAO, NF.VALOR_TOTAL, NF.STATUS, C.NOME AS CLIENTE '+
      'FROM NOTAS_FISCAIS NF '+
      'JOIN CLIENTES C ON C.ID = NF.ID_CLIENTE '+
      'ORDER BY NF.DATA_EMISSAO DESC';
      Open;
    end;
    DataSource.DataSet := DM.FDQueryNotasFiscaisGET;
    DBGrid.DataSource  := DataSource;
  except
    on E:Exception do
      ShowMessage('Houve um erro... Erro: '+E.Message);
  end;
end;

procedure TFormNFesGestao.FormShow(Sender: TObject);
begin
  inherited;
  CarregarNFes;
end;

procedure TFormNFesGestao.ImageAdicinarClick(Sender: TObject);
var
  form:TFormNFes_NOVA;
begin
  inherited;
  form := nil;
  try
    form          := TFormNFes_NOVA.Create(Self);
    form.Position := poScreenCenter;

    form.onExibir;

    if form.ShowModal=mrok then
      CarregarNFes;
  finally
    form.Free;
  end;
end;

procedure TFormNFesGestao.ImageEditarClick(Sender: TObject);
var
  form: TFormNFes_EDITAR;
  IDNota: Integer;
begin
  inherited;

  form := nil;

  try
    with DM.FDQueryNotasFiscaisGET do
    begin
      if (not Active) or (RecordCount=0) or (IsEmpty) then
      begin
        ShowMessage('Nenhuma nota selecionada!');
        Exit;
      end
      else
        IDNota := FieldByName('ID').AsInteger;
    end;

    form          := TFormNFes_EDITAR.Create(Self);
    form.Position := poScreenCenter;
    form.IDNota   := IDNota;

    form.onExibir;

    if form.ModalResult = mrCancel then
      exit;

    if form.ShowModal=mrOk then
      CarregarNFes;
  finally
    form.Free;
  end;

end;

end.
