unit uFormClientesGestao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFormTemplateGestao, Data.DB, Vcl.Grids,
  Vcl.DBGrids, Vcl.StdCtrls, Vcl.Imaging.pngimage, Vcl.ExtCtrls, Vcl.ComCtrls;

type
  TFormClientesGestao = class(TFormTemplateGestao)
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormClientesGestao: TFormClientesGestao;

implementation

{$R *.dfm}


end.
