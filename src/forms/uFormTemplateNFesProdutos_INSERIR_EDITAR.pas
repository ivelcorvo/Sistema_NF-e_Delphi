unit uFormTemplateNFesProdutos_INSERIR_EDITAR;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.DBCtrls, Data.DB;

type
  TFormTemplateNFesProdutos_INSERIR_EDITAR = class(TForm)
    LabelProduto: TLabel;
    EditQuantidade: TEdit;
    LabelQuantidade: TLabel;
    EditPreco: TEdit;
    EditTotal: TEdit;
    LabelPreco: TLabel;
    LabelTotal: TLabel;
    ButtonCancelar: TButton;
    ButtonAdicionar: TButton;
    DBLookupComboBoxProduto: TDBLookupComboBox;
    DataSource: TDataSource;
    EditNCM: TEdit;
    LabelNCM: TLabel;
    procedure EditQuantidadeKeyPress(Sender: TObject; var Key: Char);
    procedure EditNCMKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public

  end;

var
  FormTemplateNFesProdutos_INSERIR_EDITAR: TFormTemplateNFesProdutos_INSERIR_EDITAR;

implementation

{$R *.dfm}

uses uUtils;

procedure TFormTemplateNFesProdutos_INSERIR_EDITAR.EditNCMKeyPress(
  Sender: TObject; var Key: Char);
begin
  ApenasNumeros(key);
end;

procedure TFormTemplateNFesProdutos_INSERIR_EDITAR.EditQuantidadeKeyPress(
  Sender: TObject; var Key: Char);
begin
  ApenasNumeros(key);
end;

end.
