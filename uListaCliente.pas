unit uListaCliente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons, System.MaskUtils,
  dbWeb, ComObj, XMLDoc, XMLIntf;

type
  TfrmListaCliente = class(TForm)
    pnlBotao: TPanel;
    dbgListaCliente: TDBGrid;
    bntNovo: TBitBtn;
    btnEditar: TBitBtn;
    btnDeletar: TBitBtn;
    BitBtn3: TBitBtn;
    pnelFiltro: TPanel;
    Label1: TLabel;
    edtFiltro: TEdit;
    btnEmail: TBitBtn;
    procedure dbgListaClienteDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure BitBtn3Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure bntNovoClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure btnDeletarClick(Sender: TObject);
    procedure edtFiltroChange(Sender: TObject);
    procedure btnEmailClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmListaCliente: TfrmListaCliente;

implementation

{$R *.dfm}

uses uCadCliente, uDM, uFunc;

procedure TfrmListaCliente.BitBtn3Click(Sender: TObject);
begin
  Close;
end;

procedure TfrmListaCliente.bntNovoClick(Sender: TObject);
begin
  DM.cdsCliente.Append;
  AbrirForm(TfrmCadCliente, frmCadCliente);
  btnEmail.Click;
  AjustarGrid(dbgListaCliente);
end;

procedure TfrmListaCliente.btnDeletarClick(Sender: TObject);
begin
  if Perguntar('Confirma a exclus�o?') then
  begin
    DM.cdsCliente.Delete;
    AjustarGrid(dbgListaCliente);
  end;
end;

procedure TfrmListaCliente.btnEditarClick(Sender: TObject);
begin
  DM.cdsCliente.Edit;
  AbrirForm(TfrmCadCliente, frmCadCliente);
  btnEmail.Click;
  AjustarGrid(dbgListaCliente);
end;

procedure TfrmListaCliente.btnEmailClick(Sender: TObject);
var
  sl,sEmail: TStringList;
  dp: TDataSetTableProducer;
  Diretorio : string;
begin
  if DM.cdsCliente.RecordCount = 0 then
  begin
    Alerta('Efetue um cadastro de cliente');
    exit;
  end;

  if not Perguntar('Confirma o disparo de email?') then
  Exit;

  Diretorio := ExtractFileDir(ParamStr(0))+'\Cliente.xml';

  sl := TStringList.Create;
  try
    dp := TDataSetTableProducer.Create(nil);
    try
      DM.cdsCliente.First;
      dp.DataSet := DM.cdsCliente;
      dp.TableAttributes.Border := 1;
      sl.Text := dp.Content;
      if FileExists(Diretorio) then
        DeleteFile(Diretorio);
      sl.SaveToFile(Diretorio);
      Alerta('Arquivo XML salvo no diretorio: '+Diretorio);
    finally
      dp.free;
    end;
  finally
    sl.free;
  end;

  //Montando o HTML com o conte�do do e-mail
  sEmail := TStringList.Create;
  sEmail.Append('<html><head><meta content=''text/html; charset=iso-8859-1'' http-equiv=''Content-Type'' />');
  sEmail.Append('<title>EMAIL AUTOMATICO - Cliente '+DM.cdsClienteNome.AsString+'</title> </head>');
  sEmail.Append('<body bgcolor=''#FFFFFF''>');
  sEmail.Append('<p><b> Nome : </b>' + DM.cdsClienteNome.AsString);
  sEmail.Append('<p><b> CPF : </b>' + FormatMaskText('999.999.999-99;0;_', DM.cdsClienteCpf.AsString));
  sEmail.Append('<p><b> Identidade : </b>' + DM.cdsClienteIdentidade.AsString);
  sEmail.Append('<p><b> DDD : </b>' + DM.cdsClienteDDD.AsString);
  sEmail.Append('<p><b> Telefone : </b>' + FormatMaskText('99999-9999;0;_', DM.cdsClienteTelefone.AsString));
  sEmail.Append('<p><b> E-mail : </b>' + DM.cdsClienteEmail.AsString);
  sEmail.Append('<p><b> CEP : </b>' + FormatMaskText('99.999-999;0;_', DM.cdsClienteCep.AsString));
  sEmail.Append('<p><b> Logradouro : </b>' + DM.cdsClienteLogradouro.AsString);
  sEmail.Append('<p><b> N�mero : </b>' + DM.cdsClienteNumero.AsString);
  sEmail.Append('<p><b> Complemento : </b>' + DM.cdsClienteComplemento.AsString);
  sEmail.Append('<p><b> Bairro : </b>' + DM.cdsClienteBairro.AsString);
  sEmail.Append('<p><b> Cidade : </b>' + DM.cdsClienteCidade.AsString);
  sEmail.Append('<p><b> Estado : </b>' + DM.cdsClienteEstado.AsString);
  sEmail.Append('<p><b> Pa�s : </b>' + DM.cdsClientePais.AsString);
  sEmail.Append('</body></html>');

  EnviarEmail(
    'Cadastro do cliente '+DM.cdsClienteNome.AsString,
    DM.cdsClienteEmail.AsString,
    Diretorio,
    sEmail);
end;

procedure TfrmListaCliente.dbgListaClienteDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  ZebrarGrid(Sender,(Sender as TDBGrid).DataSource.DataSet,Rect,Column,State);
end;

procedure TfrmListaCliente.FormShow(Sender: TObject);
begin
  AjustarGrid(dbgListaCliente);
end;

procedure TfrmListaCliente.edtFiltroChange(Sender: TObject);
begin
  DM.cdsCliente.Filtered := False;
  DM.cdsCliente.Filter   := 'Nome like '+QuotedStr(edtFiltro.Text+'%');
  DM.cdsCliente.Filtered := edtFiltro.Text <> '';
end;

end.
