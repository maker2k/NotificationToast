Сервер создавался по аналогии c:
http://www.delphisite.ru/faq/sozdanie-com-servera


Регистрация и снятие регистрации Dll в системе
https://ab57.ru/cmdlist/regsvr32.html


Смена "непонятного" заголовка "Embarcadero.DesktopToasts.*" 

на мысль натолкнула статья 
https://www.board4all.biz/threads/notifications-on-windows-10.713436/

сама маска заголовка прописан в System.Win.Notification
для его смены для проета, необходимо переместить файл этот файл 
в папку с проектом и заменить константу на необходимую.

---
Для регистрации DLL необходимо запустить source\d10\dll\Win32\Debug\register.bat 
с правами администратора.

Для использованиия dll необходим смотрим пример source\d5\
или вкратце: source\d5\NotificationToastExport_TLB.pas (он такой же как и в 
source\d10\dll\NotificationToastExport_TLB.pas) только используются "старые" 
модули в uses.

1. в uses добаляем ComObj, NotificationToastExport_TLB
2. в var модуля опишем NotificationToast: INotificationToast
3. в обработчике кнопки примерно такой код:

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