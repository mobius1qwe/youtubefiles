program Project1;

uses
  System.StartUpCopy,
  FMX.Forms,
  uMain in 'uMain.pas' {Form2},
  ufrCategoria in 'componentes\ufrCategoria.pas' {frCategoria: TFrame},
  ufrPedido in 'componentes\ufrPedido.pas' {frPedido: TFrame};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
