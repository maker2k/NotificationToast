Сервер создавался по аналогии c:
http://www.delphisite.ru/faq/sozdanie-com-servera
в теории, можно и так (dll-simple):
http://delphiru.ru/resources/26-creating-and-using-dll-from-delphi


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

Для использованиия dll смотрим пример source\d5\
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

в реализация варианта #2 (dll-simple)
1: подключаем функцию из dll
function ShowNotificationToast(const title, msg: WideString): HResult; external '\source\d10\dll-simple\Win32\Debug\NotificationToastDll.dll'
2: и используем ShowNotificationToast('title', ed1.text);

Альтернативный пример варианта уведомлений с полной поддержкой шаблонов XML в '\source\d10ConsoleNotifier\'