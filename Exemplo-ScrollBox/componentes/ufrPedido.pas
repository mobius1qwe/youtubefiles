unit ufrPedido;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Objects, FMX.Controls.Presentation, System.Actions, FMX.ActnList,
  FMX.Gestures, FMX.Layouts;

type
  TfrPedido = class(TFrame)
    R_Status: TRectangle;
    RCorpo: TRectangle;
    ActionList1: TActionList;
    actExcluir: TAction;
    LCodigo: TLabel;
    Layout1: TLayout;
    LDescricao: TLabel;
    LTotal: TLabel;
    RFundo: TRectangle;
    Image1: TImage;
    Image2: TImage;
    actEnviar: TAction;
    procedure RCorpoMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure FrameMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Single);
    procedure RCorpoMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure FrameMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure actEnviarExecute(Sender: TObject);
    procedure actExcluirExecute(Sender: TObject);
  private
    { Private declarations }
    isSwipe: boolean;
    iPos: TPointF;
  public
    { Public declarations }
  end;

implementation

{$R *.fmx}

procedure TfrPedido.actEnviarExecute(Sender: TObject);
begin
  RCorpo.Position.X := 0;
  R_Status.Fill.Color := TAlphacolors.Orange;
end;

procedure TfrPedido.actExcluirExecute(Sender: TObject);
begin
  self.DisposeOf;
end;

procedure TfrPedido.FrameMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Single);
begin
  if (ssLeft in Shift) and (isSwipe) then
    RCorpo.Position.X := X - iPos.X;
  if RCorpo.Position.X > 0 then
    RFundo.Fill.Color := TAlphacolors.Skyblue
  else if RCorpo.Position.X < 0 then
    RFundo.Fill.Color := TAlphacolors.Tomato;
end;

procedure TfrPedido.FrameMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Single);
begin
  if RCorpo.Position.X > 80 then
    actEnviar.Execute
  else if RCorpo.Position.X <= -80 then
    actExcluir.Execute
  else
    RCorpo.Position.X := 0;
end;

procedure TfrPedido.RCorpoMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Single);
begin
  isSwipe := true;
  iPos.X := X;
  iPos.Y := Y;
  self.Root.Captured := self;
end;

procedure TfrPedido.RCorpoMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Single);
begin
  isSwipe := false;
end;

end.
