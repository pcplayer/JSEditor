unit UFmFullScreen;
{----------------------------------------------------------------------------
  �����Ԫ��Ӧ�� Form����������ץ������ȫ��Ļ��Ȼ�����û�����������ȫ��Ļ
  ������ѡ��Ҫ��ȡ������

  �û�����󣬱� Form ��СΪ���� Form����ʾ�û���ȡ���ͼ��ͬʱ��ʾһЩ��ť��
  ����û������⣬��Ҫ���½�ȡ��ͨ�������� Form �ķ�����ť���رձ���Ļ��
  �ص�����ץ��Ļ�����ĵط�������û����⣬��ȷ����ť�������Զ�����ͼ��Ϊ
  GUID + .Jpg ���ļ�������ͨ���¼��ļ������ظ����ñ� Form �ĵط���

  ��õĵط���
  ����������и�������ť�����º󣬵��ñ���Ԫ��������2�ֲ�����ʽ��
  1. ֱ�ӵ��ñ���Ԫ��
  2. �Ȱѻ��鴰����С�����ó���Ļ���ٵ��ñ���Ԫ��

  ����һ���ط������屳����Ҳ���Բ�����Ļ��ͼ��

  ��Ļ��ͼ�󣬻����Բ��÷����ļ��ķ�ʽ�����͸��Է���

  pcplayer 2007-2-9
----------------------------------------------------------------------------}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Jpeg, ExtCtrls, ActnList, StdCtrls,
  {VnGlobal,}  Menus, Vcl.Buttons, System.Actions;

type
  //TAfterCatchScreenEvent = procedure(const AFileName: string) of object;   �и�ϵͳԤ����� TGetStrProc = procedure(const S: string) of object;

  TFmFullScreen = class(TForm)
    Image1: TImage;
    PanelTool: TPanel;
    RzBitBtn1: TBitBtn;
    RzBitBtn2: TBitBtn;
    ActionList1: TActionList;
    AcOK: TAction;
    AcCancel: TAction;
    Panel1: TPanel;
    Timer1: TTimer;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    procedure Image1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Image1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image1DblClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Panel1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure N1Click(Sender: TObject);
  private
    { Private declarations }
    FAfterCatchScreen: TGetStrProc;
    FAfterFormShow: TNotifyEvent;

    FStartX, FStartY: Integer;
    FOldX, FOldY: Integer;
    FLastX, FLastY: Integer;

    FSelecting: Boolean;
    FPicFilePath: string;

    procedure DoAfterCatchScreen(AFileName: string);

    procedure CatchFullScreen;
    procedure ShowAsFullScreen;

    procedure ShowAsNormalForm;

    procedure CreateParams(var Params: TCreateParams);
    procedure CatchPartScreen(AMethod: ShortInt); // 0 = �ļ���1= ������

    function SaveAsJpegFile: string;
  public
    { Public declarations }
    procedure Go;
    procedure SetLang;

    property NLPicFilePath: string read FPicFilePath write FPicFilePath;
    property NLAfterCatchScreen: TGetStrProc read FAfterCatchScreen write FAfterCatchScreen;
    property NLAtferScreenCatchFormShow: TNotifyEvent read FAfterFormShow write FAfterFormShow;
  end;

var
  FmFullScreen: TFmFullScreen;

implementation
uses Clipbrd;

{$R *.dfm}

{ TFmFullScreen }

procedure TFmFullScreen.CatchFullScreen;
var
  ADC:HDC;
  ABmp:TBitmap;
begin
  ABmp := TBitmap.Create;
  try
    ABmp.Width := Screen.Width;
    ABmp.Height := Screen.Height;
    ABmp.PixelFormat:=pf32bit;

    ADC := GetDC(0);

    try
      bitblt(ABmp.canvas.handle,0,0,ABmp.width,ABmp.height,ADC,0,0,srccopy);

      Image1.Picture.Bitmap.Assign(ABmp);
    finally
      ReleaseDC(0,ADC);
    end;
  finally
    ABmp.Free;
  end;
end;

procedure TFmFullScreen.CreateParams(var Params: TCreateParams);
begin
{-------------------------------------------------------------------------
  ��δ�������� Form �� Parent �� Desktop����֤�������ϲ㡣
  Ҫ�� FormStyle set to fsStayOnTop ���á�
---------------------------------------------------------------------------------}
  inherited CreateParams(Params);
  with Params do begin
    ExStyle := ExStyle or WS_EX_TOPMOST;
    WndParent := GetDesktopwindow;
  end;
end;

procedure TFmFullScreen.DoAfterCatchScreen(AFileName: string);
begin
  if Assigned(FAfterCatchScreen) then FAfterCatchScreen(AFileName);
end;

procedure TFmFullScreen.ShowAsFullScreen;
begin
{------------------------------------------------------------------------------
  �ñ� Form ȫ����ʾ�������ϲ㡣Ŀ�������������Ļ��棬
  ���û���Ϊ����������ѡ�������ȡ��Ļͼ��
-------------------------------------------------------------------------------}
  self.BorderStyle := bsNone;
  self.WindowState := wsMaximized;
  self.FormStyle := fsStayOnTop;
  Image1.Align := alClient;
  PanelTool.Visible := False;
  FSelecting := True;
  self.Show;
end;

procedure TFmFullScreen.ShowAsNormalForm;
begin
{-------------------------------------------------------------------------
  ��ͼ��ɺ��ñ� Form �ָ�Ϊһ����ͨ�� form����ʾ��ť�Ͳ˵������û����Բ�����
-------------------------------------------------------------------------------}
  self.BorderStyle := bsSizeable;
  self.WindowState := wsNormal;
  self.FormStyle := fsNormal;
  Panel1.Visible := True;

  self.Width := 600;
  self.Height := 450;
  //self.Position := poScreenCenter;
  self.Left := Trunc((Screen.Width - self.Width) / 2);
  self.Top := Trunc((Screen.Height - self.Height) / 2);
end;

procedure TFmFullScreen.Image1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbLeft then
  begin
    {
    with image1.canvas do
    begin
      //������ǰ���Ŀ�
      Pen.Color := clBlack;
      Pen.Style := psDot;
      Brush.Style := bsClear; //б������
      Pen.mode:=pmNot;    //�ʵ�ģʽΪȡ��

      Rectangle(FStartX, FStartY, FLastX, FLastY);
    end;
    }

    if FSelecting then
    begin
      FStartX := X;
      FStartY := Y;
      FOldX := X;
      FOldY := Y;
    end;
  end;
end;

procedure TFmFullScreen.Image1MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
{----------------------------------------------------------------------------
   ���������£��������߿�
-----------------------------------------------------------------------------}
  if not FSelecting then Exit;
  
  if (ssLeft in Shift)	then
  begin
    with image1.canvas do
    begin
      Pen.Color := clBlack;
      Pen.Style := psDot;
      Brush.Style := bsClear; //б������
      Pen.mode:=pmNot;    //�ʵ�ģʽΪȡ��
      //��������ԭ����һ����Σ��൱�ڲ������Ρ�
      Rectangle(FStartX, FStartY, FOldX, FOldY); //��ͼ

      Rectangle(FStartX, FStartY, X, Y);
      FOldX := X;
      FOldY := Y;
    end;
  end;
end;

procedure TFmFullScreen.Image1MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
{---------------------------------------------------------------------------
  ͣס���̶�ס��ȡ�����߿�
----------------------------------------------------------------------------}
  if FSelecting then
  begin
    FLastX := X;
    FLastY := Y;
    FSelecting := not FSelecting;
  end;
end;

procedure TFmFullScreen.Go;
begin
  //CatchFullScreen;
  //ShowAsFullScreen;
  //self.Show;
  Timer1.Enabled := True;
end;

procedure TFmFullScreen.CatchPartScreen(AMethod: ShortInt);
var
  ABmp: TBitmap;
  X1,Y1, X2, Y2: Integer;
  DRect, SRect: TRect;
  AFileName: string;
    AData : THandle;
  MyFormat : Word;
  APalette: HPALETTE;
begin
{--------------------------------------------------------------------------
  AMethod = 0 ��ȥ�ļ���1= ȥ������
------------------------------------------------------------------------------}
  if (FStartX <> FLastX) and (FStartY <> FLastY) then
  begin
    if FStartX <= FLastX then
    begin
      X1 := FStartX;
      X2 := FLastX;
    end
    else
    begin
      X1 := FLastX;
      X2 := FStartX;
    end;

    if FStartY <= FLastY then
    begin
      Y1 := FStartY;
      Y2 := FLastY;
    end
    else
    begin
      Y1 := FLastY;
      Y2 := FStartY;
    end;

    ABmp := TBitmap.Create;
    try
      ABmp.Width := X2 - X1;
      ABmp.Height := Y2 - Y1;

      DRect := Rect(0, 0, ABmp.Width, ABmp.Height);
      SRect := Rect(X1, Y1, X2, Y2);   //Todo: ���Ҫȥ����������ͼ�����߿�����Ҫ���������¼���һ�¡�
      //ABmp.Canvas.BrushCopy(DRect, Image1.Picture.Bitmap, SRect, clBlack);
      ABmp.Canvas.CopyRect(DRect, Image1.Picture.Bitmap.Canvas, SRect);

      Image1.Picture.Bitmap.Assign(ABmp);
      Image1.Align := alNone;
      Image1.AutoSize := True;
    finally
      ABmp.Free;
    end;
  end;
  //ShowAsNormalForm;

  //ץ��ͼ������Ϊ�ļ��������ļ���
  case AMethod of
    0: AFileName := SaveAsJpegFile;

    1:
    begin
      AFileName := '';
      Image1.Picture.Bitmap.SaveToClipboardFormat(MyFormat,AData,APalette);
      ClipBoard.SetAsHandle(MyFormat,AData);
    end;
  end; //case

  DoAfterCatchScreen(AFileName);
end;

procedure TFmFullScreen.Image1DblClick(Sender: TObject);
begin
  CatchPartScreen(0); //0 = ��ͼ���ļ���
end;

procedure TFmFullScreen.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
  begin
    if FSelecting then //���� Esc ��ȡ����ֱ�ӷ��ء�
    begin
      DoAfterCatchScreen('');
    end;

    FSelecting := not FSelecting; //True;
    with image1.canvas do
    begin
      Pen.Color := clBlack;
      Pen.Style := psDot;
      Brush.Style := bsClear; //б������
      Pen.mode:=pmNot;    //�ʵ�ģʽΪȡ��
      //��������ԭ����һ����Σ��൱�ڲ������Ρ�
      Rectangle(FStartX, FStartY, FLastX, FLastY); //��ͼ
    end;
  end;
end;

function TFmFullScreen.SaveAsJpegFile: string;
var
  AJpg: TJPEGImage;
  AGUID: TGUID;
begin
{----------------------------------------------------------------------------
  �ѵ�ǰ�� Image1 �Ļ��汣��Ϊ Jpeg ͼ��
-----------------------------------------------------------------------------}
  If Image1.Picture.Bitmap.Width = 0 then Exit;
  if Image1.Picture.Bitmap.Height = 0 then Exit;
  
  if FPicFilePath = '' then
  begin
    FPicFilePath := ExtractFilePath(Application.ExeName);
    if FPicFilePath[Length(FPicFilePath)] <> '\' then FPicFilePath := FPicFilePath + '\';
  end;

  CreateGUID(AGUID);

  AJpg := TJPEGImage.Create;
  try
    AJpg.CompressionQuality := 100;
    AJpg.Assign(Image1.Picture.Bitmap);
    Result := FPicFilePath + GUIDToString(AGUID) + '.jpg';
    AJpg.SaveToFile(Result);
  finally
    AJpg.Free;
  end;
end;

procedure TFmFullScreen.Panel1MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
const
  AOffset = 40;
var
  i: Integer;
begin
  if (Panel1.Left = 0) and (Panel1.Top = 0) then
  begin
    i := self.Width - Panel1.Width - AOffset;
    Panel1.Left := i;
  end
  else
  if (Panel1.Left >= (self.Width - Panel1.Width -AOffset)) and (Panel1.Top = 0) then
  begin
    Panel1.Top := self.Height - Panel1.Height - AOffset;
  end
  else
  if (Panel1.Left >= (self.Width - Panel1.Width - AOffset)) and (Panel1.Top >= (self.Height - Panel1.Height - AOffset)) then
  begin
    Panel1.Left := 0;
  end
  else
  begin
    Panel1.Left := 0;
    Panel1.Top := 0;
  end;
end;


procedure TFmFullScreen.SetLang;
var
  i, Count: Integer;
  ASection,S, ReturnStr: string;
begin
  {
  ASection := 'FmFullScreen'; // self.Name; //FmFullScreen
  //Count := MyLang.LjnGetInteter(ASection, 'ACount');    //��֣�ini.ReadInteger ��Ȼ���� 0��ֻ���� ReadString �������ˡ�
  S := MyLang.LjnGetCaption(ASection, 'ACount');
  if S='' then
    Count := 5
  else
  begin
    try
      Count := StrToInt(S);
    except
      Count := 5;
    end;
  end;
  Panel1.Caption := '';
  for i := 1 to Count do
  begin
    Panel1.Caption := Panel1.Caption + MyLang.LjnGetCaption(ASection, IntToStr(i));
    if i < Count then
      Panel1.Caption := Panel1.Caption + Char(#13) + Char(#10) + Char(#13) + Char(#10)
    else Panel1.Caption := Panel1.Caption;
  end;
  }

  ReturnStr := AnsiChar(#13) + AnsiChar(#10)+ AnsiChar(#13) + AnsiChar(#10);

  S := '��ʾ��������Ļ��ͼ״̬��' + ReturnStr + '�������������������߿�ѡ����Ҫ��ȡ�Ļ���';
  S := S + ReturnStr + '��Ҫ����ѡ���밴�����ϵ� Esc ��' + ReturnStr;
  S := S + 'ѡ����ɺ�˫����꣬���ѡ��Ļ���' + ReturnStr;
  S := S + '���������� Esc ����ֱ���˳�����״̬����ץȡ����';
  Panel1.Caption := S;
end;

procedure TFmFullScreen.FormShow(Sender: TObject);
var
  APath: string;
begin
  SetLang;

  //APath := GetCatchScreenDir;
  APath := ExtractFilePath(Application.ExeName) + 'Pic\';
  if not DirectoryExists(APath) then
    if not CreateDir(APath) then APath := ExtractFilePath(Application.ExeName); // NLUserInfo.NLRootPath;

  Self.NLPicFilePath := APath;
end;

procedure TFmFullScreen.FormCreate(Sender: TObject);
begin
  //MyLang.RegisterSetLang(self as IChangeLang);
  //MyLang.RegisterSetLang(self, self.SetLang);  //��ʱ��֧�ֶ������л������ε���
end;

procedure TFmFullScreen.FormDestroy(Sender: TObject);
begin
  {
  AIntf := self as IChangeLang;
  if Assigned(MyLang) then
    MyLang.UnRegisterSetLang(AIntf);
  }
end;

procedure TFmFullScreen.Timer1Timer(Sender: TObject);
begin
  //�ӳ�һ�£�����Ļץ���Ƿ���á�
  CatchFullScreen;
  ShowAsFullScreen;
  Timer1.Enabled := False;
  if Assigned(FAfterFormShow) then FAfterFormShow(Self);
end;

procedure TFmFullScreen.N1Click(Sender: TObject);
begin
  CatchPartScreen(1); // 1= ��ͼ��������
end;

end.
