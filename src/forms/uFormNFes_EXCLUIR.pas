unit uFormNFes_EXCLUIR;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TFormNFes_EXCLUIR = class(TForm)
    LabelTituloExcluir: TLabel;
    LabelDadosNfe: TLabel;
    ButtonCancelar: TButton;
    ButtonConfirmar: TButton;
    procedure ButtonCancelarClick(Sender: TObject);
    procedure ButtonConfirmarClick(Sender: TObject);
  private
    { Private declarations }
  public
    IDNota: Integer;
  end;

var
  FormNFes_EXCLUIR: TFormNFes_EXCLUIR;

implementation

{$R *.dfm}

uses uDM;

procedure TFormNFes_EXCLUIR.ButtonCancelarClick(Sender: TObject);
begin
  Close;
end;

procedure TFormNFes_EXCLUIR.ButtonConfirmarClick(Sender: TObject);
begin
  DM.FDConnection.StartTransaction;
  try

    // EXCLUI OS ITENS DA NOTA
    with DM.FDQueryNotasItensRequest do
    begin
      Close;
      SQL.Text := 'DELETE FROM NOTAS_ITENS WHERE ID_NOTA = :ID_NOTA';
      ParamByName('ID_NOTA').AsInteger := IDNota;
      ExecSQL;
    end;

    // EXCLUI A NOTA
    with DM.FDQueryNotasFiscaisRequest do
    begin
      Close;
      SQL.Text := 'DELETE FROM NOTAS_FISCAIS WHERE ID = :ID';
      ParamByName('ID').AsInteger := IDNota;
      ExecSQL;
    end;

    DM.FDConnection.Commit;
    ShowMessage('NF-e Exluída com sucesso!');
    ModalResult := mrOk;
  except
    on E:Exception do
    begin
      DM.FDConnection.Rollback;
      ShowMessage('Houve um erro... Erro: '+E.Message);
    end;
  end;
end;

end.
