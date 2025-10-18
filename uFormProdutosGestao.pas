unit uFormProdutosGestao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFormTemplateGestao, Data.DB, Vcl.Grids,
  Vcl.DBGrids, Vcl.StdCtrls, Vcl.Imaging.pngimage, Vcl.ExtCtrls, Vcl.ComCtrls;

type
  TFormProdutosGestao = class(TFormTemplateGestao)
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormProdutosGestao: TFormProdutosGestao;

implementation

{$R *.dfm}

uses uDM;

procedure TFormProdutosGestao.FormShow(Sender: TObject);
begin
  inherited;
  try
    with DM.FDQueryProdutosGET do
    begin

    end;
  except
    on E:Exception do
      ShowMessage('Houve um Erro... Erro: '+E.Message);
  end;
end;

end.
