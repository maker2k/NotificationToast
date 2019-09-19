library NotificationToastDll;

{ Important note about DLL memory management: ShareMem must be the
  first unit in your library's USES clause AND your project's (select
  Project-View Source) USES clause if your DLL exports any procedures or
  functions that pass strings as parameters or function results. This
  applies to all strings passed to and from your DLL--even those that
  are nested in records and classes. ShareMem is the interface unit to
  the BORLNDMM.DLL shared memory manager, which must be deployed along
  with your DLL. To avoid using BORLNDMM.DLL, pass string information
  using PChar or ShortString parameters. }

uses
  System.SysUtils,
  System.Classes,
  System.Notification;

{$R *.res}

function ShowNotificationToast(const title, msg: WideString): HResult;  export;
var
  NotificationCenter: TNotificationCenter;
  Notification: TNotification;
begin
  NotificationCenter := TNotificationCenter.Create(nil);
  Notification := NotificationCenter.CreateNotification;
  try
    Notification.Name := 'Windows10Notification';
    Notification.Title := title;
    Notification.AlertBody := msg;

    NotificationCenter.PresentNotification(Notification);

    Result := S_OK;
  finally
    Notification.Free;
    NotificationCenter.Free
  end;
end;

exports ShowNotificationToast;

end.
