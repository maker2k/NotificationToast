unit uNotificationToasTest;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComObj, NotificationToastExport_TLB, StdCtrls;

type
  TFmNotificationToastTest = class(TForm)
    ed1: TEdit;
    btn1: TButton;
    btn2: TButton;
    procedure btn1Click(Sender: TObject);
    procedure btn2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FmNotificationToastTest: TFmNotificationToastTest;
  NotificationToast: INotificationToast;

// вариант для dll-simple
function ShowNotificationToast(const title, msg: WideString): HResult; external 'd:\myProj\NotificationToast\source\d10\dll-simple\Win32\Debug\NotificationToastDll.dll'

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

procedure TFmNotificationToastTest.btn2Click(Sender: TObject);
begin
  ShowNotificationToast('title', ed1.text);
end;

end.
