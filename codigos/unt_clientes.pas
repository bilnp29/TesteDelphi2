unit unt_clientes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.Buttons,
  Vcl.Mask, Vcl.DBCtrls, Data.DB, Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids;

type
  Tfrm_cad_cliente = class(TForm)
    PageControl1: TPageControl;
    tb_cadastro: TTabSheet;
    tb_consulta: TTabSheet;
    lb_id: TLabel;
    lb_nome: TLabel;
    lb_endereco: TLabel;
    lb_numero: TLabel;
    lb_barrio: TLabel;
    lb_Cidade: TLabel;
    lb_uf: TLabel;
    lb_email: TLabel;
    lb_telefone: TLabel;
    lb_cel: TLabel;
    lb_data_nasc: TLabel;
    lb_CPF: TLabel;
    lb_rg: TLabel;
    lb_dataCadastro: TLabel;
    lbl_situacao: TLabel;
    btn_inserir: TSpeedButton;
    btn_editar: TSpeedButton;
    btn_salvar: TSpeedButton;
    btn_cancelar: TSpeedButton;
    btn_excluir: TSpeedButton;
    btn_localizar: TSpeedButton;
    btn_fechar: TSpeedButton;
    DB_id: TDBEdit;
    DB_nome: TDBEdit;
    DB_endereco: TDBEdit;
    DB_numero: TDBEdit;
    DB_bairro: TDBEdit;
    DB_cidade: TDBEdit;
    DB_email: TDBEdit;
    DB_telefone: TDBEdit;
    DB_celular: TDBEdit;
    DB_data_nascimento: TDBEdit;
    DB_cpf: TDBEdit;
    DB_rg: TDBEdit;
    DB_data_cadastro: TDBEdit;
    DB_uf: TDBComboBox;
    DB_situacao: TDBComboBox;
    btn_voltar: TButton;
    DBGrid1: TDBGrid;
    btn_imprimir: TButton;
    btn_pesquisar: TButton;
    edt_consultar: TEdit;
    lbl_consultar: TLabel;
    rdg_busca: TRadioGroup;
    date_buscar: TDateTimePicker;
    lbl_msg: TLabel;
    btn_buscarTodos: TButton;
    edt_Imprimir: TEdit;
    Label1: TLabel;
    procedure btn_inserirClick(Sender: TObject);
    procedure btn_editarClick(Sender: TObject);
    procedure btn_salvarClick(Sender: TObject);
    procedure btn_excluirClick(Sender: TObject);
    procedure btn_fecharClick(Sender: TObject);
    procedure btn_cancelarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btn_localizarClick(Sender: TObject);
    procedure btn_voltarClic(Sender: TObject);
    procedure rdg_buscaClick(Sender: TObject);
    procedure btn_pesquisarClick(Sender: TObject);
    procedure btn_buscarTodosClick(Sender: TObject);
    procedure edt_consultarKeyPress(Sender: TObject; var Key: Char);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure btn_imprimirClick(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);


  private
    procedure configBotoes;
    procedure quantidadeRegistros;
    procedure buscarTudo;
    procedure desativarTxt;
    procedure ativarTxt;
  public
    { Public declarations }
  end;

var
  frm_cad_cliente: Tfrm_cad_cliente;

implementation

{$R *.dfm}

uses unt_dm;

procedure Tfrm_cad_cliente.ativarTxt;
begin
    DB_id.Enabled               := true;
    DB_nome.Enabled             := true;
    DB_endereco.Enabled         := true;
    DB_numero.Enabled           := true;
    DB_bairro.Enabled           := true;
    DB_cidade.Enabled           := true;
    DB_email.Enabled            := true;
    DB_telefone.Enabled         := true;
    DB_celular.Enabled          := true;
    DB_data_nascimento.Enabled  := true;
    DB_cpf.Enabled              := true;
    DB_rg.Enabled               := true;
    DB_data_cadastro.Enabled    := true;
    DB_uf.Enabled               := true;
    DB_situacao.Enabled         := true;


end;

procedure Tfrm_cad_cliente.btn_buscarTodosClick(Sender: TObject);
begin
    buscarTudo;
end;

procedure Tfrm_cad_cliente.btn_cancelarClick(Sender: TObject);
begin
  // Cancelando o processo...
  dm.tb_clientes.Cancel;

  //Habilitando e desabilitando bot�es
  configBotoes;
end;

procedure Tfrm_cad_cliente.btn_editarClick(Sender: TObject);
begin
  //Habilitando e desabilitando bot�es
   configBotoes;

  // Ativando campos de Tedt.
   ativarTxt;

  // Iniciando a edi��o na tabela
  dm.FDQuery_consulta_cliente.close;
  dm.FDQuery_consulta_cliente.SQL.Clear;
  dm.FDQuery_consulta_cliente.SQl.Add('select * from clientes where cli_id = :codigo');
  dm.FDQuery_consulta_cliente.ParamByName('codigo').Value := StrToInt(DB_id.Text);
  dm.FDQuery_consulta_cliente.Open;

end;

procedure Tfrm_cad_cliente.btn_excluirClick(Sender: TObject);

  // Excluindo Cliente...
begin
  case Application.MessageBox('Deseja excluir o cliente? ', 'Excluir Cliente',MB_YESNO + MB_ICONQUESTION) of
  IDYES:
  begin
    dm.FDQuery_consulta_cliente.close;
    dm.FDQuery_consulta_cliente.SQL.Clear;
    dm.FDQuery_consulta_cliente.SQl.Add('select * from clientes where cli_id = :codigo');
    dm.FDQuery_consulta_cliente.ParamByName('codigo').Value := StrToInt(DB_id.Text);
    dm.FDQuery_consulta_cliente.Open;
    dm.FDQuery_consulta_cliente.Delete;
    ShowMessage('O cliente foi excluido com sucesso!!!');
  end;
  IDNO:
  begin
     exit;
  end;
  end;
end;

procedure Tfrm_cad_cliente.btn_fecharClick(Sender: TObject);
begin
  if dm.tb_clientes.State in [dsInsert, dsedit] then
   begin
      ShowMessage('Salve ou cancele o registro amtes!!!');
      exit;
   end
   else
   begin
      close;
   end;
end;

procedure Tfrm_cad_cliente.btn_imprimirClick(Sender: TObject);
begin
  with dm.FDQuery_imprimir do
  begin
    Close;
    SQL.Clear;
    if edt_Imprimir.Text = '' then
    begin
      sql.Add('select * from clientes');
    end
    else
    begin
      sql.Add('select * from clientes where cli_id = :codigo');
      ParamByName('codigo').Value := StrToInt(edt_Imprimir.Text);
    end;
    
    Open;
    dm.report_cliente.LoadFromFile(GetCurrentDir + '\relatorio\rel_cliente.fr3');
    dm.report_cliente.ShowReport();
  end;
end;

procedure Tfrm_cad_cliente.btn_inserirClick(Sender: TObject);
begin
  // Ativando campos de Tedt.
   ativarTxt;

  //Iniciando a inser��o na tabela
  dm.tb_clientes.Active := true;
  dm.tb_clientes.Insert;

  //Habilitando e desabilitando bot�es
   configBotoes;

  //Tratamento da data
  dm.tb_clientescli_data_cadastro.Value := date;
  DB_nome.SetFocus;

end;

procedure Tfrm_cad_cliente.btn_localizarClick(Sender: TObject);
begin

  PageControl1.TabIndex := 1;
  tb_consulta.TabVisible := true;
  tb_cadastro.TabVisible := false;

  buscarTudo;

end;

procedure Tfrm_cad_cliente.btn_pesquisarClick(Sender: TObject);
begin
  if edt_consultar.Text = '' then
  begin
  ShowMessage('Digite o que se pede.');
  edt_consultar.SetFocus;
  exit;
  end;

  with dm.FDQuery_consulta_cliente do
  begin
    Close;
    Sql.Clear;
    sql.Add('select * from clientes');

    case rdg_busca.ItemIndex of
    0:
    begin
      SQL.Add('where cli_id = :codigo');
      ParamByName('codigo').Value := edt_consultar.Text;
    end;

    1:
    begin
      SQL.Add('where cli_nome like :nome');
      ParamByName('nome').Value := '%' + edt_consultar.Text + '%';
    end;

    2:
    begin
      SQL.Add('where cli_rg = :rg');
      ParamByName('rg').Value := edt_consultar.Text;
    end;

    3:
    begin
      SQL.Add('where cli_cpf = :cpf');
      ParamByName('cpf').Value := edt_consultar.Text;
    end;

    4:
    begin
      SQL.Add('where cli_data_nascimento = :data');
      ParamByName('data').AsDate := strtodate(formatDateTime('dd/mm/yyyy',date_buscar.Date));
    end;

    end;

    Open;

    quantidadeRegistros;

  end;
end;

procedure Tfrm_cad_cliente.btn_salvarClick(Sender: TObject);
begin
 // Salvando cliente
  dm.tb_clientes.Post;

 // Messagem de sucesso.
  ShowMessage('Cliente salvo com sucesso!!!');

  //Habilitando e desabilitando bot�es
   configBotoes;


end;

procedure Tfrm_cad_cliente.btn_voltarClic(Sender: TObject);
begin
  PageControl1.TabIndex := 0;
  tb_consulta.TabVisible := false;
  tb_cadastro.TabVisible := true;
  edt_Imprimir.Clear;
end;

procedure Tfrm_cad_cliente.buscarTudo;
begin
  dm.FDQuery_consulta_cliente.close;
  dm.FDQuery_consulta_cliente.SQL.Clear;
  dm.FDQuery_consulta_cliente.SQl.Add('select * from clientes');
  dm.FDQuery_consulta_cliente.Open;
  quantidadeRegistros;
end;

procedure Tfrm_cad_cliente.configBotoes;
begin

  btn_inserir.Enabled  := dm.tb_clientes.State in [dsBrowse];
  btn_excluir.Enabled  := dm.tb_clientes.State in [dsBrowse];
  btn_editar.Enabled   := dm.tb_clientes.State in [dsBrowse];
  btn_salvar.Enabled   := dm.tb_clientes.State in [dsInsert, dsEdit];
  btn_cancelar.Enabled := dm.tb_clientes.State in [dsInsert, dsEdit];

end;



procedure Tfrm_cad_cliente.DBGrid1CellClick(Column: TColumn);
begin
  edt_Imprimir.Text := IntToStr(dm.FDQuery_consulta_clientecli_id.Value);

end;

procedure Tfrm_cad_cliente.DBGrid1DblClick(Sender: TObject);
begin
  PageControl1.TabIndex := 0;
  tb_consulta.TabVisible := false;
  tb_cadastro.TabVisible := true;

  DB_id.Text := IntToStr(dm.FDQuery_consulta_clientecli_id.Value);
  DB_nome.Text := dm.FDQuery_consulta_clientecli_nome.Value;
  DB_endereco.Text := dm.FDQuery_consulta_clientecli_endereco.Value;
  DB_numero.Text := IntToStr(dm.FDQuery_consulta_clientecli_numero.Value);
  DB_bairro.Text := dm.FDQuery_consulta_clientecli_bairro.Value;
  DB_cidade.Text := dm.FDQuery_consulta_clientecli_cidade.Value;
  DB_telefone.Text := dm.FDQuery_consulta_clientecli_tel.Value;
  DB_celular.Text := dm.FDQuery_consulta_clientecli_cel.Value;
  DB_uf.Text := dm.FDQuery_consulta_clientecli_estado.Value;
  DB_email.Text := dm.FDQuery_consulta_clientecli_email.Value;
  DB_rg.Text := dm.FDQuery_consulta_clientecli_rg.Value;
  DB_cpf.Text := dm.FDQuery_consulta_clientecli_cpf.Value;
  DB_situacao.Text := dm.FDQuery_consulta_clientecli_situacao.Value;
  DB_data_nascimento.Text := DateToStr(dm.FDQuery_consulta_clientecli_data_nascimento.Value);
  DB_data_cadastro.Text := DateToStr(dm.FDQuery_consulta_clientecli_data_cadastro.Value);

  desativarTxt;

end;

procedure Tfrm_cad_cliente.desativarTxt;
begin
    DB_id.Enabled               := false;
    DB_nome.Enabled             := false;
    DB_endereco.Enabled         := false;
    DB_numero.Enabled           := false;
    DB_bairro.Enabled           := false;
    DB_cidade.Enabled           := false;
    DB_email.Enabled            := false;
    DB_telefone.Enabled         := false;
    DB_celular.Enabled          := false;
    DB_data_nascimento.Enabled  := false;
    DB_cpf.Enabled              := false;
    DB_rg.Enabled               := false;
    DB_data_cadastro.Enabled    := false;
    DB_uf.Enabled               := false;
    DB_situacao.Enabled         := false;

end;

procedure Tfrm_cad_cliente.edt_consultarKeyPress(Sender: TObject;
  var Key: Char);
begin
 case rdg_busca.ItemIndex of
    0:
    begin
       if (key in ['0'..'9'] = false) and (Word (key) <> VK_BACK) then
       begin
         ShowMessage('Digite aqui apenas n�mero...');
         Key := #0;
       end;

    end;

    1:
    begin
       if (key in ['0'..'9'] = true) and (Word (key) <> VK_BACK) then
       begin
         ShowMessage('Digite aqui apenas letras...');
         Key := #0;
       end;

    end;

    2:
    begin
      if (key in ['0'..'9'] = false) and (Word (key) <> VK_BACK) then
       begin
         ShowMessage('Digite aqui apenas n�mero...');
         Key := #0;
       end;

    end;

    3:
    begin
      if (key in ['0'..'9'] = false) and (Word (key) <> VK_BACK) then
       begin
         ShowMessage('Digite aqui apenas n�mero...');
         Key := #0;
       end;

    end;
 end;

end;

procedure Tfrm_cad_cliente.FormCreate(Sender: TObject);
begin

  PageControl1.TabIndex   := 0;
  tb_consulta.TabVisible  := false;

  btn_salvar.Enabled      := false;
  btn_cancelar.Enabled    := false;

   edt_consultar.Visible  := false;
   lbl_consultar.Visible  := false;
   date_buscar.Visible    := false;
   btn_imprimir.Enabled   := false;

end;

procedure Tfrm_cad_cliente.quantidadeRegistros;
begin
  with dm.FDQuery_consulta_cliente do
  begin
  if RecordCount = 0 then
    begin
      lbl_msg.Visible      := true;
      lbl_msg.Caption      := '';
      lbl_msg.Caption      := 'Nenhum cliente encontrado.';
      btn_imprimir.Enabled := false;
    end;

    if RecordCount = 1 then
    begin
      lbl_msg.Visible      := true;
      lbl_msg.Caption      := '';
      lbl_msg.Caption      := 'Foi encontrado ' + IntToStr(dm.FDQuery_consulta_cliente.RecordCount) + 'cliente.';
      btn_imprimir.Enabled := true;
    end;

    if RecordCount > 1 then
    begin
      lbl_msg.Visible      := true;
      lbl_msg.Caption      := '';
      lbl_msg.Caption      := 'Foram encontrados ' + IntToStr(dm.FDQuery_consulta_cliente.RecordCount) + 'clientes.';
      btn_imprimir.Enabled := true;
    end;
  end;
end;

procedure Tfrm_cad_cliente.rdg_buscaClick(Sender: TObject);
begin
  case rdg_busca.ItemIndex of
    0:
    begin
      edt_consultar.Visible := true;
      lbl_consultar.Visible := true;
      date_buscar.Visible   := false;
      edt_consultar.Clear;
      edt_consultar.SetFocus;

      lbl_consultar.Caption := 'Digite o c�digo do cliente.';
    end;

    1:
    begin
      edt_consultar.Visible := true;
      lbl_consultar.Visible := true;
      date_buscar.Visible   := false;
      edt_consultar.Clear;
      edt_consultar.SetFocus;

      lbl_consultar.Caption := 'Digite o nome do cliente.';
    end;

    2:
    begin
      edt_consultar.Visible := true;
      lbl_consultar.Visible := true;
      date_buscar.Visible   := false;
      edt_consultar.Clear;
      edt_consultar.SetFocus;

      lbl_consultar.Caption := 'Digite o RG do cliente.';
    end;

    3:
    begin
      edt_consultar.Visible := true;
      lbl_consultar.Visible := true;
      date_buscar.Visible   := false;
      edt_consultar.Clear;
      edt_consultar.SetFocus;

      lbl_consultar.Caption := 'Digite o CPF do cliente.';
    end;

    4:
    begin
      edt_consultar.Visible := false;
      lbl_consultar.Visible := true;
      date_buscar.Visible   := true;
      edt_consultar.Text    := 'a';
      lbl_consultar.Caption := 'Digite a data de nascimento do cliente.';
    end;
  end;
end;

end.
