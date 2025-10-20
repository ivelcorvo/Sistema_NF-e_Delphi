unit uFormTemplateProdutos_INSERIR_EDITAR;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask;

type
  TFormTemplateProdutos_INSERIR_EDITAR = class(TForm)
    EditNomeProduto: TEdit;
    LabelNomeProduto: TLabel;
    LabelPrecoProduto: TLabel;
    LabelEstoqueProduto: TLabel;
    EditEstoqueProduto: TEdit;
    ButtonCancelar: TButton;
    ButtonSalvar: TButton;
    LabelNCM: TLabel;
    LabelCFOP: TLabel;
    ComboBoxUnidade: TComboBox;
    LabelUnidade: TLabel;
    EditPrecoProduto: TEdit;
    EditNCM: TEdit;
    EditCFOP: TEdit;
    procedure EditEstoqueProdutoKeyPress(Sender: TObject; var Key: Char);
    procedure EditPrecoProdutoKeyPress(Sender: TObject; var Key: Char);
    procedure EditNCMKeyPress(Sender: TObject; var Key: Char);
    procedure EditCFOPKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormTemplateProdutos_INSERIR_EDITAR: TFormTemplateProdutos_INSERIR_EDITAR;

implementation

{$R *.dfm}

uses uUtils;

procedure TFormTemplateProdutos_INSERIR_EDITAR.EditCFOPKeyPress(Sender: TObject;
  var Key: Char);
begin
  ApenasNumeros(key);
end;

procedure TFormTemplateProdutos_INSERIR_EDITAR.EditEstoqueProdutoKeyPress(
  Sender: TObject; var Key: Char);
begin
  ApenasNumeros(key);
end;

procedure TFormTemplateProdutos_INSERIR_EDITAR.EditNCMKeyPress(Sender: TObject;
  var Key: Char);
begin
  ApenasNumeros(key);
end;

procedure TFormTemplateProdutos_INSERIR_EDITAR.EditPrecoProdutoKeyPress(
  Sender: TObject; var Key: Char);
begin
  ApenasNumerosPreco(key);
end;

end.
