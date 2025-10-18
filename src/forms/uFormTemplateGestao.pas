unit uFormTemplateGestao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.Imaging.pngimage, Vcl.ExtCtrls, Vcl.ComCtrls;

type
  TFormTemplateGestao = class(TForm)
    PageControl1: TPageControl;
    PanelTitulo: TPanel;
    LabelTituloForm: TLabel;
    PanelPesquisa: TPanel;
    ImagePesquisa: TImage;
    EditPesquisa: TEdit;
    DBGrid: TDBGrid;
    PanelBotoes: TPanel;
    ImageEditar: TImage;
    ImageExcluir: TImage;
    ImageAdicinar: TImage;
    DataSource: TDataSource;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormTemplateGestao: TFormTemplateGestao;

implementation

{$R *.dfm}

end.
