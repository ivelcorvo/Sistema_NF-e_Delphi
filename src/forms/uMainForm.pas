unit uMainForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus;

type
  TMainForm = class(TForm)
    MainMenu1: TMainMenu;
    Gesto1: TMenuItem;
    GestaoOPClientes: TMenuItem;
    GestaoOPProdutos: TMenuItem;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

end.
