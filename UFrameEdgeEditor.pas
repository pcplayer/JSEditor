unit UFrameEdgeEditor;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  System.Threading, System.SyncObjs,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask,
  JvExMask, JvSpin, JvExStdCtrls, JvCombobox, JvColorCombo, JvExControls,
  JvButton, JvTransparentButton, Vcl.ExtCtrls, System.Actions, Vcl.ActnList,
  System.ImageList, Vcl.ImgList, WebView2, Winapi.ActiveX, Vcl.Edge,
  Vcl.ComCtrls, Vcl.ToolWin, JvExComCtrls, JvToolBar, IdBaseComponent, IdCoder,
  IdCoder3to4, IdCoderMIME, Vcl.Menus;

type
  IJsHTMLContent = interface
    ['{0515C7CD-D511-4C6E-AD0C-592E43761BF4}']
    procedure DoBeforeSave(var AFileName: string);
    procedure GetHEMLSourceCode(const HTML: string; var AFileName: string);
    procedure DoOnScript(HTML: string);
  end;

  TFrameEdgeEditor = class(TFrame)
    ActionList1: TActionList;
    ilGFX16: TImageList;
    ilGFX16_d: TImageList;
    ilGFX32: TImageList;
    ilGFX32_d: TImageList;
    ilBulletNumberGallery: TImageList;
    alBulletNumberGallery: TActionList;
    NumberNoneActn: TAction;
    NumberArabicDotActn: TAction;
    NumberArabicParenActn: TAction;
    NumberUpperRomanActn: TAction;
    NumberUpperActn: TAction;
    NumberLowerParenActn: TAction;
    NumberLowerDotActn: TAction;
    NumberLowerRomanActn: TAction;
    FileSaveActn: TAction;
    FileNewActn: TAction;
    AcBold: TAction;
    AcItalic: TAction;
    AcCut: TAction;
    AcCopy: TAction;
    AcPaste: TAction;
    AcSellectAll: TAction;
    AcDelete: TAction;
    AcPicAdd: TAction;
    AcHideToolPanel: TAction;
    AcUndo: TAction;
    AcScreenCatch: TAction;
    AcAddLink: TAction;
    AcDeleteLink: TAction;
    AcInsertTable: TAction;
    AcInsertLine: TAction;
    AcInsertParagraph: TAction;
    AcUnderLine: TAction;
    AcStrikeout: TAction;
    AcBullets: TAction;
    AcAlignLeft: TAction;
    AcAlignRight: TAction;
    AcAlignCenter: TAction;
    AcGrowFont: TAction;
    AcShrink: TAction;
    AcSubscript: TAction;
    AcUperScript: TAction;
    AcHightLightColor: TAction;
    AcFontColor: TAction;
    AcNumbering: TAction;
    AcFontBackColor: TAction;
    EdgeBrowser1: TEdgeBrowser;
    JvToolBar1: TJvToolBar;
    JvTransparentButton2: TJvTransparentButton;
    ToolButton23: TToolButton;
    ToolButton4: TJvTransparentButton;
    ToolButton3: TJvTransparentButton;
    ToolButton2: TJvTransparentButton;
    ToolButton1: TJvTransparentButton;
    SpinEdit1: TJvSpinEdit;
    ToolButton25: TToolButton;
    FontComboBox1: TJvFontComboBox;
    ToolButton24: TToolButton;
    ToolButton5: TJvTransparentButton;
    JvToolBar2: TJvToolBar;
    ToolButton10: TJvTransparentButton;
    ToolButton11: TJvTransparentButton;
    ToolButton12: TJvTransparentButton;
    ToolButton13: TJvTransparentButton;
    ToolButton14: TJvTransparentButton;
    ToolButton15: TJvTransparentButton;
    ToolButton16: TJvTransparentButton;
    ToolButton18: TJvTransparentButton;
    ToolButton19: TJvTransparentButton;
    ToolButton20: TJvTransparentButton;
    ToolButton21: TJvTransparentButton;
    ToolButton6: TJvTransparentButton;
    ToolButton7: TJvTransparentButton;
    ToolButton8: TJvTransparentButton;
    ToolButton9: TJvTransparentButton;
    ColorDialog1: TColorDialog;
    IdEncoderMIME1: TIdEncoderMIME;
    OpenDialog1: TOpenDialog;
    AcPicResize: TAction;
    AcRemoveFormat: TAction;
    AcbgColor: TAction;
    JvTransparentButton1: TJvTransparentButton;
    ToolButton26: TToolButton;
    ComboBox1: TComboBox;
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    New1: TMenuItem;
    bianji1: TMenuItem;
    AcAddLink1: TMenuItem;
    N2: TMenuItem;
    AcbgColor1: TMenuItem;
    AcInsertParagraph1: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    Bullets1: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    N10: TMenuItem;
    N11: TMenuItem;
    N12: TMenuItem;
    N13: TMenuItem;
    N14: TMenuItem;
    N15: TMenuItem;
    AcRemoveFormat1: TMenuItem;
    N16: TMenuItem;
    N17: TMenuItem;
    N18: TMenuItem;
    N19: TMenuItem;
    N20: TMenuItem;
    AcInsertCode: TAction;
    N21: TMenuItem;
    AcHighLightCode: TAction;
    N22: TMenuItem;
    Save1: TMenuItem;
    JvTransparentButton3: TJvTransparentButton;
    JvTransparentButton4: TJvTransparentButton;
    JvTransparentButton5: TJvTransparentButton;
    ToolButton17: TToolButton;
    ToolButton22: TToolButton;
    AcOpen: TAction;
    N23: TMenuItem;
    procedure FileNewActnExecute(Sender: TObject);
    procedure AcHideToolPanelExecute(Sender: TObject);
    procedure AcBoldExecute(Sender: TObject);
    procedure EdgeBrowser1Enter(Sender: TObject);
    procedure SpinEdit1Change(Sender: TObject);
    procedure FontComboBox1Change(Sender: TObject);
    procedure AcItalicExecute(Sender: TObject);
    procedure AcUnderLineExecute(Sender: TObject);
    procedure AcUperScriptExecute(Sender: TObject);
    procedure AcSubscriptExecute(Sender: TObject);
    procedure AcAddLinkExecute(Sender: TObject);
    procedure AcDeleteLinkExecute(Sender: TObject);
    procedure AcInsertTableExecute(Sender: TObject);
    procedure AcFontColorExecute(Sender: TObject);
    procedure AcFontBackColorExecute(Sender: TObject);
    procedure AcPicAddExecute(Sender: TObject);
    procedure AcPicResizeExecute(Sender: TObject);
    procedure AcStrikeoutExecute(Sender: TObject);
    procedure AcRemoveFormatExecute(Sender: TObject);
    procedure AcScreenCatchExecute(Sender: TObject);
    procedure AcbgColorExecute(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure AcInsertLineExecute(Sender: TObject);
    procedure AcAlignLeftExecute(Sender: TObject);
    procedure AcAlignRightExecute(Sender: TObject);
    procedure AcAlignCenterExecute(Sender: TObject);
    procedure AcBulletsExecute(Sender: TObject);
    procedure AcNumberingExecute(Sender: TObject);
    procedure AcInsertCodeExecute(Sender: TObject);
    procedure AcHighLightCodeExecute(Sender: TObject);
    procedure EdgeBrowser1ExecuteScript(Sender: TCustomEdgeBrowser;
      AResult: HRESULT; const AResultObjectAsJson: string);
    procedure FileSaveActnExecute(Sender: TObject);
    procedure AcOpenExecute(Sender: TObject);
  private
    { Private declarations }
    FFontName: string;
    FFontSize: Integer;
    FFontColor: TColor;
    FToolPanelStatus: Boolean;

    FScriptReturn: string;
    FEditMode: Boolean;

    FEvent: TEvent;

    FJsHTMLContent: IJsHTMLContent;

    function GetMyPath: string;

    function GetFileBase64(const AFileName: string; var FileType: string): string;
    procedure DoInsertLocalImage(const AFileName: string);
    procedure DoAfterCatchScreen(const AFileName: string);
    procedure SendGetHTMLCmd;
  public
    { Public declarations }
    procedure IniUI;

    property JsHTMLContent: IJsHTMLContent read FJsHTMLContent write FJsHTMLContent;
  end;

implementation

uses System.IOUtils, System.NetEncoding, Vcl.GraphUtil, Clipbrd, UFmFullScreen, UTableProperty;

{$R *.dfm}

{ TFrameEdgeEditor }

procedure TFrameEdgeEditor.AcAddLinkExecute(Sender: TObject);
var
  S: string;
begin
  //����
  if not InputQuery('��������', '����д��������', S) then Exit;

  S := 'document.execCommand("createLink", false, ' + QuotedStr(S) + ');';
  EdgeBrowser1.ExecuteScript(S);
end;

procedure TFrameEdgeEditor.AcAlignCenterExecute(Sender: TObject);
var
  S: string;
begin
  //����
  S := 'document.execCommand("justifyCenter", false, null);';
  EdgeBrowser1.ExecuteScript(S);
end;

procedure TFrameEdgeEditor.AcAlignLeftExecute(Sender: TObject);
var
  S: string;
begin
  //�����
  S := 'document.execCommand("justifyLeft", false, null);';
  EdgeBrowser1.ExecuteScript(S);
end;

procedure TFrameEdgeEditor.AcAlignRightExecute(Sender: TObject);
var
  S: string;
begin
  //�Ҷ���
  S := 'document.execCommand("justifyRight", false, null);';
  EdgeBrowser1.ExecuteScript(S);
end;

procedure TFrameEdgeEditor.AcbgColorExecute(Sender: TObject);
var
  S: string;
begin
  //�ĵ�����ɫ���������� Edge ����Ч��
  if ColorDialog1.Execute then
  begin
    S := ColorToWebColorStr(ColorDialog1.Color);
    S := 'document.execCommand("backColor", True, ' + QuotedStr(S) + ')';

    EdgeBrowser1.ExecuteScript(S);
  end;
end;

procedure TFrameEdgeEditor.AcBoldExecute(Sender: TObject);
var
  S: string;
begin
  S := 'document.execCommand("bold", false, null);';  //��Ӧ�� IE �Ľӿ����FDocument.execCommand('Bold',False,0);
  EdgeBrowser1.ExecuteScript(S);
end;

procedure TFrameEdgeEditor.AcBulletsExecute(Sender: TObject);
var
  S, S2: string;
  SL: TStringList;
  i: Integer;
begin
  //�ص�  ���������� delphi �ӱ�ǩ��д��ȥ��
  S := 'document.execCommand("Copy", false, null);';
  EdgeBrowser1.ExecuteScript(S);
  Sleep(100);

  S2 := Clipboard.AsText;
  SL := TStringList.Create;
  try
    SL.Text := S2;

    S2 := '<ul>';
    for i := 0 to SL.Count -1 do
    begin
      S2 := S2 + '<li>' + SL[i] + '</li>';
    end;

    S2 := S2 + '</ul>';
  finally
    SL.Free;
  end;



  S2 := 'document.execCommand("InsertHTML", false, '+ QuotedStr(S2) + ')';
  EdgeBrowser1.ExecuteScript(S2);
end;

procedure TFrameEdgeEditor.AcDeleteLinkExecute(Sender: TObject);
var
  S: string;
begin
  //ȥ������
  S := 'document.execCommand("unlink", false, null);';
  EdgeBrowser1.ExecuteScript(S);
end;

procedure TFrameEdgeEditor.AcFontBackColorExecute(Sender: TObject);
var
  S: string;
begin
  //���屳��ɫ
  if ColorDialog1.Execute then
  begin
    S := ColorToWebColorStr(ColorDialog1.Color);
    S := 'document.execCommand("hiliteColor", false, ' + QuotedStr(S) + ')';

    EdgeBrowser1.ExecuteScript(S);
  end;
end;

procedure TFrameEdgeEditor.AcFontColorExecute(Sender: TObject);
var
  S: string;
begin
  //������ɫ
  if ColorDialog1.Execute then
  begin
    S := ColorToWebColorStr(ColorDialog1.Color);
    S := 'document.execCommand("foreColor", false, ' + QuotedStr(S) + ')';

    EdgeBrowser1.ExecuteScript(S);
  end;
end;

procedure TFrameEdgeEditor.AcHideToolPanelExecute(Sender: TObject);
begin
  JvToolBar2.Visible := not JvToolBar2.Visible;
end;

procedure TFrameEdgeEditor.AcHighLightCodeExecute(Sender: TObject);
begin
  EdgeBrowser1.ExecuteScript('hljs.highlightAll();');
end;

procedure TFrameEdgeEditor.AcInsertCodeExecute(Sender: TObject);
var
  S: string;
begin
  //��������
  S := '<pre><code class="language-delphi"></code></pre>';

  S := 'document.execCommand("InsertHTML", false, '+ QuotedStr(S) + ')';
  EdgeBrowser1.ExecuteScript(S);

  Sleep(100);
  EdgeBrowser1.ExecuteScript('hljs.highlightAll();');
end;

procedure TFrameEdgeEditor.AcInsertLineExecute(Sender: TObject);
var
  S: string;
begin
  S := 'document.execCommand("insertHorizontalRule", false, null)';
  EdgeBrowser1.ExecuteScript(S);
end;

procedure TFrameEdgeEditor.AcInsertTableExecute(Sender: TObject);
var
  S: string;
  Rows, Cols, AWidth: Integer;
  TableAlign: TAlign;
  i, j: Integer;
  AlignStr: string;
begin
  //���� Table ���û�ж�Ӧ�� JS��������Ҫ������������ HTML ���롣
  //���´�������˷��� index.html ����� CSS
  TFmTableProperty.GetForm.ShowModal;
  TFmTableProperty.GetForm.GetTableParams(Rows,Cols, AWidth, TableAlign);

  AlignStr := 'center';

  case TableAlign of
    alNone: ;
    alTop: ;
    alBottom: ;
    alLeft: AlignStr := 'left';
    alRight: AlignStr := 'right';
    alClient: AlignStr := 'center';
    alCustom: ;
  end;

  S := '<table class="pure-table pure-table-bordered" width="' + AWidth.ToString +'"  align="' + AlignStr + '" >' +
    '<thead><tr>';
  for j := 0 to Cols -1 do
  begin
    S := S + '<th>#</th>';
  end;

  S := S + '</tr></thead>';
  S := S + '<tbody>';
  for i := 0 to Rows -1 do
  begin
    S := S + '<tr>';

    for j := 0  to Cols -1 do
    begin
      S := S + '<td>#</td>';
    end;

    S := S + '</tr>';
  end;

  S := S + '</tbody></table>';


  S := 'document.execCommand("insertHTML", false,' + QuotedStr(S) + ');';
  EdgeBrowser1.ExecuteScript(S);
end;

procedure TFrameEdgeEditor.AcItalicExecute(Sender: TObject);
var
  S: string;
begin
  S := 'document.execCommand("italic", false, null);';
  EdgeBrowser1.ExecuteScript(S);
end;

procedure TFrameEdgeEditor.AcNumberingExecute(Sender: TObject);
var
  S, S2: string;
  SL: TStringList;
  i: Integer;
begin
  //���ֵ�  ���������� delphi �ӱ�ǩ��д��ȥ��
  S := 'document.execCommand("Copy", false, null);';
  EdgeBrowser1.ExecuteScript(S);
  Sleep(100);

  S2 := Clipboard.AsText;
  SL := TStringList.Create;
  try
    SL.Text := S2;

    S2 := '<ol>';
    for i := 0 to SL.Count -1 do
    begin
      S2 := S2 + '<li>' + SL[i] + '</li>';
    end;

    S2 := S2 + '</ol>';
  finally
    SL.Free;
  end;



  S2 := 'document.execCommand("InsertHTML", false, '+ QuotedStr(S2) + ')';
  EdgeBrowser1.ExecuteScript(S2);
end;

procedure TFrameEdgeEditor.AcOpenExecute(Sender: TObject);
var
  SL: TStringList;
begin
  //��һ�������򱣴����ҳ
  if OpenDialog1.Execute() then
  begin
    EdgeBrowser1.Navigate(OpenDialog1.FileName);
  end;
end;

procedure TFrameEdgeEditor.AcPicAddExecute(Sender: TObject);
var
  S, AFileName, FileType: string;
  i: Integer;
begin
  //���뱾��ͼƬ�������ͼƬ��Ϊ��Ƕ����д��
  if OpenDialog1.Execute then AFileName := OpenDialog1.FileName
  else Exit;

  Self.DoInsertLocalImage(AFileName);
end;

procedure TFrameEdgeEditor.AcPicResizeExecute(Sender: TObject);
var
  S: string;
begin
  //ͼƬ��С�������á�����
  S := 'document.execCommand("enableObjectResizing", true, null);'; //������� WebKit ��֧�֣���� Edge ҲûЧ����
  EdgeBrowser1.ExecuteScript(S);
end;

procedure TFrameEdgeEditor.AcRemoveFormatExecute(Sender: TObject);
var
  S: string;
begin
  //ȥ����ʽ removeFormat
  S := 'document.execCommand("removeFormat", false, null);';
  EdgeBrowser1.ExecuteScript(S);
end;

procedure TFrameEdgeEditor.AcScreenCatchExecute(Sender: TObject);
begin
  //��Ļ��ͼ
  if not Assigned(FmFullScreen) then
    FmFullScreen := TFmFullScreen.Create(Application);

  FmFullScreen.NLAfterCatchScreen := DoAfterCatchScreen;
  FmFullScreen.Go;
end;

procedure TFrameEdgeEditor.AcStrikeoutExecute(Sender: TObject);
var
  S: string;
begin
  //ɾ����
  S := 'document.execCommand("strikeThrough", false, null);';
  EdgeBrowser1.ExecuteScript(S);
end;

procedure TFrameEdgeEditor.AcSubscriptExecute(Sender: TObject);
var
  S: string;
begin
  //�±�
  S := 'document.execCommand("subscript", false, null);';
  EdgeBrowser1.ExecuteScript(S);
end;

procedure TFrameEdgeEditor.AcUnderLineExecute(Sender: TObject);
var
  S: string;
begin
  //�»���
  S := 'document.execCommand("underline", false, null);';
  EdgeBrowser1.ExecuteScript(S);
end;

procedure TFrameEdgeEditor.AcUperScriptExecute(Sender: TObject);
var
  S: string;
begin
  //�ϱ� superscript
  S := 'document.execCommand("superscript", false, null);';
  EdgeBrowser1.ExecuteScript(S);
end;

procedure TFrameEdgeEditor.ComboBox1Change(Sender: TObject);
var
  S, S1, S2: string;
begin
  //���´��룬���Գɹ�������ʱ���ƺ���û��Ч����
  //����
  if ComboBox1.ItemIndex = -1 then Exit;

  S := 'H' + (ComboBox1.ItemIndex + 1).ToString;

  if S = '' then Exit;

  S1 := 'document.execCommand("copy", false, null)';
  EdgeBrowser1.ExecuteScript(S1);

  Sleep(100); //�ȴ������ִ�� COPY ��ɡ���Ϊ�����������һ���߳���ִ�� JS
  S2 := '<' + S + '>' + Clipboard.AsText + '</' + S + '>';
  S2 := 'document.execCommand("InsertHTML", false, '+ QuotedStr(S2) + ')';
  EdgeBrowser1.ExecuteScript(S2);
end;

procedure TFrameEdgeEditor.DoAfterCatchScreen(const AFileName: string);
begin
  FmFullScreen.Close;
  if FileExists(AFileName) then
  begin
    //��ͼ����༭��
    Self.DoInsertLocalImage(AFileName);
  end;
end;

procedure TFrameEdgeEditor.DoInsertLocalImage(const AFileName: string);
var
  S, FileType, PicBase64: string;
begin
  PicBase64 := Self.GetFileBase64(AFileName, FileType);
  S := 'data:image/' + FileType + ';base64,' + PicBase64;

  //S := '<image src=' + '''' + 'data:image/' + FileType + ';base64,' + Base64 + '''' + ' />';

  S := 'document.execCommand("InsertImage", false, ' + QuotedStr(S) + ')';

  //S := 'document.execCommand("InsertHTML", false, '+ QuotedStr(S) + ')';

  EdgeBrowser1.ExecuteScript(S);
end;

procedure TFrameEdgeEditor.EdgeBrowser1Enter(Sender: TObject);
begin
  if FEditMode then Exit;

  TTask.Run(
    procedure
    begin
      TThread.Synchronize(nil,
        procedure
        begin
          EdgeBrowser1.ExecuteScript('document.designMode = "On"');  //ExecuteScript �������������߳�ִ�С��߳�ִ��û���κη�Ӧ��
        end
      );

      if FEvent.WaitFor(3000) =  TWaitResult.wrSignaled then
      begin
        FEditMode := UpperCase(FScriptReturn) = 'ON';
      end;
    end
  );
end;

procedure TFrameEdgeEditor.EdgeBrowser1ExecuteScript(Sender: TCustomEdgeBrowser;
  AResult: HRESULT; const AResultObjectAsJson: string);
var
  i: Integer;
begin
  //�յ����ַ����Ž����壻
  if AResultObjectAsJson = 'null' then
  begin
    FEvent.SetEvent;
    //FEvent.ResetEvent;
    Exit;
  end;

  FScriptReturn := TNetEncoding.URL.Decode(AResultObjectAsJson); //.DeQuotedString('"'); ����� HTML ��ͷβ��˫���š���������� DeQuotedString ���������������������˫���Ŷ��ɵ��ˡ�

  //ȥ��ͷβ��˫���ţ����⣺�ַ����� 0 ��ʼ���Ǵ� 1 ��ʼ�� �������ԣ�VCL �����ַ����Ǵ� 1 ��ʼ���� Remove �Ǵ� 0 ��ʼ��
  FScriptReturn := FScriptReturn.Remove(0, 1);
  FScriptReturn := FScriptReturn.Remove(Length(FScriptReturn) -1, 1);



  if Assigned(FJsHTMLContent) then FJsHTMLContent.DoOnScript(FScriptReturn);

  FEvent.SetEvent;
  //FEvent.ResetEvent;

  //ִ�� JS ���첽�ġ�����Ҫ JS ִ����ϲŻᴥ���������ﴥ���ƺ������̡߳�
  //���ﴥ����������̣߳����������������̣߳������ �����ˡ�
  //��ˣ���Ҫ���ﷵ�ص� JS ��ִ�У������߳�ȥ�����߳��������ȴ�������������
  //�����ſ��������ı�̡�
end;

procedure TFrameEdgeEditor.FileNewActnExecute(Sender: TObject);
var
  Fn: string;
begin
  //�½�
  Fn := TPath.Combine(Self.GetMyPath, 'index.html');
  EdgeBrowser1.Navigate(Fn);
  FEditMode := False;
end;

procedure TFrameEdgeEditor.FileSaveActnExecute(Sender: TObject);
var
  AFileName: string;
begin
  TTask.Run(
    procedure
    begin
      TThread.Synchronize(nil,
        procedure
        begin
          SendGetHTMLCmd; //�� JS ���������������������̡߳����ﲻ�����߳�ͬ����ִ��û�н����

          FJsHTMLContent.DoBeforeSave(AFileName);
        end
      );

      if FEvent.WaitFor(2000) = TWaitResult.wrSignaled then
      begin
        //�õ�Դ���룬��������ýӿڡ���Ҫ���ҳ��Դ�������ݵĵط���ʵ������ӿڡ�
        if Assigned(FJsHTMLContent) then
        begin
          FJsHTMLContent.GetHEMLSourceCode(FScriptReturn, AFileName);
        end;
      end;

      FEvent.ResetEvent;
    end
  );
end;

procedure TFrameEdgeEditor.FontComboBox1Change(Sender: TObject);
var
  S: string;
begin
  //����
  S := 'document.execCommand("fontName", false, ' + QuotedStr(FontComboBox1.FontName) + ')';
  EdgeBrowser1.ExecuteScript(S);
end;

function TFrameEdgeEditor.GetFileBase64(const AFileName: string; var FileType: string): string;
var
  StrStream: TStringStream;
  FileStream: TFileStream;
begin
{----------------------------------------------------------------------------
    ���� Delphi �ٷ��ı��뺯����������лس����з�
    Result := EncodeBase64(MemoryStream.Memory, MemoryStream.Size);
    //base64Ĭ����һ��77�ַ�����һ�Σ���TCP����ʱ�����㣬��ȥ���˻س����С�
    Result := StringReplace(Result, #13, '', [rfReplaceAll]);
    Result := StringReplace(Result, #10, '', [rfReplaceAll]);

    //TNetEncoding.Base64.Encode(FileStream, StrStream);
    // TNetEncoding ����Ľ�������м���˺ܶ�س����з��ţ���ΪͼƬ���ݣ�������޷���ʾ��
-------------------------------------------------------------------------------}
  Result := '';

  FileType := TPath.GetExtension(AFileName);
  FileType := FileType.Remove(0, 1); //ȥ��ǰ��ĵ�
  FileStream := TFileStream.Create(AFileName, fmOpenRead);
  StrStream := TStringStream.Create;
  try
    FileStream.Position := 0;
    IdEncoderMIME1.Encode(FileStream, StrStream); //IdEncodeMiMe ��������ݣ�������ܹ�������ʾ��
    Result := StrStream.DataString;

    Result := StringReplace(Result, #13, '', [rfReplaceAll]);
    Result := StringReplace(Result, #10, '', [rfReplaceAll]);
  finally
    FileStream.Free;
    StrStream.Free;
  end;
end;

function TFrameEdgeEditor.GetMyPath: string;
begin
  Result := ExtractFilePath(ParamStr(0));
end;

procedure TFrameEdgeEditor.IniUI;
var
  i: Integer;
begin
  for i := 0 to Self.ComponentCount -1 do
  begin
    if (Self.Components[i] is TJvTransparentButton) then
    begin
      TJvTransparentButton(Self.Components[i]).Caption := '';
    end;

  end;

  JvToolBar2.Top := 30;

  FEvent := TEvent.Create();
end;


procedure TFrameEdgeEditor.SendGetHTMLCmd;
var
  S: string;
begin
  //S := 'encodeURI(document.documentElement.outerHTML)'; encodeURI ��ɵ��Ӻţ��Լ�б�ܺ����˫���š��ᵼ����ǶͼƬ�޷���ʾ��
  S := 'encodeURIComponent(document.documentElement.outerHTML)';
  EdgeBrowser1.ExecuteScript(S);
end;

procedure TFrameEdgeEditor.SpinEdit1Change(Sender: TObject);
var
  i: Integer;
  S: string;
begin
  i := Trunc(SpinEdit1.Value);
  S := 'document.execCommand("FontSize", false, ' + i.ToString + ')';
  EdgeBrowser1.ExecuteScript(S);
end;

end.
