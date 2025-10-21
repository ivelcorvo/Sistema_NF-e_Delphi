unit uFormNFesGestao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFormTemplateGestao, Data.DB, Vcl.Grids,
  Vcl.DBGrids, Vcl.StdCtrls, Vcl.Imaging.pngimage, Vcl.ExtCtrls, Vcl.ComCtrls;

type
  TFormNFesGestao = class(TFormTemplateGestao)
    ImageTransmitir: TImage;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormNFesGestao: TFormNFesGestao;

implementation

{$R *.dfm}

uses uDM;

procedure TFormNFesGestao.FormShow(Sender: TObject);
begin
  inherited;
  try
    with DM.FDQueryNotasFiscaisGET do
    begin
      Close;
      SQL.Text := 'SELECT NF.ID, NF.NUMERO, NF.SERIE, NF.DATA_EMISSAO, NF.VALOR_TOTAL, NF.STATUS, C.NOME AS CLIENTE'+
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

end.
