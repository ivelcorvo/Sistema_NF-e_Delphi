unit uFormNFesProdutos_EXCLUIR;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TFormNFesProdutos_EXCLUIR = class(TForm)
    ButtonCancelar: TButton;
    LabelTituloExcluir: TLabel;
    LabelDadosProduto: TLabel;
    Button2: TButton;
    procedure ButtonCancelarClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    IDProduto:Integer;
  end;

var
  FormNFesProdutos_EXCLUIR: TFormNFesProdutos_EXCLUIR;

implementation

{$R *.dfm}

uses uDM;

procedure TFormNFesProdutos_EXCLUIR.Button2Click(Sender: TObject);
begin
  try
    if DM.FDMemTableNFeProdutos.Locate('ID_PRODUTO',IDProduto) then
      DM.FDMemTableNFeProdutos.Delete;
    ModalResult := mrOk;
  except
    on E:Exception do
      ShowMessage('Houve um erro... Erro: '+E.Message);
  end;
end;

procedure TFormNFesProdutos_EXCLUIR.ButtonCancelarClick(Sender: TObject);
begin
  Close;
end;

end.
