{
You must register your application for "Show notifications in action center"
"HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Notifications\Settings\$prodName"
 -Name "ShowInActionCenter" -Type Dword -Value "1"
}
unit uNotify;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.Notification, Vcl.StdCtrls,
  System.Hash, System.Win.Registry, System.UITypes;

type
  TfmMain = class(TForm)
    NotificationCenter1: TNotificationCenter;
    btnShowNotification: TButton;
    btnToggleActionCentre: TButton;
    lblAC: TLabel;
    lblRegKeyExists: TLabel;
    procedure btnShowNotificationClick(Sender: TObject);
    function getRegisterToastMessageKey : String;
    procedure btnToggleActionCentreClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmMain: TfmMain;

procedure InsertKeysToReg(HKey: Cardinal; OurRegKeyPath, ourKey: string; NewKeyValue: integer);
procedure DeleteKeyFromReg(HKey: Cardinal; OurRegKeyPath: string);
function DoesRegKeyExist: Boolean;
procedure UpdateLabel;

implementation

var
  OurRegKeyPath: string;
  HKey: Cardinal = HKEY_CURRENT_USER;

{$R *.dfm}

procedure TfmMain.btnShowNotificationClick(Sender: TObject);
var
  AppNotification: TNotification;
begin
  AppNotification := NotificationCenter1.CreateNotification;
  try
    AppNotification.Name := 'Windows10Notification';
    AppNotification.Title := 'Windows 10 Notification #1';
    AppNotification.AlertBody := 'RAD Studio 10 Seattle';

    NotificationCenter1.PresentNotification(AppNotification);

  finally
    AppNotification.Free;
  end;
end;

procedure TfmMain.btnToggleActionCentreClick(Sender: TObject);
begin
  if btnToggleActionCentre.Caption = 'Enable' then
  begin
    btnToggleActionCentre.Caption := 'Disable';
    InsertKeysToReg(HKey, OurRegKeyPath, 'ShowInActionCenter', 1);
  end
  else
  begin
    DeleteKeyFromReg(HKey, OurRegKeyPath);
    btnToggleActionCentre.Caption := 'Enable';
  end;

  UpdateLabel;
end;

procedure TfmMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if DoesRegKeyExist then
  begin
    if MessageDlg('Remove RegKey before Exit?', mtConfirmation,
        [mbYes, mbNo], 0) = mrYes then DeleteKeyFromReg(HKey, OurRegKeyPath);
  end;
end;

procedure TfmMain.FormCreate(Sender: TObject);
begin
  UpdateLabel;
end;

procedure InsertKeysToReg(HKey: Cardinal; OurRegKeyPath, ourKey: string; NewKeyValue: integer);
var
  reg        : TRegistry;
  openResult : Boolean;
begin
  reg := TRegistry.Create(KEY_READ OR KEY_WOW64_64KEY);
  reg.RootKey := HKey; //HKEY_USERS; //HKEY_LOCAL_MACHINE;

  { Checking if the values exist and inserting when neccesary }
  reg.Access := KEY_WRITE;
  openResult := reg.OpenKey(OurRegKeyPath, True);

  if not openResult = True then
    begin
      MessageDlg('Unable to create key! Exiting.',
                  mtError, mbOKCancel, 0);
      Exit();
    end;

  try
    //reg.RootKey := HKEY_CURRENT_USER;
    if reg.OpenKey(OurRegKeyPath, true) then
    try
      reg.WriteInteger(ourKey, NewKeyValue);
    finally
      reg.CloseKey;
    end;
  finally
    reg.Free;
  end;

end;

procedure DeleteKeyFromReg(HKey: Cardinal; OurRegKeyPath: string);
var
  reg : TRegistry;
begin
  reg := TRegistry.Create(KEY_WRITE);
  reg.RootKey := HKey;

  reg.DeleteKey(OurRegKeyPath);

  reg.CloseKey();
  reg.Free;

end;

function TfmMain.getRegisterToastMessageKey : String;
const
  // It appears that you can't change this atm :(
  AppId = 'Embarcadero.DesktopToasts.';
begin
  result := AppId + THashBobJenkins.GetHashString(ParamStr(0));
end;

function DoesRegKeyExist: Boolean;
var
  reg:  TRegistry;
begin
  // Set the global variable
  Result := False;

  OurRegKeyPath := '\SOFTWARE\Microsoft\Windows\CurrentVersion\Notifications\Settings\';
  OurRegKeyPath := OurRegKeyPath + fmMain.getRegisterToastMessageKey; //$prodName

  reg := TRegistry.Create(KEY_READ);
  reg.RootKey := HKey;

  if reg.KeyExists(OurRegKeyPath) then Result := True;
end;

procedure UpdateLabel;
begin
  if DoesRegKeyExist then fmMain.lblRegKeyExists.Caption := 'Reg key is PRESENT'
  else fmMain.lblRegKeyExists.Caption := 'Reg key is ABSENT';
end;

end.