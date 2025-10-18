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
    procedure GestaoOPClientesClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

uses uFormClientesGestao;

procedure TMainForm.GestaoOPClientesClick(Sender: TObject);
var
  form: TFormClientesGestao;
begin
  form := nil;
  try
    form          := TFormClientesGestao.Create(Self);
    form.Position := poScreenCenter;
    form.ShowModal;

  finally
    form.free;
  end;
end;

end.
