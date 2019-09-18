object fmMain: TfmMain
  Left = 0
  Top = 0
  Caption = 'Win10 Action Centre'
  ClientHeight = 144
  ClientWidth = 274
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object lblAC: TLabel
    Left = 189
    Top = 92
    Width = 66
    Height = 13
    Caption = 'Action Centre'
  end
  object lblRegKeyExists: TLabel
    Left = 8
    Top = 8
    Width = 3
    Height = 13
  end
  object btnShowNotification: TButton
    Left = 8
    Top = 111
    Width = 97
    Height = 25
    Caption = 'Show Notification'
    TabOrder = 0
    OnClick = btnShowNotificationClick
  end
  object btnToggleActionCentre: TButton
    Left = 185
    Top = 111
    Width = 75
    Height = 25
    Caption = 'Enable'
    TabOrder = 1
    OnClick = btnToggleActionCentreClick
  end
  object NotificationCenter1: TNotificationCenter
    Left = 128
    Top = 32
  end
end
