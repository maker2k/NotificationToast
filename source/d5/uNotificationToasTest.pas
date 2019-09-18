unit uNotificationToasTest;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComObj, NotificationToastExport_TLB, StdCtrls;

type
  TFmNotificationToastTest = class(TForm)
    ed1: TEdit;
    btn1: TButton;
    procedure btn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FmNotificationToastTest: TFmNotificationToastTest;
  NotificationToast: INotificationToast;

implementation

{$R *.DFM}

procedure TFmNotificationToastTest.btn1Click(Sender: TObject);
begin
  if Assigned(NotificationToast) then
  begin
    NotificationToast.Show(ed1.Text)
  end
  else
  begin
    NotificationToast := CreateComObject(CLASS_NotificationToast) as INotificationToast;
    if Assigned(NotificationToast) then
    begin
      NotificationToast.Show(ed1.Text)
    end
  end;
end;

end.
