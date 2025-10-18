program ProjetoNFe;

uses
  Vcl.Forms,
  uMainForm in 'src\forms\uMainForm.pas' {Form1},
  uDM in 'src\data\uDM.pas' {DM: TDataModule},
  uFormTemplateGestao in 'src\forms\uFormTemplateGestao.pas' {FormTemplateGestao},
  uFormClientesGestao in 'uFormClientesGestao.pas' {FormClientesGestao};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TFormClientesGestao, FormClientesGestao);
  Application.Run;
end.
