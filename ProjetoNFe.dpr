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
  uFormExcluirProduto in 'src\forms\uFormExcluirProduto.pas' {FormExcluirProduto};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TFormClientesGestao, FormClientesGestao);
  Application.CreateForm(TFormProdutosGestao, FormProdutosGestao);
  Application.CreateForm(TFormTemplateProdutos_INSERIR_EDITAR, FormTemplateProdutos_INSERIR_EDITAR);
  Application.CreateForm(TFormProdutos_INSERIR, FormProdutos_INSERIR);
  Application.CreateForm(TFormProdutos_EDITAR, FormProdutos_EDITAR);
  Application.CreateForm(TFormExcluirProduto, FormExcluirProduto);
  Application.Run;
end.
