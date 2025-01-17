object frmCadCliente: TfrmCadCliente
  Left = 0
  Top = 0
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'Cadastro de Cliente'
  ClientHeight = 440
  ClientWidth = 438
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object pnlDados: TPanel
    Left = 0
    Top = 0
    Width = 438
    Height = 399
    Align = alClient
    TabOrder = 0
    ExplicitTop = -6
    ExplicitWidth = 794
    ExplicitHeight = 814
    object Label1: TLabel
      Left = 8
      Top = 8
      Width = 27
      Height = 13
      Caption = 'Nome'
      FocusControl = dbeNome
    end
    object Label2: TLabel
      Left = 8
      Top = 48
      Width = 52
      Height = 13
      Caption = 'Identidade'
      FocusControl = dbeIdentidade
    end
    object Label3: TLabel
      Left = 224
      Top = 48
      Width = 19
      Height = 13
      Caption = 'CPF'
      FocusControl = dbeCPF
    end
    object Label4: TLabel
      Left = 8
      Top = 88
      Width = 21
      Height = 13
      Caption = 'DDD'
      FocusControl = dbeDDD
    end
    object Label5: TLabel
      Left = 44
      Top = 88
      Width = 42
      Height = 13
      Caption = 'Telefone'
      FocusControl = dbeTelefone
    end
    object Label6: TLabel
      Left = 224
      Top = 88
      Width = 24
      Height = 13
      Caption = 'Email'
      FocusControl = dbeEmail
    end
    object dbeNome: TDBEdit
      Left = 8
      Top = 24
      Width = 416
      Height = 21
      DataField = 'Nome'
      DataSource = DM.dsrCliente
      TabOrder = 0
    end
    object dbeIdentidade: TDBEdit
      Left = 8
      Top = 64
      Width = 210
      Height = 21
      DataField = 'Identidade'
      DataSource = DM.dsrCliente
      TabOrder = 1
    end
    object dbeCPF: TDBEdit
      Left = 224
      Top = 64
      Width = 200
      Height = 21
      DataField = 'Cpf'
      DataSource = DM.dsrCliente
      TabOrder = 2
    end
    object dbeDDD: TDBEdit
      Left = 8
      Top = 104
      Width = 30
      Height = 21
      DataField = 'DDD'
      DataSource = DM.dsrCliente
      TabOrder = 3
    end
    object dbeTelefone: TDBEdit
      Left = 44
      Top = 104
      Width = 174
      Height = 21
      DataField = 'Telefone'
      DataSource = DM.dsrCliente
      TabOrder = 4
    end
    object dbeEmail: TDBEdit
      Left = 224
      Top = 104
      Width = 200
      Height = 21
      DataField = 'Email'
      DataSource = DM.dsrCliente
      TabOrder = 5
    end
    object grpEndereco: TGroupBox
      Left = 1
      Top = 135
      Width = 436
      Height = 263
      Align = alBottom
      Caption = 'Endere'#231'o'
      TabOrder = 6
      ExplicitTop = 472
      object Label7: TLabel
        Left = 7
        Top = 19
        Width = 19
        Height = 13
        Caption = 'CEP'
        FocusControl = dbeCEP
      end
      object Label8: TLabel
        Left = 7
        Top = 56
        Width = 55
        Height = 13
        Caption = 'Logradouro'
        FocusControl = dbeLogradouro
      end
      object Label9: TLabel
        Left = 223
        Top = 56
        Width = 37
        Height = 13
        Caption = 'Numero'
        FocusControl = dbeNumero
      end
      object Label10: TLabel
        Left = 7
        Top = 96
        Width = 65
        Height = 13
        Caption = 'Complemento'
        FocusControl = dbeComplemento
      end
      object Label11: TLabel
        Left = 7
        Top = 136
        Width = 28
        Height = 13
        Caption = 'Bairro'
        FocusControl = dbeBairro
      end
      object Label12: TLabel
        Left = 7
        Top = 176
        Width = 33
        Height = 13
        Caption = 'Cidade'
        FocusControl = dbeCidade
      end
      object Label13: TLabel
        Left = 7
        Top = 216
        Width = 33
        Height = 13
        Caption = 'Estado'
        FocusControl = dbeEstado
      end
      object Label14: TLabel
        Left = 43
        Top = 216
        Width = 19
        Height = 13
        Caption = 'Pais'
        FocusControl = dbePais
      end
      object dbeCEP: TDBEdit
        Left = 7
        Top = 32
        Width = 108
        Height = 21
        DataField = 'Cep'
        DataSource = DM.dsrCliente
        TabOrder = 0
        OnKeyPress = dbeCEPKeyPress
      end
      object dbeLogradouro: TDBEdit
        Left = 7
        Top = 72
        Width = 210
        Height = 21
        DataField = 'Logradouro'
        DataSource = DM.dsrCliente
        TabOrder = 1
      end
      object dbeNumero: TDBEdit
        Left = 223
        Top = 72
        Width = 200
        Height = 21
        DataField = 'Numero'
        DataSource = DM.dsrCliente
        TabOrder = 2
      end
      object dbeComplemento: TDBEdit
        Left = 7
        Top = 112
        Width = 416
        Height = 21
        DataField = 'Complemento'
        DataSource = DM.dsrCliente
        TabOrder = 3
      end
      object dbeBairro: TDBEdit
        Left = 7
        Top = 152
        Width = 416
        Height = 21
        DataField = 'Bairro'
        DataSource = DM.dsrCliente
        TabOrder = 4
      end
      object dbeCidade: TDBEdit
        Left = 7
        Top = 192
        Width = 416
        Height = 21
        Color = clBtnFace
        DataField = 'Cidade'
        DataSource = DM.dsrCliente
        Enabled = False
        TabOrder = 5
      end
      object dbeEstado: TDBEdit
        Left = 7
        Top = 232
        Width = 30
        Height = 21
        Color = clBtnFace
        DataField = 'Estado'
        DataSource = DM.dsrCliente
        Enabled = False
        TabOrder = 6
      end
      object dbePais: TDBEdit
        Left = 43
        Top = 232
        Width = 380
        Height = 21
        DataField = 'Pais'
        DataSource = DM.dsrCliente
        TabOrder = 7
      end
      object btnBuscarCEP: TBitBtn
        Left = 121
        Top = 30
        Width = 75
        Height = 25
        Caption = 'Buscar CEP'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 8
        OnClick = btnBuscarCEPClick
      end
    end
  end
  object pnlBotao: TPanel
    Left = 0
    Top = 399
    Width = 438
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    ExplicitLeft = 176
    ExplicitTop = 87
    ExplicitWidth = 185
    object btnGravar: TBitBtn
      Left = 0
      Top = 0
      Width = 75
      Height = 41
      Align = alLeft
      Caption = 'Gravar'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      OnClick = btnGravarClick
      ExplicitLeft = -6
      ExplicitTop = 5
    end
    object btnCancelar: TBitBtn
      Left = 75
      Top = 0
      Width = 75
      Height = 41
      Align = alLeft
      Caption = 'Cancelar'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      OnClick = btnCancelarClick
      ExplicitLeft = 81
      ExplicitTop = 6
    end
  end
end
