unit uFormTemplateClientes_INSERIR_EDITAR;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.Mask;

type
  TFormTemplateClientes_INSERIR_EDITAR = class(TForm)
    EditNome: TEdit;
    LabelNome: TLabel;
    MaskEdit_CPF_CNPJ: TMaskEdit;
    LabelTipoPessoa: TLabel;
    ComboBoxTipoPessoa: TComboBox;
    Label_CPF_CNPJ: TLabel;
    LabelIE: TLabel;
    EditIE: TEdit;
    LabelEndereco: TLabel;
    EditEndereco: TEdit;
    LabelNumero: TLabel;
    EditNumero: TEdit;
    LabelBairrao: TLabel;
    EditBairrao: TEdit;
    LabelCidade: TLabel;
    EditCidade: TEdit;
    LabelEmail: TLabel;
    EditEmail: TEdit;
    ComboBoxUF: TComboBox;
    LabelUF: TLabel;
    LabelCEP: TLabel;
    MaskEditCEP: TMaskEdit;
    EditTelefone: TEdit;
    LabelTelefone: TLabel;
    ButtonSalvar: TButton;
    ButtonCancelar: TButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormTemplateClientes_INSERIR_EDITAR: TFormTemplateClientes_INSERIR_EDITAR;

implementation

{$R *.dfm}

end.
