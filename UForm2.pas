unit UForm2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UFrameEdgeEditor, Vcl.ComCtrls,
  Vcl.StdCtrls;

type
  TForm2 = class(TForm, IJsHTMLContent)
    FrameEdgeEditor1: TFrameEdgeEditor;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Memo1: TMemo;
    SaveDialog1: TSaveDialog;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    procedure DoOnScript(HTML: string);
  public
    { Public declarations }
    procedure GetHEMLSourceCode(const HTML: string; var AFileName: string);
    procedure DoBeforeSave(var AFileName: string);
  end;

var
  Form2: TForm2;

implementation

uses System.IOUtils;

{$R *.dfm}

procedure TForm2.DoBeforeSave(var AFileName: string);
begin
  AFileName := '';

  if SaveDialog1.Execute then
  begin
    AFileName := SaveDialog1.FileName;
  end;
end;

procedure TForm2.DoOnScript(HTML: string);
begin
  Memo1.Lines.Add(HTML);
end;

procedure TForm2.FormShow(Sender: TObject);
begin
  FrameEdgeEditor1.IniUI;
  FrameEdgeEditor1.JsHTMLContent := Self as IJsHTMLContent;
  Self.Menu := FrameEdgeEditor1.MainMenu1;
end;

procedure TForm2.GetHEMLSourceCode(const HTML: string; var AFileName: string);
var
  SL: TStringList;
begin
  SL := TStringList.Create;
  try
    SL.Text := HTML;

    if AFileName = '' then AFileName := TPath.Combine(ExtractFilePath(Application.ExeName), 'MyContent.html');

    SL.SaveToFile(AFileName);
  finally
    SL.Free;
  end;
end;

end.
