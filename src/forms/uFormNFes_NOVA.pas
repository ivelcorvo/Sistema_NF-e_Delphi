unit uFormNFes_NOVA;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UFormTemplateNFes_NOVA_EDITAR, Data.DB,
  Vcl.Imaging.pngimage, Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TFormNFes_NOVA = class(TFormTemplateNFes_NOVA_EDITAR)
    procedure ImageAdicinarClick(Sender: TObject);
  private
    procedure CarregaProdutos;
    //procedure CarregaNFeProdutos;
  public
    procedure onExibir;
  end;

var
  FormNFes_NOVA: TFormNFes_NOVA;

implementation

{$R *.dfm}

uses uFormNFesProdutos_INSERIR, uDM;

procedure TFormNFes_NOVA.CarregaProdutos;
begin
  try
    with DM.FDQueryProdutosGET do
    begin
      Close;
      SQL.Text := 'SELECT * FROM PRODUTOS';
      Open;
    end;

    DM.FDMemTableProdutos.Close;
    DM.FDMemTableProdutos.CopyDataSet(DM.FDQueryProdutosGET, [coStructure,coAppend]);

    //  apenas para vizualização
    //  DataSource.DataSet        := DM.FDMemTableProdutos;
    //  DBGridProdutos.DataSource := DataSource;
  except
    on E:Exception do
      ShowMessage('Houve um erro... Erro: '+E.Message);
  end;
end;

//procedure TFormNFes_NOVA.CarregaNFeProdutos;
//begin
//end;

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
    form.ShowModal;
  finally
    form.Free;
  end;
end;

procedure TFormNFes_NOVA.onExibir;
begin
  CarregaProdutos;
end;

end.
