unit UDmWebServer;

interface

uses
  System.SysUtils, System.Classes, IdHTTPWebBrokerBridge, IdGlobal, Web.HTTPApp;

type
  TDmWebServer = class(TDataModule)
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    FServer: TIdHTTPWebBrokerBridge;
  public
    { Public declarations }
    procedure StartServer;
  end;

var
  DmWebServer: TDmWebServer;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TDmWebServer }

procedure TDmWebServer.DataModuleCreate(Sender: TObject);
begin
  StartServer;
end;

procedure TDmWebServer.StartServer;
begin
  FServer := TIdHTTPWebBrokerBridge.Create(Self);
  if not FServer.Active then
  begin
    FServer.Bindings.Clear;
    FServer.DefaultPort := 9898;
    FServer.Active := True;
  end;
end;

end.
