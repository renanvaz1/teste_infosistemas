object frmListaCliente: TfrmListaCliente
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Lista de Clientes'
  ClientHeight = 571
  ClientWidth = 794
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnlBotao: TPanel
    Left = 0
    Top = 530
    Width = 794
    Height = 41
    Align = alBottom
    TabOrder = 0
    ExplicitLeft = 120
    ExplicitTop = 136
    ExplicitWidth = 185
    object bntNovo: TBitBtn
      Left = 1
      Top = 1
      Width = 75
      Height = 39
      Align = alLeft
      Caption = 'Novo'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      OnClick = bntNovoClick
      ExplicitLeft = 0
      ExplicitTop = -4
    end
    object btnEditar: TBitBtn
      Left = 76
      Top = 1
      Width = 75
      Height = 39
      Align = alLeft
      Caption = 'Editar'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      OnClick = btnEditarClick
      ExplicitLeft = 185
      ExplicitTop = -4
    end
    object btnDeletar: TBitBtn
      Left = 151
      Top = 1
      Width = 75
      Height = 39
      Align = alLeft
      Caption = 'Deletar'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      OnClick = btnDeletarClick
      ExplicitLeft = 220
      ExplicitTop = -4
    end
    object BitBtn3: TBitBtn
      Left = 718
      Top = 1
      Width = 75
      Height = 39
      Align = alRight
      Caption = 'Sair'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
      OnClick = BitBtn3Click
      ExplicitLeft = 175
      ExplicitTop = -4
    end
    object pnelFiltro: TPanel
      Left = 301
      Top = 1
      Width = 417
      Height = 39
      Align = alClient
      TabOrder = 4
      ExplicitLeft = 248
      ExplicitTop = 32
      ExplicitWidth = 185
      ExplicitHeight = 41
      object Label1: TLabel
        Left = 1
        Top = 1
        Width = 415
        Height = 13
        Align = alTop
        Caption = 'Filtro de clientes por nome'
        ExplicitWidth = 126
      end
      object edtFiltro: TEdit
        Left = 1
        Top = 17
        Width = 415
        Height = 21
        Align = alBottom
        TabOrder = 0
        OnChange = edtFiltroChange
        ExplicitLeft = 24
        ExplicitTop = 13
        ExplicitWidth = 121
      end
    end
    object btnEmail: TBitBtn
      Left = 226
      Top = 1
      Width = 75
      Height = 39
      Align = alLeft
      Caption = 'Email'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 5
      OnClick = btnEmailClick
      ExplicitLeft = 307
      ExplicitTop = 6
    end
  end
  object dbgListaCliente: TDBGrid
    Left = 0
    Top = 0
    Width = 794
    Height = 530
    Align = alClient
    DataSource = DM.dsrCliente
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = [fsBold]
    OnDrawColumnCell = dbgListaClienteDrawColumnCell
    Columns = <
      item
        Expanded = False
        FieldName = 'Nome'
        Width = 75
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Identidade'
        Width = 75
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Cpf'
        Width = 75
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DDD'
        Width = 75
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Telefone'
        Width = 75
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Email'
        Width = 75
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Cep'
        Width = 75
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Logradouro'
        Width = 75
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Numero'
        Width = 75
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Complemento'
        Width = 75
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Bairro'
        Width = 75
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Cidade'
        Width = 75
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Estado'
        Width = 75
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Pais'
        Width = 75
        Visible = True
      end>
  end
end
