unit NotificationToastExport_TLB;

// ************************************************************************ //
// WARNING
// -------
// The types declared in this file were generated from data read from a
// Type Library. If this type library is explicitly or indirectly (via
// another type library referring to this type library) re-imported, or the
// 'Refresh' command of the Type Library Editor activated while editing the
// Type Library, the contents of this file will be regenerated and all
// manual modifications will be lost.
// ************************************************************************ //

// $Rev: 52393 $
// File generated on 18.09.2019 15:35:03 from Type Library described below.

// ************************************************************************  //
// Type Lib: Z:\NotificationToast\source\d10\dll\NotificationToastExport (1)
// LIBID: {A9D3FDA7-06F6-4BB5-928F-9499145D453D}
// LCID: 0
// Helpfile:
// HelpString:
// DepndLst:
//   (1) v2.0 stdole, (C:\Windows\SysWOW64\stdole2.tlb)
// SYS_KIND: SYS_WIN32
// ************************************************************************ //
{$TYPEDADDRESS OFF} // Unit must be compiled without type-checked pointers.
{$WARN SYMBOL_PLATFORM OFF}
{$WRITEABLECONST ON}
{$VARPROPSETTER ON}
{$ALIGN 4}

interface

// автосгенерированные библиотеки,
//uses Winapi.Windows, System.Classes, System.Variants, System.Win.StdVCL, Vcl.Graphics, Vcl.OleServer, Winapi.ActiveX;
uses  Winapi.ActiveX;


// *********************************************************************//
// GUIDS declared in the TypeLibrary. Following prefixes are used:
//   Type Libraries     : LIBID_xxxx
//   CoClasses          : CLASS_xxxx
//   DISPInterfaces     : DIID_xxxx
//   Non-DISP interfaces: IID_xxxx
// *********************************************************************//
const
  // TypeLibrary Major and minor versions
  NotificationToastExportMajorVersion = 1;
  NotificationToastExportMinorVersion = 0;

  LIBID_NotificationToastExport: TGUID = '{A9D3FDA7-06F6-4BB5-928F-9499145D453D}';

  IID_INotificationToast: TGUID = '{3ADF7763-9F0E-45B6-AC12-702C6C04B4E9}';
  CLASS_NotificationToast: TGUID = '{4219D790-B1CF-4BA3-A3C9-7A8C0784BFAD}';
type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary
// *********************************************************************//
  INotificationToast = interface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library
// (NOTE: Here we map each CoClass to its Default Interface)
// *********************************************************************//
  NotificationToast = INotificationToast;


// *********************************************************************//
// Interface: INotificationToast
// Flags:     (256) OleAutomation
// GUID:      {3ADF7763-9F0E-45B6-AC12-702C6C04B4E9}
// *********************************************************************//
  INotificationToast = interface(IUnknown)
    ['{3ADF7763-9F0E-45B6-AC12-702C6C04B4E9}']
    function Show(const msg: WideString): HResult; stdcall;
  end;

// *********************************************************************//
// The Class CoNotificationToast provides a Create and CreateRemote method to
// create instances of the default interface INotificationToast exposed by
// the CoClass NotificationToast. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoNotificationToast = class
    class function Create: INotificationToast;
    class function CreateRemote(const MachineName: string): INotificationToast;
  end;

implementation

uses System.Win.ComObj;

class function CoNotificationToast.Create: INotificationToast;
begin
  Result := CreateComObject(CLASS_NotificationToast) as INotificationToast;
end;

class function CoNotificationToast.CreateRemote(const MachineName: string): INotificationToast;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_NotificationToast) as INotificationToast;
end;

end.

