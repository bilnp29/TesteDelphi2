program SistemaClientes;

uses
  Vcl.Forms,
  unt_principal in 'codigos\unt_principal.pas' {frm_principal},
  unt_dm in 'codigos\unt_dm.pas' {dm: TDataModule},
  unt_clientes in 'codigos\unt_clientes.pas' {frm_cad_cliente};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(Tfrm_principal, frm_principal);
  Application.CreateForm(Tdm, dm);
  Application.CreateForm(Tfrm_cad_cliente, frm_cad_cliente);
  Application.Run;
end.
