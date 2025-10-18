unit uFormTemplateProdutos_INSERIR_EDITAR;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TFormTemplateProdutos_INSERIR_EDITAR = class(TForm)
    EditNomeProduto: TEdit;
    LabelNomeProduto: TLabel;
    LabelPrecoProduto: TLabel;
    EditPrecoProduto: TEdit;
    LabelEstoqueProduto: TLabel;
    EditEstoqueProduto: TEdit;
    ButtonCancelar: TButton;
    ButtonSalvar: TButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormTemplateProdutos_INSERIR_EDITAR: TFormTemplateProdutos_INSERIR_EDITAR;

implementation

{$R *.dfm}

end.
