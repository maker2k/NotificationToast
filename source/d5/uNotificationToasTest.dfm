object FmNotificationToastTest: TFmNotificationToastTest
  Left = 192
  Top = 125
  Width = 245
  Height = 175
  BorderIcons = [biSystemMenu]
  Caption = 'NotificationToastTest'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object ed1: TEdit
    Left = 32
    Top = 16
    Width = 169
    Height = 21
    TabOrder = 0
    Text = 'ed1'
  end
  object btn1: TButton
    Left = 56
    Top = 48
    Width = 147
    Height = 25
    Caption = 'Создать уведомление #1'
    TabOrder = 1
    OnClick = btn1Click
  end
  object btn2: TButton
    Left = 56
    Top = 88
    Width = 145
    Height = 25
    Caption = 'Создать уведомление #2'
    TabOrder = 2
    OnClick = btn2Click
  end
end
