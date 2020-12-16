unit uPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.ExtCtrls, Vcl.Menus,
  Vcl.Imaging.pngimage;

type
  TfrmPrincipal = class(TForm)
    Menu: TMainMenu;
    Cadastro1: TMenuItem;
    Sair1: TMenuItem;
    Timer: TTimer;
    Status: TStatusBar;
    Cliente1: TMenuItem;
    Image1: TImage;
    procedure TimerTimer(Sender: TObject);
    procedure Sair1Click(Sender: TObject);
    procedure Cliente1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.dfm}

uses uFunc, uListaCliente;

procedure TfrmPrincipal.Cliente1Click(Sender: TObject);
begin
  AbrirForm(TfrmListaCliente, frmListaCliente);
end;

procedure TfrmPrincipal.Sair1Click(Sender: TObject);
begin
  if Perguntar('Deseja sair do sistema?') then
    Application.Terminate;
end;

procedure TfrmPrincipal.TimerTimer(Sender: TObject);
begin
  Status.Panels[0].Text := DateTimeToStr(Now);
end;

end.
