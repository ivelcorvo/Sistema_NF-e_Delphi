unit uFormExcluirProduto;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TFormExcluirProduto = class(TForm)
    LabelTituloExcluir: TLabel;
    ButtonCancelar: TButton;
    ButtonConfirmar: TButton;
    LabelDescricaoProduto: TLabel;
    procedure ButtonCancelarClick(Sender: TObject);
    procedure ButtonConfirmarClick(Sender: TObject);
  private
    { Private declarations }
  public
    IDProduto: integer;
  end;

var
  FormExcluirProduto: TFormExcluirProduto;

implementation

{$R *.dfm}

uses uDM;

procedure TFormExcluirProduto.ButtonCancelarClick(Sender: TObject);
begin
  Close;
end;

procedure TFormExcluirProduto.ButtonConfirmarClick(Sender: TObject);
begin
  try
    with DM.FDQueryProdutosRequest do
    begin
      Close;
      SQL.Text := 'DELETE FROM PRODUTOS WHERE ID = :ID';
      ParamByName('ID').AsInteger := IDProduto;
      ExecSQL;
    end;
    ShowMessage('Produto excluído com sucesso!');
    ModalResult := mrOk;
  except
    on E:Exception do
      ShowMessage('Houve um Erro... Erro: '+E.Message);
  end;
end;

end.
