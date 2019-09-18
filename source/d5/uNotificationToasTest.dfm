object FmNotificationToastTest: TFmNotificationToastTest
  Left = 192
  Top = 125
  Width = 245
  Height = 137
  Caption = 'NotificationToasTest'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
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
    Left = 128
    Top = 48
    Width = 75
    Height = 25
    Caption = 'btn1'
    TabOrder = 1
    OnClick = btn1Click
  end
end
