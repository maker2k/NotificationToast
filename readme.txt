������ ���������� �� �������� c:
http://www.delphisite.ru/faq/sozdanie-com-servera


����������� � ������ ����������� Dll � �������
https://ab57.ru/cmdlist/regsvr32.html


����� "�����������" ��������� "Embarcadero.DesktopToasts.*" 

�� ����� ���������� ������ 
https://www.board4all.biz/threads/notifications-on-windows-10.713436/

���� ����� ��������� �������� � System.Win.Notification
��� ��� ����� ��� ������, ���������� ����������� ���� ���� ���� 
� ����� � �������� � �������� ��������� �� �����������.

---
��� ����������� DLL ���������� ��������� source\d10\dll\Win32\Debug\register.bat 
� ������� ��������������.

��� �������������� dll ��������� ������� ������ source\d5\
��� �������: source\d5\NotificationToastExport_TLB.pas (�� ����� �� ��� � � 
source\d10\dll\NotificationToastExport_TLB.pas) ������ ������������ "������" 
������ � uses.

1. � uses �������� ComObj, NotificationToastExport_TLB
2. � var ������ ������ NotificationToast: INotificationToast
3. � ����������� ������ �������� ����� ���:

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

