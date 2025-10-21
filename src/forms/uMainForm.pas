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
    GestaoOPNFes: TMenuItem;
    procedure GestaoOPClientesClick(Sender: TObject);
    procedure GestaoOPProdutosClick(Sender: TObject);
    procedure GestaoOPNFesClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

uses uFormClientesGestao, uFormProdutosGestao, uFormNFesGestao;

procedure TMainForm.GestaoOPClientesClick(Sender: TObject);
var
  form: TFormClientesGestao;
begin
  form := nil;
  try
    form := TFormClientesGestao.Create(Self);
    form.Position := poScreenCenter;
    form.ShowModal;
  finally
    form.Free;
  end;
end;

procedure TMainForm.GestaoOPNFesClick(Sender: TObject);
var
  form: TFormNFesGestao;
begin
  form:= nil;
  try
    form          := TFormNFesGestao.Create(Self);
    form.Position := poScreenCenter;
    form.ShowModal;
  finally
    form.Free;
  end;
end;

procedure TMainForm.GestaoOPProdutosClick(Sender: TObject);
var
  form: TFormProdutosGestao;
begin
  form := nil;
  try
    form          := TFormProdutosGestao.Create(Self);
    form.Position := poScreenCenter;
    form.ShowModal;
  finally
    form.Free;
  end;
end;

end.
