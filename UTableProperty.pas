unit UTableProperty;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask,
  Vcl.Buttons, JvExStdCtrls, JvCombobox, JvColorCombo, JvExMask, JvSpin;

type
  TFmTableProperty = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    SpinEdit1: TJvSpinEdit;
    SpinEdit2: TJvSpinEdit;
    SpinEdit3: TJvSpinEdit;
    BtnOK: TBitBtn;
    BtnCancel: TBitBtn;
    Label4: TLabel;
    ComboBox1: TComboBox;
  private
    { Private declarations }
  public
    { Public declarations }
    class function GetForm: TFmTableProperty;


    procedure GetTableParams(var ARows, ACols, AWidth: Integer; var TableAlign: TAlign);
  end;

var
  FmTableProperty: TFmTableProperty;

implementation

{$R *.dfm}

{ TFmTableProperty }

class function TFmTableProperty.GetForm: TFmTableProperty;
begin
  if not Assigned(FmTableProperty) then
    FmTableProperty := TFmTableProperty.Create(Application);


  Result := FmTableProperty;
end;


procedure TFmTableProperty.GetTableParams(var ARows, ACols, AWidth: Integer;
  var TableAlign: TAlign);
begin
  ARows := Trunc(SpinEdit1.Value);
  ACols := Trunc(SpinEdit2.Value);
  AWidth := Trunc(SpinEdit3.Value);

  case ComboBox1.ItemIndex of
    0: TableAlign := TAlign.alLeft;
    1: TableAlign := TAlign.alClient;  //用 Client 拿来当作居中。
    2: TableAlign := TAlign.alRight;
  end;
end;

end.
