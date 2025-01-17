unit uDM;

interface

uses
  System.SysUtils, System.Classes, Data.DB, Datasnap.DBClient;

type
  TDM = class(TDataModule)
    dsrCliente: TDataSource;
    cdsCliente: TClientDataSet;
    cdsClienteNome: TStringField;
    cdsClienteIdentidade: TStringField;
    cdsClienteCPF: TStringField;
    cdsClienteTelefone: TStringField;
    cdsClienteEmail: TStringField;
    cdsClienteCEP: TStringField;
    cdsClienteLogradouro: TStringField;
    cdsClienteNumero: TStringField;
    cdsClienteComplemento: TStringField;
    cdsClienteBairro: TStringField;
    cdsClienteCidade: TStringField;
    cdsClienteEstado: TStringField;
    cdsClientePais: TStringField;
    cdsClienteDDD: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DM: TDM;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TDM.DataModuleCreate(Sender: TObject);
begin
  cdsCliente.CreateDataSet;
  cdsCliente.Open;
end;

procedure TDM.DataModuleDestroy(Sender: TObject);
begin
  cdsCliente.Close;
end;

end.
