unit uCadCliente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls,
  Vcl.Mask, Vcl.DBCtrls, FireDAC.Comp.Client, System.Types, IdHashMessageDigest,
  System.UITypes,Data.DB, FireDAC.Stan.Param,
  StrUtils, Vcl.Grids, System.JSON, idHTTP, IdSSLOpenSSL, Data.DBXJSON, DBXJSONReflect,
  DBGrids,  FireDAC.Stan.Intf, System.Win.ComObj, FireDAC.Stan.Option,FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet,  TypInfo, Registry,
  IdBaseComponent, IdMessage, IdComponent, IdTCPConnection,
  IdTCPClient, IdExplicitTLSClientServerBase, IdMessageClient, IdSMTPBase, ImageHlp, Shellapi,
  IdSMTP, Datasnap.DBClient, Vcl.ComCtrls, Inifiles, DateUtils;

type
  TfrmCadCliente = class(TForm)
    pnlDados: TPanel;
    pnlBotao: TPanel;
    btnGravar: TBitBtn;
    btnCancelar: TBitBtn;
    Label1: TLabel;
    dbeNome: TDBEdit;
    Label2: TLabel;
    dbeIdentidade: TDBEdit;
    Label3: TLabel;
    dbeCPF: TDBEdit;
    Label4: TLabel;
    dbeDDD: TDBEdit;
    Label5: TLabel;
    dbeTelefone: TDBEdit;
    Label6: TLabel;
    dbeEmail: TDBEdit;
    grpEndereco: TGroupBox;
    Label7: TLabel;
    dbeCEP: TDBEdit;
    Label8: TLabel;
    dbeLogradouro: TDBEdit;
    Label9: TLabel;
    dbeNumero: TDBEdit;
    Label10: TLabel;
    dbeComplemento: TDBEdit;
    Label11: TLabel;
    dbeBairro: TDBEdit;
    Label12: TLabel;
    dbeCidade: TDBEdit;
    Label13: TLabel;
    dbeEstado: TDBEdit;
    Label14: TLabel;
    dbePais: TDBEdit;
    btnBuscarCEP: TBitBtn;
    procedure btnGravarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnBuscarCEPClick(Sender: TObject);
    procedure dbeCEPKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCadCliente: TfrmCadCliente;

implementation

{$R *.dfm}

uses uDM, uFunc;

procedure TfrmCadCliente.btnBuscarCEPClick(Sender: TObject);
var
  HTTP: TIdHTTP;
  IDSSLHandler: TIdSSLIOHandlerSocketOpenSSL;
  Response: TStringStream;
  JS : TJSONObject;
begin
  if not Length(DM.cdsClienteCep.AsString)=8 then
  begin
    Alerta('CEP INVALIDO');
    Exit;
  end;

  //inicio json

  HTTP := TIdHTTP.Create;
  IDSSLHandler := TIdSSLIOHandlerSocketOpenSSL.Create;
  HTTP.IOHandler := IDSSLHandler;
  Response := TStringStream.Create('');

  HTTP.Get('http://viacep.com.br/ws/' + DM.cdsClienteCep.AsString + '/json', Response);
  if (HTTP.ResponseCode = 200) and not (UTF8ToString(Response.DataString) = '{'#$A'  "erro": true'#$A'}') then
    begin
      JS := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(UTF8ToString(Response.DataString)), 0) as TJSONObject;

      DM.cdsClienteCidade.AsString := JS.Get('localidade').JsonValue.Value;
      DM.cdsClienteEstado.AsString := JS.Get('uf').JsonValue.Value;

      DM.cdsClienteLogradouro.AsString  := JS.Get('logradouro').JsonValue.Value;

      dbeLogradouro.Enabled := DM.cdsClienteLogradouro.AsString = '';
      if dbeLogradouro.Enabled then
        dbeLogradouro.Color := clWindow
      else
        dbeLogradouro.Color := clBtnFace;

      DM.cdsClienteBairro.AsString := JS.Get('bairro').JsonValue.Value;

      dbeBairro.Enabled := DM.cdsClienteBairro.AsString = '';
      if dbeBairro.Enabled then
        dbeBairro.Color := clWindow
      else
        dbeBairro.Color := clBtnFace;

      DM.cdsClienteComplemento.AsString := JS.Get('complemento').JsonValue.Value;

      dbeComplemento.Enabled := DM.cdsClienteComplemento.AsString = '';
      if dbeComplemento.Enabled then
        dbeComplemento.Color := clWindow
      else
        dbeComplemento.Color := clBtnFace;
    end
  else
    raise Exception.Create('O cep informado n�o foi localizado');

  //termino json
end;

procedure TfrmCadCliente.btnCancelarClick(Sender: TObject);
begin
  DM.cdsCliente.Cancel;
  Close;
end;

procedure TfrmCadCliente.btnGravarClick(Sender: TObject);
begin
  if DadoInvalido(dbeNome.Text, 'Informe o nome', dbeNome, nil) or
     DadoInvalido(dbeIdentidade.Text, 'Informe a identidade', dbeIdentidade, nil) or
     DadoInvalido(dbeEmail.Text, 'Informe o e-mail', dbeEmail, nil) or
     DadoInvalido(dbeLogradouro.Text, 'Informe o logradouro', dbeLogradouro, nil) or
     DadoInvalido(dbeBairro.Text, 'Informe o bairro', dbeBairro, nil) or
     DadoInvalido(dbeCidade.Text, 'Informe a cidade', dbeCidade, nil) or
     DadoInvalido(dbeEstado.Text, 'Informe o estado', dbeEstado, nil) or
     DadoInvalido(dbePais.Text, 'Informe o pa�s', dbePais, nil) then
  Exit;

  if Length(dbeDDD.Field.Text)<>2 then
  begin
    Alerta('DDD deve conter 2 caracteres');
    dbeDDD.SetFocus;
    Exit;
  end;

  if not Length(dbeTelefone.Field.Text)in[8,9] then
  begin
    Alerta('Telefone deve conter 8 ou 9 caracteres');
    dbeTelefone.SetFocus;
    Exit;
  end;

  if Length(dbeCep.Field.Text) <> 8 then
  begin
    Alerta('CEP deve conter 8 caracteres');
    dbeCep.SetFocus;
    Exit;
  end;

  if not(ValidaCPF(dbeCpf.Field.Text)) then
  begin
    Alerta('CPF invalido');
    dbeCpf.SetFocus;
    Exit;
  end;

  DM.cdsCliente.Post;
  Close;
end;

procedure TfrmCadCliente.dbeCEPKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
    btnBuscarCEP.Click;
end;

end.
