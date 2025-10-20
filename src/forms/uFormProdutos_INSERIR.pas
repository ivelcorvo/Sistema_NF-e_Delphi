unit uFormProdutos_INSERIR;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFormTemplateProdutos_INSERIR_EDITAR,
  Vcl.StdCtrls, Vcl.Mask;

type
  TFormProdutos_INSERIR = class(TFormTemplateProdutos_INSERIR_EDITAR)
    procedure ButtonCancelarClick(Sender: TObject);
    procedure ButtonSalvarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormProdutos_INSERIR: TFormProdutos_INSERIR;

implementation

{$R *.dfm}

uses uDM;

procedure TFormProdutos_INSERIR.ButtonCancelarClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TFormProdutos_INSERIR.ButtonSalvarClick(Sender: TObject);
var
  preco: string;
  estoque: string;
begin
  inherited;
  try
    with DM.FDQueryProdutosRequest do
    begin
      Close;
      SQL.Clear;
      SQL.Add('INSERT INTO PRODUTOS (NOME,PRECO,ESTOQUE,UNIDADE,NCM,CFOP) VALUES (:NOME,:PRECO,:ESTOQUE,:UNIDADE,:NCM,:CFOP)');

      if (EditEstoqueProduto.Text='') then
        estoque := '0'
      else
        estoque := EditEstoqueProduto.text;

      if (EditPrecoProduto.Text='') then
        preco := '0,00'
      else
      begin
        preco := StringReplace(EditPrecoProduto.Text, '.', '', [rfReplaceAll]);
        //  preco := StringReplace(preco,',','.',[rfReplaceAll]);
      end;

      ParamByName('NOME').AsString     := EditNomeProduto.Text;
      ParamByName('PRECO').AsFloat     := StrToFloat(preco);
      ParamByName('ESTOQUE').AsInteger := StrToInt(estoque);
      ParamByName('UNIDADE').AsString  := ComboBoxUnidade.Text;
      ParamByName('NCM').AsString      := EditNCM.Text;
      ParamByName('CFOP').AsString     := EditCFOP.Text;

      ExecSQL;
    end;

    ShowMessage('Produto adicionado com sucesso!');
    ModalResult := mrOk;
  except
    on E:Exception do
      ShowMessage('Houve um Erro... Erro: '+E.Message);
  end;
end;

end.
