object DM: TDM
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 310
  Width = 324
  object dsrCliente: TDataSource
    DataSet = cdsCliente
    Left = 40
    Top = 64
  end
  object cdsCliente: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 40
    Top = 16
    object cdsClienteNome: TStringField
      FieldName = 'Nome'
      Size = 60
    end
    object cdsClienteIdentidade: TStringField
      FieldName = 'Identidade'
    end
    object cdsClienteCPF: TStringField
      DisplayLabel = 'CPF'
      FieldName = 'Cpf'
      EditMask = '999.999.999-99;0;_'
      Size = 11
    end
    object cdsClienteDDD: TStringField
      FieldName = 'DDD'
      Size = 2
    end
    object cdsClienteTelefone: TStringField
      DisplayWidth = 9
      FieldName = 'Telefone'
      Size = 9
    end
    object cdsClienteEmail: TStringField
      FieldName = 'Email'
      Size = 100
    end
    object cdsClienteCEP: TStringField
      DisplayLabel = 'CEP'
      FieldName = 'Cep'
      EditMask = '99.999-999;0;_'
      Size = 8
    end
    object cdsClienteLogradouro: TStringField
      FieldName = 'Logradouro'
      Size = 100
    end
    object cdsClienteNumero: TStringField
      FieldName = 'Numero'
      Size = 10
    end
    object cdsClienteComplemento: TStringField
      FieldName = 'Complemento'
      Size = 60
    end
    object cdsClienteBairro: TStringField
      FieldName = 'Bairro'
      Size = 30
    end
    object cdsClienteCidade: TStringField
      FieldName = 'Cidade'
      Size = 50
    end
    object cdsClienteEstado: TStringField
      FieldName = 'Estado'
      Size = 2
    end
    object cdsClientePais: TStringField
      FieldName = 'Pais'
      Size = 30
    end
  end
end
