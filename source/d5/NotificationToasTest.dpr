program NotificationToasTest;

uses
  Forms,
  uNotificationToasTest in 'uNotificationToasTest.pas' {FmNotificationToastTest};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TFmNotificationToastTest, FmNotificationToastTest);
  Application.Run;
end.
