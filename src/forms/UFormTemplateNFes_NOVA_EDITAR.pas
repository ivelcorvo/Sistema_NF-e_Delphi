unit UFormTemplateNFes_NOVA_EDITAR;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.StdCtrls, Vcl.Grids,
  Vcl.DBGrids, Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.Imaging.pngimage,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.DBCtrls;

type
  TFormTemplateNFes_NOVA_EDITAR = class(TForm)
    PanelNFe: TPanel;
    DBGridProdutosNFe: TDBGrid;
    Label1: TLabel;
    DateTimeDataEmisao: TDateTimePicker;
    EditCFOP: TEdit;
    EditNatureza: TEdit;
    LabelDataEmisao: TLabel;
    LabelCFOP: TLabel;
    LabelNatureza: TLabel;
    PanelBotoes: TPanel;
    ImageEditar: TImage;
    ImageExcluir: TImage;
    ImageAdicinar: TImage;
    ButtonCancelar: TButton;
    ButtonSalvar: TButton;
    DataSourceNFeProdutos: TDataSource;
    DBLookupComboBoxCliente: TDBLookupComboBox;
    DataSourceClientes: TDataSource;
    procedure EditCFOPKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormTemplateNFes_NOVA_EDITAR: TFormTemplateNFes_NOVA_EDITAR;

implementation

{$R *.dfm}

uses uUtils;

procedure TFormTemplateNFes_NOVA_EDITAR.EditCFOPKeyPress(Sender: TObject;
  var Key: Char);
begin
  ApenasNumeros(key);
end;

end.
