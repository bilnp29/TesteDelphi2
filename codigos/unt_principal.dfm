object frm_principal: Tfrm_principal
  Left = 0
  Top = 0
  Caption = 'Sistema de Gerenciamento de Cliente'
  ClientHeight = 492
  ClientWidth = 774
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poMainFormCenter
  WindowState = wsMaximized
  PixelsPerInch = 96
  TextHeight = 13
  object StatusBar1: TStatusBar
    Left = 0
    Top = 473
    Width = 774
    Height = 19
    Panels = <
      item
        Alignment = taCenter
        Text = 'Sistema de gerenciamento de clientes'
        Width = 400
      end
      item
        Text = 'Data: '
        Width = 300
      end
      item
        Text = 'Hora:'
        Width = 300
      end>
    ExplicitWidth = 697
  end
  object pnl_topo: TPanel
    Left = 0
    Top = 0
    Width = 774
    Height = 41
    Align = alTop
    TabOrder = 1
  end
  object MainMenu1: TMainMenu
    Left = 720
    Top = 56
    object menu_arquivo: TMenuItem
      Caption = 'Arquivo'
      object subMenu_abrir: TMenuItem
        Caption = 'Abrir'
      end
      object subMenu_salvar: TMenuItem
        Caption = 'Salvar'
      end
      object subMenu_fechar: TMenuItem
        Caption = 'Fechar'
      end
    end
    object menu_cadastro: TMenuItem
      Caption = 'Cadastrar'
      object subMenu_clientes: TMenuItem
        Caption = 'Clientes'
        OnClick = subMenu_clientesClick
      end
    end
    object menu_sair: TMenuItem
      Caption = 'Sair'
    end
  end
  object Timer1: TTimer
    OnTimer = Timer1Timer
    Left = 720
    Top = 104
  end
end
