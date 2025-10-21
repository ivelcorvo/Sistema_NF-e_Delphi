program ProjetoNFe;

uses
  Vcl.Forms,
  uMainForm in 'src\forms\uMainForm.pas' {Form1},
  uDM in 'src\data\uDM.pas' {DM: TDataModule},
  uFormTemplateGestao in 'src\forms\uFormTemplateGestao.pas' {FormTemplateGestao},
  uFormClientesGestao in 'src\forms\uFormClientesGestao.pas' {FormClientesGestao},
  uFormProdutosGestao in 'src\forms\uFormProdutosGestao.pas' {FormProdutosGestao},
  uFormTemplateProdutos_INSERIR_EDITAR in 'src\forms\uFormTemplateProdutos_INSERIR_EDITAR.pas' {FormTemplateProdutos_INSERIR_EDITAR},
  uFormProdutos_INSERIR in 'src\forms\uFormProdutos_INSERIR.pas' {FormProdutos_INSERIR},
  uFormProdutos_EDITAR in 'src\forms\uFormProdutos_EDITAR.pas' {FormProdutos_EDITAR},
  uFormExcluirProduto in 'src\forms\uFormExcluirProduto.pas' {FormExcluirProduto},
  uFormTemplateClientes_INSERIR_EDITAR in 'src\forms\uFormTemplateClientes_INSERIR_EDITAR.pas' {FormTemplateClientes_INSERIR_EDITAR},
  uFormClientes_INSERIR in 'src\forms\uFormClientes_INSERIR.pas' {FormClientes_INSERIR},
  uUtils in 'src\utils\uUtils.pas',
  uFormClientes_EDITAR in 'src\forms\uFormClientes_EDITAR.pas' {FormClientes_EDITAR},
  uFormExcluirCliente in 'src\forms\uFormExcluirCliente.pas' {FormExcluirCliente},
  uFormNFesGestao in 'src\forms\uFormNFesGestao.pas' {FormNFesGestao};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TFormNFesGestao, FormNFesGestao);
  Application.Run;
end.
