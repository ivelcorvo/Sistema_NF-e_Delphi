unit uFormProdutos_EDITAR;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFormTemplateProdutos_INSERIR_EDITAR,
  Vcl.StdCtrls, Vcl.Mask;

type
  TFormProdutos_EDITAR = class(TFormTemplateProdutos_INSERIR_EDITAR)
    procedure ButtonCancelarClick(Sender: TObject);
    procedure ButtonSalvarClick(Sender: TObject);
  private
    procedure CarregarProduto;
  public
    IDProduto: Integer;
    procedure onExibir;
  end;

var
  FormProdutos_EDITAR: TFormProdutos_EDITAR;

implementation

{$R *.dfm}

uses uDM;

procedure TFormProdutos_EDITAR.ButtonSalvarClick(Sender: TObject);
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

      SQL.Add('UPDATE PRODUTOS SET ');
      SQL.Add('NOME = :NOME, ');
      SQL.Add('PRECO = :PRECO, ');
      SQL.Add('ESTOQUE = :ESTOQUE, ');
      SQL.Add('UNIDADE = :UNIDADE, ');
      SQL.Add('NCM = :NCM, ');
      SQL.Add('CFOP = :CFOP ');
      SQL.Add('WHERE ID = :ID');

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
      ParamByName('ID').AsInteger      := IDProduto;

      ExecSQL;      
    end;

    ShowMessage('Produto atualizado com sucesso!');
    ModalResult := mrOk;
  except
    on E:Exception do
      ShowMessage('Houve um Erro... Erro: '+E.Message);
  end;
end;

procedure TFormProdutos_EDITAR.CarregarProduto;
var
  indexUnidadeSelecionada: Integer;
begin
  try
    with DM.FDQueryProdutoGET do
    begin
      Close;
      SQL.Text := 'SELECT * FROM PRODUTOS WHERE ID = :ID';
      ParamByName('ID').AsInteger := IDProduto;
      Open;

      if(not IsEmpty) then
      begin

        indexUnidadeSelecionada := ComboBoxUnidade.Items.IndexOf(FieldByName('UNIDADE').AsString);

        ComboBoxUnidade.ItemIndex := indexUnidadeSelecionada;

        EditNomeProduto.Text    := FieldByName('NOME').AsString;
        EditPrecoProduto.Text   := FloatToStr(FieldByName('PRECO').AsFloat);
        EditEstoqueProduto.Text := IntToStr(FieldByName('ESTOQUE').AsInteger);
        EditNCM.Text            := FieldByName('NCM').AsString;
        EditCFOP.Text           := FieldByName('CFOP').AsString;

      end
      else
      begin
        ShowMessage('Produto não encontrado!');
        Close;
        ModalResult := mrCancel;
      end;  
    end;    
    
  except
    on E:Exception do
      ShowMessage('Houve um Erro... Erro: '+E.Message);
  end;
end;

procedure TFormProdutos_EDITAR.ButtonCancelarClick(Sender: TObject);
begin
  inherited;
  if DM.FDQueryProdutoGET.Active then
    DM.FDQueryProdutoGET.Close;
  Close;
end;

procedure TFormProdutos_EDITAR.onExibir;
begin
  CarregarProduto;
end;

end.
