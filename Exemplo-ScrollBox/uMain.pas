unit uMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, FMX.Types,
  System.Variants, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Layouts, FMX.Controls.Presentation, FMX.StdCtrls;

type
  TForm2 = class(TForm)
    VSB: TVertScrollBox;
    HSB: THorzScrollBox;
    BVert: TButton;
    BHorz: TButton;
    FlowLayout1: TFlowLayout;
    procedure BVertClick(Sender: TObject);
    procedure BHorzClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

uses ufrPedido, ufrCategoria;

{$R *.fmx}

procedure TForm2.BHorzClick(Sender: TObject);
var
  i: Integer;
  cat: TfrCategoria;
begin
  HSB.BeginUpdate;
  for i := 0 to 10 do
  begin
    cat := TfrCategoria.Create(nil);
    cat.Name := '';
    cat.Rotulo.Text := 'Categoria ' + inttostr(i);
    cat.Width := cat.Rotulo.Text.Length * 15 + 10;
    cat.Parent := HSB;
    cat.Align := TAlignLayout.Left;

    HSB.AddObject(cat);
  end;
  HSB.EndUpdate;
end;

procedure TForm2.BVertClick(Sender: TObject);
var
  i: Integer;
  ped: TfrPedido;
begin
  VSB.BeginUpdate;
  for i := 0 to 10 do
  begin
    ped := TfrPedido.Create(nil);
    ped.Name := '';
    ped.Align := TAlignLayout.Top;
    ped.LDescricao.Text := 'Pedido ' + inttostr(i);

    VSB.AddObject(ped);
  end;
  VSB.EndUpdate;
end;

end.
