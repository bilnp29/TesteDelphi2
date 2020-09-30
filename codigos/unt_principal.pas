unit unt_principal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Menus, Vcl.ComCtrls;

type
  Tfrm_principal = class(TForm)
    StatusBar1: TStatusBar;
    MainMenu1: TMainMenu;
    menu_arquivo: TMenuItem;
    subMenu_abrir: TMenuItem;
    subMenu_salvar: TMenuItem;
    subMenu_fechar: TMenuItem;
    menu_cadastro: TMenuItem;
    subMenu_clientes: TMenuItem;
    menu_sair: TMenuItem;
    pnl_topo: TPanel;
    Timer1: TTimer;
    procedure Timer1Timer(Sender: TObject);
    procedure subMenu_clientesClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frm_principal: Tfrm_principal;

implementation

{$R *.dfm}

uses unt_clientes;

procedure Tfrm_principal.subMenu_clientesClick(Sender: TObject);
begin
  frm_cad_cliente.ShowModal;
end;

procedure Tfrm_principal.Timer1Timer(Sender: TObject);
begin
  StatusBar1.Panels[1].Text := 'Data: ' + FormatDateTime('dddd, dd " de " mmmm " de " yyyy', now);
  StatusBar1.Panels[2].Text := 'Hora: ' + FormatDateTime('hh:mm:ss', now);

end;

end.
