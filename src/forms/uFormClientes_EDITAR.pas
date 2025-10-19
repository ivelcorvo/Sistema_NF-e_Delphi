unit uFormClientes_EDITAR;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFormTemplateClientes_INSERIR_EDITAR,
  Vcl.StdCtrls, Vcl.Mask;

type
  TFormClientes_EDITAR = class(TFormTemplateClientes_INSERIR_EDITAR)
    procedure ComboBoxTipoPessoaChange(Sender: TObject);
    procedure ButtonCancelarClick(Sender: TObject);
    procedure ButtonSalvarClick(Sender: TObject);
  private
    procedure CarregarCliente;
  public
    IDCliente: integer;
    procedure CarregaUFs;
    procedure onExibir;
  end;

var
  FormClientes_EDITAR: TFormClientes_EDITAR;

implementation

{$R *.dfm}

uses uDM, uUtils;

procedure TFormClientes_EDITAR.CarregaUFs;
begin
  ComboBoxUF.Items.Clear;
  ComboBoxUF.Items.Assign(ListaUFs);
end;

procedure TFormClientes_EDITAR.ButtonCancelarClick(Sender: TObject);
begin
  inherited;
  if DM.FDQueryClienteGET.Active then
    DM.FDQueryClienteGET.Close;
  Close;
end;

procedure TFormClientes_EDITAR.ButtonSalvarClick(Sender: TObject);
begin
  inherited;
  try
    with DM.FDQueryClientesRequest do
    begin
      Close;
      SQL.Clear;

      SQL.Add('UPDATE CLIENTES SET ');
      SQL.Add('NOME = :NOME, ');
      SQL.Add('CPF_CNPJ = :CPF_CNPJ, ');
      SQL.Add('IE = :IE, ');
      SQL.Add('ENDERECO = :ENDERECO, ');
      SQL.Add('NUMERO = :NUMERO, ');
      SQL.Add('BAIRRO = :BAIRRO, ');
      SQL.Add('CIDADE = :CIDADE, ');
      SQL.Add('CEP = :CEP, ');
      SQL.Add('TELEFONE = :TELEFONE, ');
      SQL.Add('EMAIL = :EMAIL, ');
      SQL.Add('UF = :UF, ');
      SQL.Add('TIPO_PESSOA = :TIPO_PESSOA');
      SQL.Add('WHERE ID = :ID');

      ParamByName('ID').AsInteger         := IDCliente;
      ParamByName('NOME').AsString        := EditNome.Text;
      ParamByName('CPF_CNPJ').AsString    := MaskEdit_CPF_CNPJ.Text;
      ParamByName('IE').AsString          := EditIE.Text;
      ParamByName('TIPO_PESSOA').AsString := TipoPessoaCharParaDB(ComboBoxTipoPessoa.ItemIndex);
      ParamByName('ENDERECO').AsString    := EditEndereco.Text;
      ParamByName('NUMERO').AsString      := EditNumero.Text;
      ParamByName('BAIRRO').AsString      := EditBairrao.Text;
      ParamByName('CIDADE').AsString      := EditCidade.Text;
      ParamByName('UF').AsString          := ComboBoxUF.Text;
      ParamByName('CEP').AsString         := MaskEditCEP.Text;
      ParamByName('TELEFONE').AsString    := EditTelefone.Text;
      ParamByName('EMAIL').AsString       := EditEmail.Text;

      ExecSQL;
    end;
    ShowMessage(' Cliente atualizado com sucesso!');
    ModalResult := mrOk;
  except
    on E:Exception do
      ShowMessage('Houve um erro... Erro: '+E.Message);
  end;
end;

procedure TFormClientes_EDITAR.CarregarCliente;
var
  indexTipoPessoaSelecionado: Integer;
  indexUFSelecionado: Integer;
begin
  try
    with DM.FDQueryClienteGET do
    begin
      Close;
      SQL.Text := 'SELECT * FROM CLIENTES WHERE ID = :ID';
      ParamByName('ID').AsInteger := IDCliente;
      Open;

      indexUFSelecionado         := ComboBoxUF.Items.IndexOf(FieldByName('UF').AsString);
      indexTipoPessoaSelecionado := ComboBoxTipoPessoa.Items.IndexOf(TipoPessoaStringParaDB(FieldByName('TIPO_PESSOA').AsString));

      ComboBoxTipoPessoa.ItemIndex := indexTipoPessoaSelecionado;
      ComboBoxUF.ItemIndex         := indexUFSelecionado;

      EditNome.Text          := FieldByName('NOME').AsString;
      MaskEdit_CPF_CNPJ.Text := FieldByName('CPF_CNPJ').AsString;
      EditIE.Text            := FieldByName('IE').AsString;
      EditEndereco.Text      := FieldByName('ENDERECO').AsString;
      EditNumero.Text        := FieldByName('NUMERO').AsString;
      EditBairrao.Text       := FieldByName('BAIRRO').AsString;
      EditCidade.Text        := FieldByName('CIDADE').AsString;
      MaskEditCEP.Text       := FieldByName('CEP').AsString;
      EditTelefone.Text      := FieldByName('TELEFONE').AsString;
      EditEmail.Text         := FieldByName('EMAIL').AsString;
    end;
  except
    on E:Exception do
    begin
      ShowMessage('Houve um erro... Erro: '+E.Message);
      ModalResult := mrCancel;
    end;
  end;
end;

procedure TFormClientes_EDITAR.ComboBoxTipoPessoaChange(Sender: TObject);
begin
  inherited;
  if ComboBoxTipoPessoa.ItemIndex <> -1 then
  begin
    case ComboBoxTipoPessoa.ItemIndex of
      0:
      begin
        Label_CPF_CNPJ.Caption     := 'CPF';
        MaskEdit_CPF_CNPJ.ReadOnly := False;
        MaskEdit_CPF_CNPJ.EditText := '';
        MaskEdit_CPF_CNPJ.EditMask := '999.999.999-99;1;_';
        EditIE.ReadOnly            := True;
        EditIE.Text                := '';
      end;
      1:
      begin
        Label_CPF_CNPJ.Caption     := 'CNPJ';
        MaskEdit_CPF_CNPJ.ReadOnly := False;
        MaskEdit_CPF_CNPJ.EditText := '';
        MaskEdit_CPF_CNPJ.EditMask := '99.999.999/9999-99;1;_';
        EditIE.ReadOnly            := False;
        EditIE.Text                := '';
      end;
    end;
  end;
end;

procedure TFormClientes_EDITAR.onExibir;
begin
  CarregaUFs;
  CarregarCliente;
end;

end.
