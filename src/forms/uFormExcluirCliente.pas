unit uFormExcluirCliente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TFormExcluirCliente = class(TForm)
    LabelTituloExcluir: TLabel;
    LabelDadosCliente: TLabel;
    ButtonCancelar: TButton;
    ButtonConfirmar: TButton;
    procedure ButtonCancelarClick(Sender: TObject);
    procedure ButtonConfirmarClick(Sender: TObject);
  private
    { Private declarations }
  public
    IDCliente: Integer;
  end;

var
  FormExcluirCliente: TFormExcluirCliente;

implementation

{$R *.dfm}

uses uDM;

procedure TFormExcluirCliente.ButtonCancelarClick(Sender: TObject);
begin
  Close;
end;

procedure TFormExcluirCliente.ButtonConfirmarClick(Sender: TObject);
begin
  try
    with DM.FDQueryClientesRequest do
    begin
      Close;
      SQL.Text := 'DELETE FROM CLIENTES WHERE ID = :ID';
      ParamByName('ID').AsInteger := IDCliente;
      ExecSQL;
    end;
    ShowMessage('Cliente exclído com sucesso!');
    ModalResult := mrOk;
  except
    on E:Exception do
      ShowMessage('Houve um erro... Erro: '+E.Message);
  end;
end;

end.
