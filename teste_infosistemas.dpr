program teste_infosistemas;

uses
  Vcl.Forms,
  uPrincipal in 'uPrincipal.pas' {frmPrincipal},
  uFunc in 'uFunc.pas',
  uCadCliente in 'uCadCliente.pas' {frmCadCliente},
  uDM in 'uDM.pas' {DM: TDataModule},
  uListaCliente in 'uListaCliente.pas' {frmListaCliente};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.CreateForm(TDM, DM);
  Application.Run;
end.
