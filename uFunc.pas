unit uFunc;

interface
uses
  FireDAC.Comp.Client, System.SysUtils, System.Types, IdHashMessageDigest,
  System.UITypes, System.Classes, System.Variants, Data.DB, FireDAC.Stan.Param,
  Vcl.StdCtrls, Vcl.Forms, Winapi.Windows, Vcl.ExtCtrls, StrUtils, Vcl.Grids,
  DBGrids, Graphics, FireDAC.Stan.Intf, System.Win.ComObj, FireDAC.Stan.Option,FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, Winapi.Messages, Vcl.Dialogs, Vcl.Buttons,  TypInfo, Registry,
  Vcl.Mask, Vcl.DBCtrls, IdBaseComponent, IdMessage, IdComponent, IdTCPConnection,
  IdTCPClient, IdExplicitTLSClientServerBase, IdMessageClient, IdSMTPBase, ImageHlp, Vcl.Controls,  Shellapi,
  IdSMTP, Datasnap.DBClient, Vcl.ComCtrls, Inifiles, DateUtils,
  IdHTTP, IdIOHandler, idIOHandlerSocket, IdIOHandlerStack, IdSSL,
  IdSSLOpenSSL,IdAttachmentFile,IdText;

procedure AbrirForm(aClasseForm: TFormClass; aForm: TForm);
procedure AjustarGrid(Grid: TDBGrid);
procedure Alerta(Mensagem: String);
procedure ZebrarGrid(Sender, DataSet: TObject; Rect: TRect; Column: TColumn; State: TGridDrawState);

function DadoInvalido(Valor: String; Str: String; Sender: TObject; TabSheet: TTabSheet = nil): Boolean;
function EnviarEmail(const AAssunto, ADestino, AAnexo: String; ACorpo: TStrings): Boolean;
function Perguntar(Pergunta: String): Boolean;
function RemoverNumeros(Texto: String): String;
function ValidaCPF(numero : string) : boolean;

implementation

procedure AbrirForm(aClasseForm: TFormClass; aForm: TForm);
begin
  try
    Application.CreateForm(aClasseForm, aForm);
    aForm.ShowModal;
  finally
     FreeAndNil(aForm);
  end;
end;

procedure AjustarGrid(Grid: TDBGrid);
var
  Tamanhos: array of Integer;
  I, Tam, Posicao: Integer;
  DataSet: TDataSet;
begin
  try
    DataSet:= Grid.DataSource.DataSet;

    if DataSet.Active = False then
      Exit;

    if DataSet.State <> dsBrowse then
      Exit;

    Posicao:= DataSet.RecNo;

    if DataSet.RecordCount = 0 then
    begin
      for I := 0 to Grid.Columns.Count - 1 do
        Grid.Columns[I].Width:= 100;
    end
    else
    begin
      SetLength(Tamanhos, Grid.Columns.Count);
      for I := 0 to Grid.Columns.Count - 1 do
        if Grid.Columns[I].Visible then
          Tamanhos[I]:= Grid.Canvas.TextWidth(Grid.Columns[I].Title.Caption)
        else
          Tamanhos[I]:= 0;

      try
         DataSet.DisableControls;
         DataSet.First;
         while not DataSet.Eof do
         begin
           for I := 0 to Grid.Columns.Count - 1 do
           begin
             if Grid.Columns[I].Visible then
             begin
               Tam := Grid.Canvas.TextWidth(Grid.Columns[I].Field.AsString + RemoverNumeros(Grid.Columns[I].Field.EditMask));
               if Tam > Tamanhos[I] then
                 Tamanhos[I]:= Tam;
             end
             else
                Tamanhos[I]:= 0;
           end;
           DataSet.Next;
         end;

         for I := 0 to Grid.Columns.Count - 1 do
           if Grid.Columns[I].Visible then
            begin
              try
                Grid.Columns[I].Width:= (Tamanhos[I] + 10);
              except
              end;
            end;

         DataSet.First;
      finally
          DataSet.RecNo:= Posicao;
          SetLength(Tamanhos, 0);
          Tamanhos:= nil;
          DataSet.EnableControls;
      end;
    end;
  except
  end;
end;

procedure Alerta(Mensagem: String);
begin
  Application.MessageBox(PChar(Mensagem), PWideChar('Teste InfoSistemas'), MB_ICONWARNING);
end;

procedure ZebrarGrid(Sender, DataSet: TObject; Rect: TRect; Column: TColumn; State: TGridDrawState);
begin
  if not (DataSet as TDataSet).Active  then Exit;
  if (DataSet as TDataSet).IsEmpty then Exit;

  // se a c�lula est� selecionada ou foi selecionada no multi-select
  if (gdSelected in State) or ((Sender as TDBGrid).SelectedRows.CurrentRowSelected) then
    begin
      // define a cor de fundo do fundo
      (Sender as TDBGrid).Canvas.Brush.Color := $00CFB78F;
    end
  else  // se a c�lula n�o est� selecionada
    begin
      if not Odd((DataSet as TDataSet).RecNo) then // se for �mpar
        begin
          // define a cor de fundo
          (Sender as TDBGrid).Canvas.Brush.Color := cl3DLight;
        end
      else
        begin
          // define a cor de fundo
          (Sender as TDBGrid).Canvas.Brush.Color := clWindow;
        end;
    end;

  (Sender as TDBGrid).Canvas.FillRect(Rect);
  (Sender as TDBGrid).Canvas.TextOut(Rect.Left + 2,Rect.Top, Column.Field.AsString);
end;

function DadoInvalido(Valor: String; Str: String; Sender: TObject; TabSheet: TTabSheet = nil): Boolean;
begin
  if Trim(Valor) = '' then
  begin
    Alerta(Str);

    if TabSheet <> nil then
      TabSheet.Show;

    if Sender is TDBEdit then
    with Sender as TDBEdit do
    begin
      SetFocus;
      Color:= clSkyBlue;
    end;

    if Sender is TEdit then
    with Sender as TEdit do
    begin
      SetFocus;
      Color:= clSkyBlue;
    end;

    if Sender is TDBMemo then
    with Sender as TDBMemo do
    begin
      SetFocus;
      Color:= clSkyBlue;
    end;

    if Sender is TMemo then
    with Sender as TMemo do
    begin
      SetFocus;
      Color:= clSkyBlue;
    end;

    if Sender is TDBLookupComboBox then
    with Sender as TDBLookupComboBox do
    begin
      SetFocus;
      Color:= clSkyBlue;
    end;

    if Sender is TDBComboBox then
    with Sender as TDBComboBox do
    begin
      SetFocus;
      Color:= clSkyBlue;
    end;

    if Sender is TComboBox then
    with Sender as TComboBox do
    begin
      SetFocus;
      Color:= clSkyBlue;
    end;

    if Sender is TCheckBox then
    with Sender as TCheckBox do
    begin
      SetFocus;
      Color:= clSkyBlue;
    end;

    if Sender is TDBCheckBox then
    with Sender as TDBCheckBox do
    begin
      SetFocus;
      Color:= clSkyBlue;
    end;

    if Sender is TDateTimePicker then
    with Sender as TDateTimePicker do
    begin
      SetFocus;
      Color:= clSkyBlue;
    end;

    if Sender is TMaskEdit then
    with Sender as TMaskEdit do
    begin
      SetFocus;
      Color:= clSkyBlue;
    end;

    Result:= True;
  end
  else
  begin
    if (Sender <> nil) and (IsPublishedProp(Sender,'Color')) then
    SetOrdProp(Sender, 'Color', clWindow);

    result:= false;
  end;
end;

function EnviarEmail(const AAssunto, ADestino, AAnexo: String; ACorpo: TStrings): Boolean;
var
  sFrom : String;
  sHost : String;
  iPort : Integer;
  sUserName : String;
  sPassword : String;

  idMsg : TIdMessage;
  IdText : TIdText;
  idSMTP : TIdSMTP;
  IdSSLIOHandlerSocket : TIdSSLIOHandlerSocketOpenSSL;
begin
  try
    try
      sFrom := 'sistemadelphi16122020@gmail.com';
      sHost := 'smtp.gmail.com';
      iPort := 465;
      sUserName := 'sistemadelphi16122020@gmail.com';
      sPassword := 'teste16122020*';

      //Configura os par�metros necess�rios para SSL
      IdSSLIOHandlerSocket := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
      IdSSLIOHandlerSocket.SSLOptions.Method := sslvSSLv23;
      IdSSLIOHandlerSocket.SSLOptions.Mode  := sslmClient;

      //Vari�vel referente a mensagem
      idMsg := TIdMessage.Create(nil);
      idMsg.CharSet := 'utf-8';
      idMsg.Encoding := meMIME;
      idMsg.From.Name := 'Teste InfoSistemas';
      idMsg.From.Address := sFrom;
      idMsg.Priority := mpNormal;
      idMsg.Subject := AAssunto;

      //Add Destinat�rio(s)
      idMsg.Recipients.Add;
      idMsg.Recipients.EMailAddresses := ADestino;

      //Vari�vel do texto
      idText := TIdText.Create(idMsg.MessageParts);
      idText.Body.Add(ACorpo.Text);
      idText.ContentType := 'text/html; text/plain; charset=iso-8859-1';

      //Preparando o Servidor
      IdSMTP := TIdSMTP.Create(nil);
      IdSMTP.IOHandler := IdSSLIOHandlerSocket;
      IdSMTP.UseTLS := utUseImplicitTLS;
      IdSMTP.AuthType := satDefault;
      IdSMTP.Host := sHost;
      IdSMTP.AuthType := satDefault;
      IdSMTP.Port := iPort;
      IdSMTP.Username := sUserName;
      IdSMTP.Password := sPassword;

      //Conecta e Autentica
      IdSMTP.Connect;
      IdSMTP.Authenticate;

      if AAnexo <> EmptyStr then
        if FileExists(AAnexo) then
          TIdAttachmentFile.Create(idMsg.MessageParts, AAnexo);

      //Se a conex�o foi bem sucedida, envia a mensagem
      if IdSMTP.Connected then
      begin
        try
          IdSMTP.Send(idMsg);
        except on E:Exception do
          begin
            Alerta('Falha ao enviar: ' + E.Message);
          end;
        end;
      end;

      //Depois de tudo pronto, desconecta do servidor SMTP
      if IdSMTP.Connected then
        IdSMTP.Disconnect;

      Result := True;
    finally
      UnLoadOpenSSLLibrary;
      FreeAndNil(idMsg);
      FreeAndNil(IdSSLIOHandlerSocket);
      FreeAndNil(idSMTP);
    end;
  except on e:Exception do
    begin
      Result := False;
    end;
  end;
end;

function Perguntar(Pergunta: String): Boolean;
begin
  if Application.MessageBox(PChar(Pergunta), 'Teste InfoSistemas', MB_ICONQUESTION + MB_YESNO + MB_DEFBUTTON2) = idYes then
    Result:= true
  else
    Result:= false;
end;

function RemoverNumeros(Texto: String): String;
var
  Resultado: String;
  i: integer;
  Caracteres: TSysCharSet;
begin
  Resultado := '';
  Caracteres := ['0'..'9'];

  for i := 1 to Length(Texto) do
    if not CharInSet(Texto[i], Caracteres) then
      Resultado := Resultado + Texto[i];

  Result := Resultado;
end;

function ValidaCPF(numero : string) : boolean;
var
  i : integer;
  Want : char;
  Wvalid : boolean;
  Wdigit1,Wdigit2 : integer;
begin
  if numero.IsEmpty then
  begin
    result:= false;
    exit;
  end;
  Wvalid:= False;
  Wdigit1:= 0;
  Wdigit2:= 0;
  Want:= numero[1];//variavel para testar se o cpf � repetido como 111.111.111-11
  Delete(numero,ansipos('.',numero),1); //retira as mascaras se houver
  Delete(numero,ansipos('.',numero),1);
  Delete(numero,ansipos('-',numero),1);

  for i:=1 to length(numero) do
  begin
    if numero[i] <> Want then
    begin
      Wvalid:=true;
      break;
    end;
  end;
  if not Wvalid then
  begin
    result:=false;
    exit;
  end;

  for i:=1 to 9 do
  begin
    wdigit1:=Wdigit1+(strtoint(numero[10-i])*(I+1));
  end;
  Wdigit1:= ((11 - (Wdigit1 mod 11))mod 11) mod 10;

  if IntToStr(Wdigit1) <> numero[10] then
  begin
    result:=false;
    exit;
  end;

  for i:=1 to 10 do
  begin
    wdigit2:=Wdigit2+(strtoint(numero[11-i])*(I+1));
  end;
  Wdigit2:= ((11 - (Wdigit2 mod 11))mod 11) mod 10;

  if IntToStr(Wdigit2) <> numero[11] then
  begin
    result:=false;
    exit;
  end;

  result:=true;
end;

end.
