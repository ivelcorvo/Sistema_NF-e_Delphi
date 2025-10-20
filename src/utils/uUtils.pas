unit uUtils;

interface

uses
  System.Classes, SysUtils;

function ListaUFs: TStringList;

function LimparDocumento(const Valor: string): String;

function TipoPessoaCharParaDB(const Indice: Integer): Char;

function TipoPessoaStringParaDB(const C: String): String;

procedure ApenasNumerosPreco(var Key: Char);

procedure ApenasNumeros(var Key: Char);

function FormatPreco(const Valor: Double): string;

implementation

function ListaUFs: TStringList;
begin

  Result := TStringList.Create;

  Result.Add('AC');
  Result.Add('AL');
  Result.Add('AP');
  Result.Add('AM');
  Result.Add('BA');
  Result.Add('CE');
  Result.Add('DF');
  Result.Add('ES');
  Result.Add('GO');
  Result.Add('MA');
  Result.Add('MT');
  Result.Add('MS');
  Result.Add('MG');
  Result.Add('PA');
  Result.Add('PB');
  Result.Add('PR');
  Result.Add('PE');
  Result.Add('PI');
  Result.Add('RJ');
  Result.Add('RN');
  Result.Add('RO');
  Result.Add('RR');
  Result.Add('RS');
  Result.Add('SC');
  Result.Add('SP');
  Result.Add('SE');
  Result.Add('TO');

end;

function LimparDocumento(const Valor: string): String;
const
  CaracteresRemover = ['.','-','/',' '];
var
  C:Char;
begin
  Result := '';
  for C in Valor do
    if not CharInSet(C, CaracteresRemover) then // if not (C in CaracteresRemover) then
      Result := Result + C;
end;

function TipoPessoaCharParaDB(const Indice: Integer): Char;
begin
  case Indice of
    0: Result := 'F';
    1: Result := 'J';
    else
      Result := #0;
  end;
end;

function TipoPessoaStringParaDB(const C: String): String;
begin
  if C <> '' then
  begin
    case C[1] of
      'J': Result := 'Pessoa Jurídica';
      'F': Result := 'Pessoa Física';
    else
      Result := '';
    end;
  end
    else
      Result := '';
end;

procedure ApenasNumeros(var Key: Char);
begin
  if not (Key in ['0'..'9', #8]) then
    Key := #0;
end;

procedure ApenasNumerosPreco(var Key: Char);
begin
  if not (Key in ['0'..'9', ',', #8]) then
    Key := #0;
end;

function FormatPreco(const Valor: Double): string;
begin
  Result := FormatFloat('0.00', Valor);
end;

end.

