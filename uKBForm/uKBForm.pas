unit uKBForm;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants, FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics,
  FMX.Dialogs, FMX.Layouts, FMX.Controls.Presentation, FMX.Edit, System.Math;

type
  TKBForm = class(TForm)
    VSB: TVertScrollBox;
    Layout: TLayout;
    procedure FormCreate(Sender: TObject);
    procedure FormVirtualKeyboardHidden(Sender: TObject;
      KeyboardVisible: Boolean; const Bounds: TRect);
    procedure FormVirtualKeyboardShown(Sender: TObject;
      KeyboardVisible: Boolean; const Bounds: TRect);
    procedure FormFocusChanged(Sender: TObject);
  private
    FKBBounds: TRectF;
    FNeedOffset: Boolean;
    Procedure CalcContentBounds(Sender: TObject; var ContentBounds: TRectF);
    Procedure RestorePosition;
    Procedure UpdatePosition;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  KBForm: TKBForm;

implementation

{$R *.fmx}
{ TKBForm }

{ TKBForm }

procedure TKBForm.CalcContentBounds(Sender: TObject; var ContentBounds: TRectF);
begin
  if FNeedOffset and (FKBBounds.Top > 0) then
  begin
    ContentBounds.Bottom := Max(ContentBounds.Bottom,
      2 * ClientHeight - FKBBounds.Top);
  end;
end;

procedure TKBForm.FormCreate(Sender: TObject);
begin
  VSB.OnCalcContentBounds := CalcContentBounds;
end;

procedure TKBForm.FormFocusChanged(Sender: TObject);
begin
  UpdatePosition;
end;

procedure TKBForm.FormVirtualKeyboardHidden(Sender: TObject;
  KeyboardVisible: Boolean; const Bounds: TRect);
begin
  FKBBounds.Create(0, 0, 0, 0);
  FNeedOffset := False;
  RestorePosition;
end;

procedure TKBForm.FormVirtualKeyboardShown(Sender: TObject;
  KeyboardVisible: Boolean; const Bounds: TRect);
begin
  FKBBounds := TRectF.Create(Bounds);
  FKBBounds.TopLeft := ScreenToClient(FKBBounds.TopLeft);
  FKBBounds.BottomRight := ScreenToClient(FKBBounds.BottomRight);
  UpdatePosition;
end;

procedure TKBForm.RestorePosition;
begin
  VSB.ViewportPosition :=
    PointF(VSB.ViewportPosition.X, 0);
  Layout.Align := TAlignLayout.Client;
  VSB.RealignContent;
end;

procedure TKBForm.UpdatePosition;
var
  LFocused: TControl;
  LFocusRect: TRectF;
begin
  FNeedOffset := False;
  if Assigned(Focused) then
  begin
    LFocused := TControl(Focused.GetObject);
    LFocusRect := LFocused.AbsoluteRect;
    LFocusRect.Offset(VSB.ViewportPosition);

    if (LFocusRect.IntersectsWith(TRectF.Create(FKBBounds))) and
      (LFocusRect.Bottom > FKBBounds.Top) then
    begin
      FNeedOffset := True;
      Layout.Align := TAlignLayout.Horizontal;
      VSB.RealignContent;
      Application.ProcessMessages;
      VSB.ViewportPosition :=
        PointF(VSB.ViewportPosition.X,
        LFocusRect.Bottom - FKBBounds.Top);
    end;
  end;

  if not FNeedOffset then
    RestorePosition;
end;

end.
