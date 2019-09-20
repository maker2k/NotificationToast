program ConsoleNotifier;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  WinAPI.WinRT,
  WinAPI.DataRT,
  WinAPI.UI.Notifications,
  WinAPI.ActiveX,
  WinAPI.CommonTypes,
  WinAPI.PropKey,
  WinAPI.PropSys,
  WinAPI.ShlObj,
  System.Win.ComObj,
  Windows;

function CreateDesktopShellLink(const TargetName: string): Boolean;

  function GetStartMenuFolder: string;
  var
    Buffer: array [0 .. MAX_PATH - 1] of Char;
  begin
    Result := '';
    GetEnvironmentVariable(PChar('APPDATA'), Buffer, MAX_PATH - 1);
    Result := Buffer + '\Microsoft\Windows\Start Menu\Programs\Desktop Delphi Toasts App.lnk';
  end;

var
  IObject: IUnknown;
  ISLink: IShellLink;
  IPFile: IPersistFile;
  LinkName: string;

  LStore: WinAPI.PropSys.IPropertyStore;
  LValue: TPropVariant;
begin
  Result := False;

  IObject := CreateComObject(CLSID_ShellLink);
  ISLink := IObject as IShellLink;
  IPFile := IObject as IPersistFile;
  LStore := IObject as WinAPI.PropSys.IPropertyStore;

  with ISLink do
  begin
    SetPath(PChar(ParamStr(0)));
  end;
  ISLink.SetArguments(PChar(''));

  if Succeeded(InitPropVariantFromStringAsVector(PWideChar('Delphi.DesktopNotification.Sample'), LValue)) then
  begin
    if Succeeded(LStore.SetValue(PKEY_AppUserModel_ID, LValue)) then
      LStore.Commit;
  end;

  LinkName := GetStartMenuFolder;

  if not FileExists(LinkName) then
    if IPFile.Save(PWideChar(LinkName), True) = S_OK then
      Result := True;
end;

function HStr(Value: String): HString;
begin
  if NOT Succeeded(
    WindowsCreateString(PWideChar(Value), Length(Value), Result)
  )
  then raise Exception.CreateFmt('Unable to create HString for %s', [Value]);
end;

function ToastTemplateToString( Const Template:Xml_Dom_IXmlDocument ): String;

  function HStringToString(Src: HSTRING): String;
  var
    c: Cardinal;
  begin
    c := WindowsGetStringLen(Src);
    Result := WindowsGetStringRawBuffer(Src, @c);
  end;

begin
  Result := HStringToString(
    (Template.DocumentElement as Xml_Dom_IXmlNodeSerializer).GetXml
  );
end;

function GetFactory(Const Name:String; Const GUID:String): IInspectable;
var
  FactoryHString : HString;
  FactoryGUID    : TGUID;
begin
  FactoryHString := HStr(Name);
  try
    FactoryGUID := TGUID.Create(GUID);

    if NOT Succeeded(
      RoGetActivationFactory(FactoryHString, FactoryGUID, Result)
    )
    then raise Exception.CreateFmt('Error creating factory: %s %s', [Name, GUID]);
  finally
    WindowsDeleteString( FactoryHString );
  end;
end;

procedure OverwriteToastTemplateXML(Const Template: Xml_Dom_IXmlDocument; Const XML:String);
var
  hXML: HSTRING;
begin
  hXML := HStr(XML);
  try
    (Template as Xml_Dom_IXmlDocumentIO).LoadXml(hXML);
  finally
    WindowsDeleteString(hXML);
  end;
end;

procedure SteveNotification(Const AppID: String; Const XML: String);
var
  ToastNotificationManagerStatics : IToastNotificationManagerStatics;
  ToastTemplate                   : Xml_Dom_IXmlDocument;
  LToastNotification              : IToastNotification;
  ToastNotificationManagerFactory : IInspectable;
  ToastNotificationFactory        : IInspectable;
  hAppID                          : HString;
begin
  ToastNotificationManagerFactory := GetFactory(sToastNotificationManager, '{50AC103F-D235-4598-BBEF-98FE4D1A3AD4}');
  ToastNotificationManagerStatics := IToastNotificationManagerStatics(ToastNotificationManagerFactory);
  ToastTemplate := ToastNotificationManagerStatics.GetTemplateContent(ToastTemplateType.ToastText01);

  OverwriteToastTemplateXML(ToastTemplate, XML);

  WriteLn('XML: ', ToastTemplateToString(ToastTemplate));

  ToastNotificationFactory := GetFactory(SToastNotification, '{04124B20-82C6-4229-B109-FD9ED4662B53}');

  LToastNotification := IToastNotificationFactory(ToastNotificationFactory).CreateToastNotification(ToastTemplate);

  hAppID := HStr(AppID);
  try
    ToastNotificationManagerStatics
    .CreateToastNotifier(hAppID)
    .Show(LToastNotification);
  finally
    WindowsDeleteString(hAppID);
  end;
end;

Const
  AppID = 'My Application ID';
  XML   = '<toast activationType="protocol" launch="http://www.ecutek.com" >'
        + '  <visual>'
        + '    <binding template="ToastGeneric">'
        + '      <text>Body Text ABC</text>'
        + '      <text>More Text</text>'
        + '      <image placement="hero" src="file:///d:\notifications-bell.jpg"/>'
        + '    </binding>'
        + '  </visual>'
        + '  <actions>'
        + '    <action content="Open Google" activationType="protocol" arguments="http://www.google.com" />'
        + '  </actions>'
        + '</toast>';

var
  c: char;
begin
  try
    if TOSVersion.Major < 10 then
      raise Exception.Create('Windows 10 Required');

    RoInitialize(RO_INIT_MULTITHREADED);

    CreateDesktopShellLink(ParamStr(0));

    SteveNotification(AppID, XML);

    // Wait for a KeyPress
    Read(c);
    write(c);
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
