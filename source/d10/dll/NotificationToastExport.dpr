library NotificationToastExport;

uses
  ComServ,
  NotificationToastExport_TLB in 'NotificationToastExport_TLB.pas',
  uNotificationToast in 'uNotificationToast.pas' {NotificationToast: CoClass};

exports
  DllGetClassObject,
  DllCanUnloadNow,
  DllRegisterServer,
  DllUnregisterServer,
  DllInstall;

{$R *.TLB}

{$R *.RES}

begin
end.
