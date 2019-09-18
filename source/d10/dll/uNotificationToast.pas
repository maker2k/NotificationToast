unit uNotificationToast;

{$WARN SYMBOL_PLATFORM OFF}

interface

uses
  Windows, ActiveX, Classes, ComObj, NotificationToastExport_TLB, StdVcl,
  System.Notification, System.SysUtils;


type
  TNotificationToast = class(TTypedComObject, INotificationToast)
  private
    FCnt: Integer;
    FNotificationCenter: TNotificationCenter;
  protected
    function Show(const msg: WideString): HResult; stdcall;
  public
    procedure Initialize; override;
    destructor Destroy; override;
  end;

implementation

uses ComServ;

{ TNotificationToast }

destructor TNotificationToast.Destroy;
begin
  FNotificationCenter.Free;
  inherited;
end;

procedure TNotificationToast.Initialize;
begin
  inherited;
  FCnt := 1;
  FNotificationCenter := TNotificationCenter.Create(nil);
end;

function TNotificationToast.Show(const msg: WideString): HResult;
var
  Notification: TNotification;
begin
  Notification := FNotificationCenter.CreateNotification;
  try
    Notification.Name := 'Windows10Notification';
    Notification.Title := 'Windows 10 Notification #' + IntToStr(FCnt);
    Notification.AlertBody := msg;
    inc(FCnt);

    FNotificationCenter.PresentNotification(Notification);

    Result := S_OK;
  finally
    Notification.Free;
  end;
end;

initialization
  TTypedComObjectFactory.Create(ComServer, TNotificationToast, Class_NotificationToast,
    ciMultiInstance, tmApartment);
end.
