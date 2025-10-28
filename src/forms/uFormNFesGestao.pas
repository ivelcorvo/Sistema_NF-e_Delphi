unit uFormNFesGestao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFormTemplateGestao, Data.DB, Vcl.Grids,
  Vcl.DBGrids, Vcl.StdCtrls, Vcl.Imaging.pngimage, Vcl.ExtCtrls, Vcl.ComCtrls;

type
  TFormNFesGestao = class(TFormTemplateGestao)
    ImageTransmitir: TImage;
    ImageGerarXML: TImage;
    procedure ImageAdicinarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ImageEditarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ImageExcluirClick(Sender: TObject);
    function PermiteAcaoPorStatus():Boolean;
  private
    procedure CarregarNFes;
  public

  end;

var
  FormNFesGestao: TFormNFesGestao;

implementation

{$R *.dfm}

uses uDM, uFormNFes_NOVA, uFormNFes_EDITAR, uFormNFes_EXCLUIR;

function TFormNFesGestao.PermiteAcaoPorStatus():Boolean;
var
  status: string;
begin
  Result := True;
  with DM.FDQueryNotasFiscaisGET do
  begin
    if (Active) and (RecordCount>0) and (not IsEmpty) then
    begin
      status := FieldByName('STATUS').AsString;
      if not(status='RASCUNHO') or not(status='REJEITADA') then
      begin
        ShowMessage('NF-e em status: '+status+'. Não é possível editar ou excluir.');
        Result := False;
      end;
    end;
  end;
end;

procedure TFormNFesGestao.CarregarNFes;
begin
  try
    with DM.FDQueryNotasFiscaisGET do
    begin
      Close;
      SQL.Text := 'SELECT NF.ID, NF.NUMERO, NF.SERIE, NF.DATA_EMISSAO, NF.CFOP_PADRAO, NF.VALOR_TOTAL, NF.STATUS, C.NOME AS CLIENTE '+
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

    if (not PermiteAcaoPorStatus) then
      Exit;

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

procedure TFormNFesGestao.ImageExcluirClick(Sender: TObject);
var
  form: TFormNFes_EXCLUIR;
  IDNota: Integer;
  NumNota: Integer;
begin
  inherited;
  form := nil;

  if (not PermiteAcaoPorStatus) then
    Exit;

  try
    with DM.FDQueryNotasFiscaisGET do
    begin
      if (not Active) or (RecordCount=0) or (IsEmpty) then
      begin
        ShowMessage('Nenhuma NF-e selecionada!');
        Exit;
      end
      else
      begin
        IDNota  := FieldByName('ID').AsInteger;
        NumNota := FieldByName('NUMERO').AsInteger;
      end;
    end;

    form                       := TFormNFes_EXCLUIR.Create(Self);
    form.Position              := poScreenCenter;
    form.IDNota                := IDNota;
    form.LabelDadosNfe.Caption := 'NF-e número: '+IntToStr(NumNota);

    if form.ShowModal=mrOk then
      CarregarNFes;

  finally
    form.Free;
  end;
end;

procedure TFormNFesGestao.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  if DM.FDQueryNotasFiscaisGET.Active then
    DM.FDQueryNotasFiscaisGET.Close;
end;

procedure TFormNFesGestao.FormShow(Sender: TObject);
begin
  inherited;
  CarregarNFes;
end;

end.
