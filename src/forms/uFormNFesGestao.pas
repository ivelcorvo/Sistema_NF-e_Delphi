unit uFormNFesGestao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFormTemplateGestao, Data.DB, Vcl.Grids,
  Vcl.DBGrids, Vcl.StdCtrls, Vcl.Imaging.pngimage, Vcl.ExtCtrls, Vcl.ComCtrls,
  ACBrBase, ACBrDFe, ACBrNFe, System.IOUtils;

type
  TFormNFesGestao = class(TFormTemplateGestao)
    ImageTransmitir: TImage;
    ImageGerarXML: TImage;
    ACBrNFe: TACBrNFe;
    procedure ImageAdicinarClick(Sender: TObject);
    procedure ImageEditarClick(Sender: TObject);
    procedure ImageExcluirClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    function PermiteAcaoPorStatus():Boolean;
    function PermiteAcaoPorStatusParaXML():Boolean;
    procedure ImageGerarXMLClick(Sender: TObject);
  private
    procedure PreencherNFeDoBanco(IDNota: Integer);
    procedure CarregarNFes;
  public

  end;

var
  FormNFesGestao: TFormNFesGestao;

implementation

{$R *.dfm}

uses uDM, uFormNFes_NOVA, uFormNFes_EDITAR, uFormNFes_EXCLUIR,
  math, TypInfo, DateUtils, synacode, ACBrNFe.Classes,
  pcnConversaoNFe, pcnConversao, ACBrDFeConfiguracoes, pcnAuxiliar, ACBrDFeSSL, pcnNFeRTXT,
  FileCtrl, uUtils;


function TFormNFesGestao.PermiteAcaoPorStatus:Boolean;
var
  status: string;
begin
  Result := True;
  with DM.FDQueryNotasFiscaisGET do
  begin
    if (Active) and (RecordCount>0) and (not IsEmpty) then
    begin
      status := FieldByName('STATUS').AsString;
      if not(status='RASCUNHO') or not(status='REJEITADA') then
      begin
        ShowMessage('NF-e em status: '+status+'. Não é possível gerar XML.');
        Result := False;
      end;
    end;
  end;
end;

function TFormNFesGestao.PermiteAcaoPorStatusParaXML: Boolean;
var
  status: string;
  StatusPermitidos: array of string;
  i: Integer;
  permitido: Boolean;
begin
  Result := False;
  StatusPermitidos := ['AGUARDANDO ENVIO', 'AUTORIZADA', 'CONTINGÊNCIA'];

  with DM.FDQueryNotasFiscaisGET do
  begin
    if Active and (RecordCount > 0) and (not IsEmpty) then
    begin
      status := FieldByName('STATUS').AsString;
      permitido := False;
      for i := 0 to High(StatusPermitidos) do
      begin
        if status = StatusPermitidos[i] then
        begin
          permitido := True;
          Break;
        end;
      end;

      if permitido then
        Result := True
      else
        ShowMessage('NF-e em status: ' + status + '. Não é possível gerar XML.');
    end;
  end;
end;

procedure TFormNFesGestao.CarregarNFes;
begin
  try
    with DM.FDQueryNotasFiscaisGET do
    begin
      Close;
      SQL.Text := 'SELECT NF.ID, NF.NUMERO, NF.SERIE, NF.DATA_EMISSAO, NF.CFOP_PADRAO, NF.VALOR_TOTAL, NF.STATUS, C.NOME AS CLIENTE '+
      'FROM NOTAS_FISCAIS NF '+
      'JOIN CLIENTES C ON C.ID = NF.ID_CLIENTE '+
      'ORDER BY NF.DATA_EMISSAO DESC';
      Open;
    end;
    DataSource.DataSet := DM.FDQueryNotasFiscaisGET;
    DBGrid.DataSource  := DataSource;
  except
    on E:Exception do
      ShowMessage('Houve um erro... Erro: '+E.Message);
  end;
end;

procedure TFormNFesGestao.PreencherNFeDoBanco(IDNota: Integer);
begin
  try

    ACBrNFe.NotasFiscais.Clear;


    // #### CARREGA OS DADOS DA NOTA PRINCIPAL ####
    with DM.FDQueryNotaFiscalGET do
    begin
      Close;
      SQL.Text := 'SELECT * FROM NOTAS_FISCAIS WHERE ID = :ID';
      ParamByName('ID').AsInteger := IDNota;
      Open;
      if IsEmpty then
        Exit;
    end;

    // #### CARREGA OS DADOS DO CLIENTE (Destinatário) ####
    with DM.FDQueryClienteGET do
    begin
      Close;
      SQL.Text := 'SELECT * FROM CLIENTES WHERE ID = :ID';
      ParamByName('ID').AsInteger := DM.FDQueryNotaFiscalGET.FieldByName('ID_CLIENTE').AsInteger;
      Open;
    end;

    with ACBrNFe.NotasFiscais.Add.NFe do
    begin
      // #### Identificação da NFe (Ide) ####
      Ide.cNF     := DM.FDQueryNotaFiscalGET.FieldByName('NUMERO').AsInteger;
      Ide.natOp   := DM.FDQueryNotaFiscalGET.FieldByName('NATUREZA_OPERACAO').AsString;
      Ide.indPag  := ipVista; // Pagamento à vista (simplificado)
      Ide.modelo  := 55;
      Ide.serie   := DM.FDQueryNotaFiscalGET.FieldByName('SERIE').AsInteger;
      Ide.nNF     := DM.FDQueryNotaFiscalGET.FieldByName('NUMERO').AsInteger;
      Ide.dEmi    := Date;
      Ide.dSaiEnt := Date;
      Ide.tpNF    := tnSaida;
      Ide.tpEmis  := teNormal; // Emissão Normal (Simplificado)
      Ide.tpAmb   := taHomologacao; // Sempre Homologação para testes
      Ide.verProc := '1.0.0.0';

      // #### Emitente (Emit) ####
      // Emit.CNPJCPF := ACBrNFe1.Configuracoes.Emitente.CNPJCPF;
      // Emit.IE := ACBrNFe1.Configuracoes.Emitente.IE;

      Emit.CNPJCPF           := '12.345.678/0001-95'; // CNPJ de teste válido para homologação
      Emit.IE                := '123456789';           // IE fictícia, pode ser qualquer número
      Emit.EnderEmit.xLgr    := 'Rua Exemplo';
      Emit.EnderEmit.nro     := '100';
      Emit.EnderEmit.xBairro := 'Centro';
      Emit.EnderEmit.cMun    := 3550308;  // IBGE
      Emit.EnderEmit.xMun    := 'São Paulo';
      Emit.EnderEmit.UF      := 'SP';
      Emit.EnderEmit.CEP     := 01001000;
      Emit.EnderEmit.cPais   := 1058;
      Emit.EnderEmit.xPais   := 'BRASIL';

      // #### Destinatário (Dest) ####
      if not DM.FDQueryClienteGET.IsEmpty then
      begin
        Dest.CNPJCPF           := DM.FDQueryClienteGET.FieldByName('CPF_CNPJ').AsString;
        Dest.IE                := DM.FDQueryClienteGET.FieldByName('IE').AsString;
        Dest.xNome             := DM.FDQueryClienteGET.FieldByName('NOME').AsString;
        Dest.EnderDest.Fone    := DM.FDQueryClienteGET.FieldByName('TELEFONE').AsString;
        Dest.EnderDest.CEP     := StrToInt(LimparDocumento(DM.FDQueryClienteGET.FieldByName('CEP').AsString));
        Dest.EnderDest.xLgr    := DM.FDQueryClienteGET.FieldByName('ENDERECO').AsString;
        Dest.EnderDest.nro     := DM.FDQueryClienteGET.FieldByName('NUMERO').AsString;
        Dest.EnderDest.xBairro := DM.FDQueryClienteGET.FieldByName('BAIRRO').AsString;
        // Dest.EnderDest.cMun := // Cód. IBGE da Cidade (você precisa obter este valor)
        Dest.EnderDest.xMun    := DM.FDQueryClienteGET.FieldByName('CIDADE').AsString;
        Dest.EnderDest.UF      := DM.FDQueryClienteGET.FieldByName('UF').AsString;
        Dest.EnderDest.cPais   := 1058;
        Dest.EnderDest.xPais   := 'BRASIL';
      end;

      // #### Itens da NFe (Det) ####
      with DM.FDQueryNotasItensGET do
      begin
        Close;
        SQL.Text := 'SELECT I.ID, I.ID_NOTA, I.ID_PRODUTO, I.QUANTIDADE, I.VALOR_UNITARIO, I.VALOR_TOTAL, P.NOME as PRODUTO, P.NCM, P.CFOP, P.UNIDADE '+
                    'FROM NOTAS_ITENS I '+
                    'JOIN produtos P ON P.ID = I.ID_PRODUTO '+
                    'WHERE I.ID_NOTA = :ID_NOTA';
        ParamByName('ID_NOTA').AsInteger := IDNota;
        Open;

        if not IsEmpty then
        begin

          while not Eof do
          begin
            with Det.Add do
            begin
              Prod.nItem  := DM.FDQueryNotasItensGEt.RecNo; // Número sequencial
              Prod.cProd  := DM.FDQueryNotasItensGEt.FieldByName('ID').AsString;
              Prod.xProd  := DM.FDQueryNotasItensGEt.FieldByName('PRODUTO').AsString;
              Prod.NCM    := DM.FDQueryNotasItensGEt.FieldByName('NCM').AsString;
              Prod.CFOP   := DM.FDQueryNotasItensGEt.FieldByName('CFOP').AsString;
              Prod.uCom   := DM.FDQueryNotasItensGEt.FieldByName('UNIDADE').AsString;
              Prod.qCom   := DM.FDQueryNotasItensGEt.FieldByName('QUANTIDADE').AsFloat;
              Prod.vUnCom := DM.FDQueryNotasItensGEt.FieldByName('VALOR_UNITARIO').AsFloat;
              Prod.vProd  := DM.FDQueryNotasItensGEt.FieldByName('VALOR_TOTAL').AsFloat;

              // ... (Preenchimento de unidades tributáveis, frete, seguro, etc.)

              // Imposto (Mínimo - ICMS 00 - Tributado Integralmente)
              with Imposto do
              begin
                // vTotTrib deve ser calculado
                with ICMS do
                begin
                  CST := cst00;
                  ICMS.orig := oeNacional;
                  ICMS.modBC := dbiValorOperacao;
                  ICMS.vBC := Prod.vProd;
                  ICMS.pICMS := 18; // Alíquota fixa para exemplo
                  ICMS.vICMS := Prod.vProd * (18 / 100);
                end;
                // IPI, PIS, COFINS (Simplificados)
                // ...
              end;
            end;

            Next;
          end;
        end;

        // #### 5. Totais (Total) - Os totais serão calculados automaticamente, mas devem ser espelhados ####
        // ACBrNFe1.NotasFiscais.Items[0].CalcularTotais; // Chame o cálculo automático se preferir
        Total.ICMSTot.vProd := DM.FDQueryNotaFiscalGET.FieldByName('VALOR_TOTAL').AsFloat;
        Total.ICMSTot.vNF   := DM.FDQueryNotaFiscalGET.FieldByName('VALOR_TOTAL').AsFloat;
        // ... (demais totais)

        // #### 6. Transporte, Cobrança, Informações Adicionais (Simplificado) ####
        Transp.modFrete := mfSemFrete; // Sem frete para simplificar

        // Cobrança
        Cobr.Fat.vOrig := Total.ICMSTot.vNF;
        Cobr.Fat.vLiq := Total.ICMSTot.vNF;
        // ... (duplicatas, se houver)

      end;
    end;

  except
    on E:Exception do
      ShowMessage('Houve um erro... Erro: '+E.Message);
  end;
end;

procedure TFormNFesGestao.ImageAdicinarClick(Sender: TObject);
var
  form:TFormNFes_NOVA;
begin
  inherited;
  form := nil;
  try
    form          := TFormNFes_NOVA.Create(Self);
    form.Position := poScreenCenter;

    form.onExibir;

    if form.ShowModal=mrok then
      CarregarNFes;
  finally
    form.Free;
  end;
end;

procedure TFormNFesGestao.ImageEditarClick(Sender: TObject);
var
  form: TFormNFes_EDITAR;
  IDNota: Integer;
begin
  inherited;

  form := nil;

  try

    if (not PermiteAcaoPorStatus) then
      Exit;

    with DM.FDQueryNotasFiscaisGET do
    begin
      if (not Active) or (RecordCount=0) or (IsEmpty) then
      begin
        ShowMessage('Nenhuma nota selecionada!');
        Exit;
      end
      else
        IDNota := FieldByName('ID').AsInteger;
    end;

    form          := TFormNFes_EDITAR.Create(Self);
    form.Position := poScreenCenter;
    form.IDNota   := IDNota;

    form.onExibir;

    if form.ModalResult = mrCancel then
      exit;

    if form.ShowModal=mrOk then
      CarregarNFes;
  finally
    form.Free;
  end;

end;

procedure TFormNFesGestao.ImageExcluirClick(Sender: TObject);
var
  form: TFormNFes_EXCLUIR;
  IDNota: Integer;
  NumNota: Integer;
begin
  inherited;
  form := nil;

  if (not PermiteAcaoPorStatus) then
    Exit;

  try
    with DM.FDQueryNotasFiscaisGET do
    begin
      if (not Active) or (RecordCount=0) or (IsEmpty) then
      begin
        ShowMessage('Nenhuma NF-e selecionada!');
        Exit;
      end
      else
      begin
        IDNota  := FieldByName('ID').AsInteger;
        NumNota := FieldByName('NUMERO').AsInteger;
      end;
    end;

    form                       := TFormNFes_EXCLUIR.Create(Self);
    form.Position              := poScreenCenter;
    form.IDNota                := IDNota;
    form.LabelDadosNfe.Caption := 'NF-e número: '+IntToStr(NumNota);

    if form.ShowModal=mrOk then
      CarregarNFes;

  finally
    form.Free;
  end;
end;

procedure TFormNFesGestao.ImageGerarXMLClick(Sender: TObject);
var
  IDNota: Integer;
  PastaSalvar, NomeArquivo, ChaveAcesso: string;
begin
  inherited;

  try
    if (not PermiteAcaoPorStatusParaXML) then
      Exit;

    with DM.FDQueryNotasFiscaisGET do
    begin
      if (not Active) or (RecordCount = 0) or (IsEmpty) then
      begin
        ShowMessage('Nenhuma nota selecionada!');
        Exit;
      end
      else
        IDNota := FieldByName('ID').AsInteger;
    end;

    // Preenche os dados da NFe
    PreencherNFeDoBanco(IDNota);

    if ACBrNFe.NotasFiscais.Count = 0 then
    begin
      ShowMessage('Nenhuma NFe foi carregada para gerar o XML.');
      Exit;
    end;

    // Cria pasta para XML, se não existir
    PastaSalvar := TPath.Combine(ExtractFilePath(ParamStr(0)), 'NFeXML');
    if not DirectoryExists(PastaSalvar) then
      ForceDirectories(PastaSalvar);

    // Obtém chave de acesso
    ChaveAcesso := StringReplace(
      ACBrNFe.NotasFiscais.Items[0].NFe.infNFe.id,'NFe', '', []);

    // Monta nome do arquivo
    NomeArquivo := TPath.Combine(PastaSalvar, 'NFe_' + ChaveAcesso + '.xml');

    // Assina e grava o XML
    ACBrNFe.NotasFiscais.Assinar;
    ACBrNFe.NotasFiscais.Items[0].GravarXML(NomeArquivo);

    // Atualiza banco de dados
    with DM.FDQueryNotasFiscaisRequest do
    begin
      Close;
      SQL.Text := 'UPDATE NOTAS_FISCAIS SET ' +
                  'CHAVE_ACESSO = :CHAVE_ACESSO, ' +
                  'CAMINHO_XML = :CAMINHO_XML, ' +
                  'STATUS = :STATUS ' +
                  'WHERE ID = :ID';

      ParamByName('CHAVE_ACESSO').AsString := ChaveAcesso;
      ParamByName('CAMINHO_XML').AsString  := NomeArquivo;
      ParamByName('STATUS').AsString       := 'ASSINADA';
      ParamByName('ID').AsInteger          := IDNota;

      ExecSQL;
    end;

    ShowMessage('XML da NF-e nº ' +
      IntToStr(DM.FDQueryNotaFiscalGET.FieldByName('NUMERO').AsInteger) +
      ' gerado e assinado com sucesso!');

    CarregarNFes;

  except
    on E: Exception do
      ShowMessage('Erro durante a geração do XML: ' + E.Message);
  end;
end;

procedure TFormNFesGestao.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  if DM.FDQueryNotasFiscaisGET.Active then
    DM.FDQueryNotasFiscaisGET.Close;
end;

procedure TFormNFesGestao.FormShow(Sender: TObject);
begin
  inherited;
  CarregarNFes;
end;

end.
