unit uFormClientes_INSERIR;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFormTemplateClientes_INSERIR_EDITAR,
  Vcl.StdCtrls, Vcl.Mask;

type
  TFormClientes_INSERIR = class(TFormTemplateClientes_INSERIR_EDITAR)
    procedure ButtonCancelarClick(Sender: TObject);
    procedure ComboBoxTipoPessoaChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ButtonSalvarClick(Sender: TObject);
  private
    procedure RefatoraPorTipoPessoa;
    procedure CarregaUFs;
  public

  end;

var
  FormClientes_INSERIR: TFormClientes_INSERIR;

implementation

{$R *.dfm}

uses uUtils, uDM;

procedure TFormClientes_INSERIR.RefatoraPorTipoPessoa;
begin
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

procedure TFormClientes_INSERIR.CarregaUFs;
begin
  ComboBoxUF.Items.Clear;
  ComboBoxUF.Items.Assign(ListaUFs);
end;

procedure TFormClientes_INSERIR.ButtonCancelarClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TFormClientes_INSERIR.ButtonSalvarClick(Sender: TObject);
var
  campos_em_branco:string;
begin
  inherited;
  try

    campos_em_branco := '';
    if (EditNome.Text='') or (ComboBoxTipoPessoa.Text='') or ((ComboBoxTipoPessoa.Text='Pessoa Jurídica')and(EditIE.text='')) or (LimparDocumento(MaskEdit_CPF_CNPJ.Text)='') then
    begin
      campos_em_branco := 'Por favor preencha os campos: ';

      if (EditNome.Text='') then
        campos_em_branco := campos_em_branco + 'Nome, ';
      if (ComboBoxTipoPessoa.Text='') then
        campos_em_branco := campos_em_branco + 'Tipo de pessoa, ';
      if ((ComboBoxTipoPessoa.Text='Pessoa Jurídica')and(EditIE.text='')) then
        campos_em_branco := campos_em_branco + 'IE, ';
      if (LimparDocumento(MaskEdit_CPF_CNPJ.Text)='') then
        campos_em_branco := campos_em_branco + 'CPF/CNPJ, ';

      campos_em_branco := RemoveUltimoElemento(campos_em_branco,', ');

      ShowMessage(campos_em_branco);
      Exit;
    end;

    if (EditNome.text='') or (MaskEdit_CPF_CNPJ.Text='') then
    begin
      ShowMessage('Nome e Registro (CPF ou CNPJ) são obrigatórios!');
      Exit;
    end;

    with DM.FDQueryClientesRequest do
    begin
      Close;
      SQL.Text := 'INSERT INTO CLIENTES (NOME,CPF_CNPJ,IE,TIPO_PESSOA,ENDERECO,NUMERO,BAIRRO,CIDADE,UF,CEP,TELEFONE,EMAIL) '+
      'VALUES (:NOME,:CPF_CNPJ,:IE,:TIPO_PESSOA,:ENDERECO,:NUMERO,:BAIRRO,:CIDADE,:UF,:CEP,:TELEFONE,:EMAIL)';
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
    ShowMessage('Cliente cadastrado com sucesso!');
    ModalResult := mrOk;
  except
    on E:Exception do
      ShowMessage('Houve um erro... Erro: '+E.Message);
  end;
end;

procedure TFormClientes_INSERIR.ComboBoxTipoPessoaChange(Sender: TObject);
begin
  inherited;
  RefatoraPorTipoPessoa;
end;

procedure TFormClientes_INSERIR.FormCreate(Sender: TObject);
begin
  inherited;
  CarregaUFs;
end;

end.
