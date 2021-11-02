program JSEditorNote;

uses
  Vcl.Forms,
  Web.WebReq,
  IdHTTPWebBrokerBridge,
  UFrameEdgeEditor in 'UFrameEdgeEditor.pas' {FrameEdgeEditor: TFrame},
  UForm2 in 'UForm2.pas' {Form2},
  UFmFullScreen in 'UFmFullScreen.pas' {FmFullScreen},
  UTableProperty in 'UTableProperty.pas' {FmTableProperty},
  WebModuleUnit1 in 'WebModuleUnit1.pas' {WebModule1: TWebModule},
  UDmWebServer in 'UDmWebServer.pas' {DmWebServer: TDataModule};

{$R *.res}

begin
  if WebRequestHandler <> nil then
    WebRequestHandler.WebModuleClass := WebModuleClass;  //for WebBroker

  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm2, Form2);
  Application.CreateForm(TFmTableProperty, FmTableProperty);
  Application.CreateForm(TDmWebServer, DmWebServer);
  //Application.CreateForm(TFmFullScreen, FmFullScreen);
  Application.Run;
end.
