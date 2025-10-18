unit uFormProdutos_EDITAR;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFormTemplateProdutos_INSERIR_EDITAR,
  Vcl.StdCtrls;

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
      SQL.Add('ESTOQUE = :ESTOQUE ');
      SQL.Add('WHERE ID = :ID');

      ParamByName('NOME').AsString     := EditNomeProduto.Text;
      ParamByName('PRECO').AsFloat     := StrToFloat(EditPrecoProduto.Text);
      ParamByName('ESTOQUE').AsInteger := StrToInt(EditEstoqueProduto.Text);
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
        EditNomeProduto.Text    := FieldByName('NOME').AsString;
        EditPrecoProduto.Text   := FloatToStr(FieldByName('PRECO').AsFloat);
        EditEstoqueProduto.Text := IntToStr(FieldByName('ESTOQUE').AsInteger);
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
