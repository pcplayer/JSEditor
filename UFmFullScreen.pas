unit UFmFullScreen;
{----------------------------------------------------------------------------
  这个单元对应的 Form，用来保存抓下来的全屏幕，然后让用户在这个虚拟的全屏幕
  上拉框选择要截取的区域。

  用户拉框后，本 Form 缩小为正常 Form，显示用户截取后的图像，同时显示一些按钮；
  如果用户不满意，想要重新截取，通过操作本 Form 的放弃按钮，关闭本屏幕，
  回到启动抓屏幕操作的地方；如果用户满意，则按确定按钮，程序自动保存图像为
  GUID + .Jpg 的文件名，并通过事件文件名返回给调用本 Form 的地方。

  最常用的地方：
  聊天会议里有个截屏按钮，按下后，调用本单元。这里有2种操作方式：
  1. 直接调用本单元；
  2. 先把会议窗口最小化，让出屏幕，再调用本单元。

  另外一个地方：画板背景，也可以采用屏幕截图。

  屏幕截图后，还可以采用发送文件的方式，发送给对方。

  pcplayer 2007-2-9
----------------------------------------------------------------------------}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Jpeg, ExtCtrls, ActnList, StdCtrls,
  {VnGlobal,}  Menus, Vcl.Buttons, System.Actions;

type
  //TAfterCatchScreenEvent = procedure(const AFileName: string) of object;   有个系统预定义的 TGetStrProc = procedure(const S: string) of object;

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
    procedure CatchPartScreen(AMethod: ShortInt); // 0 = 文件，1= 剪贴板

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
  这段代码让这个 Form 的 Parent 是 Desktop，保证它在最上层。
  要和 FormStyle set to fsStayOnTop 联用。
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
  让本 Form 全屏显示并在最上层。目的是虚拟成桌面的画面，
  误导用户以为是在桌面上选择区域截取屏幕图像。
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
  截图完成后，让本 Form 恢复为一个普通的 form，显示按钮和菜单，让用户可以操作。
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
      //擦掉先前画的框
      Pen.Color := clBlack;
      Pen.Style := psDot;
      Brush.Style := bsClear; //斜的虚线
      Pen.mode:=pmNot;    //笔的模式为取反

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
   如果左键按下，就拉虚线框。
-----------------------------------------------------------------------------}
  if not FSelecting then Exit;
  
  if (ssLeft in Shift)	then
  begin
    with image1.canvas do
    begin
      Pen.Color := clBlack;
      Pen.Style := psDot;
      Brush.Style := bsClear; //斜的虚线
      Pen.mode:=pmNot;    //笔的模式为取反
      //这样再在原处画一遍矩形，相当于擦除矩形。
      Rectangle(FStartX, FStartY, FOldX, FOldY); //擦图

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
  停住，固定住截取的虚线框
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
  AMethod = 0 是去文件，1= 去剪贴板
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
      SRect := Rect(X1, Y1, X2, Y2);   //Todo: 如果要去掉截下来的图的虚线框，这里要把坐标重新计算一下。
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

  //抓完图，保存为文件，返回文件名
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
  CatchPartScreen(0); //0 = 截图到文件。
end;

procedure TFmFullScreen.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
  begin
    if FSelecting then //两次 Esc 则取消，直接返回。
    begin
      DoAfterCatchScreen('');
    end;

    FSelecting := not FSelecting; //True;
    with image1.canvas do
    begin
      Pen.Color := clBlack;
      Pen.Style := psDot;
      Brush.Style := bsClear; //斜的虚线
      Pen.mode:=pmNot;    //笔的模式为取反
      //这样再在原处画一遍矩形，相当于擦除矩形。
      Rectangle(FStartX, FStartY, FLastX, FLastY); //擦图
    end;
  end;
end;

function TFmFullScreen.SaveAsJpegFile: string;
var
  AJpg: TJPEGImage;
  AGUID: TGUID;
begin
{----------------------------------------------------------------------------
  把当前的 Image1 的画面保存为 Jpeg 图像。
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
  //Count := MyLang.LjnGetInteter(ASection, 'ACount');    //奇怪，ini.ReadInteger 居然返回 0。只好用 ReadString 来处理了。
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

  S := '提示：进入屏幕截图状态！' + ReturnStr + '按下鼠标左键，拉动虚线框，选择你要截取的画面';
  S := S + ReturnStr + '想要重新选择，请按键盘上的 Esc 键' + ReturnStr;
  S := S + '选择完成后，双击鼠标，获得选择的画面' + ReturnStr;
  S := S + '连续按两次 Esc 键则直接退出截屏状态，不抓取画面';
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
  //MyLang.RegisterSetLang(self, self.SetLang);  //暂时不支持多语言切换。屏蔽掉。
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
  //延迟一下，看屏幕抓得是否更好。
  CatchFullScreen;
  ShowAsFullScreen;
  Timer1.Enabled := False;
  if Assigned(FAfterFormShow) then FAfterFormShow(Self);
end;

procedure TFmFullScreen.N1Click(Sender: TObject);
begin
  CatchPartScreen(1); // 1= 截图到剪贴板
end;

end.
