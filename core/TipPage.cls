VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "TipPage"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
'======================================
'   ҳ�������
    Dim Page As GPage
    Dim CtrlText As String, GoalText As String, RequireText As String, MyGame As String
'======================================

Public Sub Update()
    '��Ϸÿһ֡�Ĺ��̣����ƹ�������ڴ˴���
    
    Page.Clear '��ջ���

    Page.DrawImage "bg.png", 0, 0, alpha:=1
    
    Page.Paint 0, GW / 2, GH / 2, 800, 500, argb(220, 255, 255, 255), Pos:=posOnCenter
    Page.Paint 0, GW / 2 - 400, GH / 2 - 250, 800, 50, argb(255, 0, 190, 169)
    Page.Writes "��Ϸ��ʽ��ʼ", GW / 2, GH / 2 - 250 + 12, 18, argb(255, 27, 27, 27), align:=StringAlignmentCenter
    
    Page.Writes "����", GW / 2 - 400 + 40, GH / 2 - 250 + 90, 18, argb(255, 27, 27, 27), style:=FontStyleBold
    Page.Writes CtrlText, GW / 2 - 400 + 60 + 60, GH / 2 - 250 + 90, 18, argb(170, 27, 27, 27)
    Page.Writes "Ŀ��", GW / 2 - 400 + 40, GH / 2 - 250 + 90 + 90, 18, argb(255, 27, 27, 27), style:=FontStyleBold
    Page.Writes GoalText, GW / 2 - 400 + 60 + 60, GH / 2 - 250 + 90 + 90, 18, argb(170, 27, 27, 27)
    Page.Writes "����", GW / 2 - 400 + 40, GH / 2 - 250 + 90 + 180, 18, argb(255, 27, 27, 27), style:=FontStyleBold
    Page.Writes RequireText, GW / 2 - 400 + 60 + 60, GH / 2 - 250 + 90 + 180, 18, argb(170, 27, 27, 27)
    
    If Page.ShowColorButton(0, GW / 2 - 70, GH - 190, 140, 40, "�õ�", argb(255, 0, 0, 0), argb(255, 0, 190, 169), argb(255, 50, 202, 185), Size:=18) = 3 Then
        Call GoGame
    End If
End Sub
Public Sub GoGame()
    Select Case MyGame
        Case "novel"
            ECore.NewTransform transFallDark, 1000, "NovelPage"
        Case "snowstorm"
            MazePage.LoadMap "snowstorm"
            ECore.NewTransform transFallDark, 3000, "MazePage"
        Case "snowman"
            ECore.NewTransform transFallDark, 3000, "SnowmanPage"
        Case "mazesnow"
            MazePage.LoadMap "snow"
            ECore.NewTransform transFallDark, 3000, "MazePage"
        Case "maze"
            MazePage.LoadMap
            ECore.NewTransform transFallDark, 3000, "MazePage"
        Case "battle"
            ECore.NewTransform transFallDark, 3000, "BattlePage"
        Case "chess"
            ECore.NewTransform transFallDark, 3000, "TicTacToePage"
        Case "bxbattle"
            ECore.NewTransform transFallDark, 3000, "BXBattlePage"
    End Select
End Sub
Public Sub ShowTip(Game As String)
    MyGame = Game
    Select Case MyGame
        Case "novel"
            CtrlText = "��Z��Enter���������ڼ����Ի�" & vbCrLf & "��X�鿴��ʷ�Ի���"
            GoalText = "���������¡�"
            RequireText = "ȷ���Լ�����������" & vbCrLf & _
                          "Ӯ�ý�ɫ�ǵĺøС�"
        Case "snowstorm"
            CtrlText = "�������е� �� �� �� �� �ٿ����Լ��ڵ�ͼ���ƶ���" & vbCrLf & "�� Z ����ѩ�ǣ��� X ������"
            GoalText = "���Լ���Ѫ������300��ǰ���£���ѩ�ǵ�Ѫ������300���¡�"
            RequireText = "��ѩ�ǳ����������Ұ��ʱ������Թ���ѩ�ǣ��������Ի�Ѫ��" & vbCrLf & _
                          "��ѩ�ǲ��������Ұ��ʱ�����򲻿��Թ���ѩ�ǣ������Ի�Ѫ��" & vbCrLf & _
                          "�����ͻ�Ѫ���������������ֵ��AP������ʱ�䲻�����ͻ�Ѫ���Բ���������"
        Case "snowman"
            CtrlText = "��ס���ȴ�ѩ������������Ҫ�Ĵ�Сʱ���ɿ���ꡣ"
            GoalText = "ʹѩ�˸߶ȴ���һ���߶ȣ��Ʋ�߶ȣ�"
            RequireText = "��������ѩ����������" & vbCrLf & _
                          "ѩ���С�������һ��ѩ���Сƫ��ѩ�˽��ᵹ����"
        Case "mazesnow"
            CtrlText = "�������е� �� �� �� �� �ٿ����Լ��ڵ�ͼ���ƶ���"
            GoalText = "�ﵽ��ͼ������ɫ�����ע���յ㡣"
            RequireText = "��ͼ�Ͻ����¼���Ѿ��߹��ĵط���"
        Case "maze"
            CtrlText = "�������е� �� �� �� �� �ٿ����Լ��ڵ�ͼ���ƶ���"
            GoalText = "�ﵽ��ͼ������ɫ�����ע���յ㡣"
            RequireText = "��ͼ�Ͻ����¼���Ѿ��߹��ĵط���"
        Case "battle"
            CtrlText = "�������еİ�ť�������Ѫ��"
            GoalText = "���Լ���Ѫ������300��ǰ���£���������Ѫ������300���¡�"
            RequireText = "���¹������㽫��һ����ʱ�乥����" & vbCrLf & _
                          "������������׼׼��ʱ��������ꡣ" & vbCrLf & _
                          "����λ��Խ�ӽ��������ģ���ɵ��˺�Խ��"
        Case "chess"
            CtrlText = "����Ļغ�ʱ�����¾Ÿ�����������һ���հ�λ�����塣"
            GoalText = "���������Լ��µ��������ӿ�������һ��ֱ�ߵ�Ŀ��֮ǰ��" & vbCrLf & _
                       "ʹ���Լ��µ��������ӿ�������һ��ֱ�ߡ�"
            RequireText = "�µ��������ӿ�������һ��ֱ�ߵ�һ����ʤ��"
        Case "bxbattle"
            CtrlText = "�ƶ�����ס������"
            GoalText = "�ֵ�ס���й�����"
            RequireText = "��ӵ������ʧ��Ļ��ᡣ" & vbCrLf & _
                          "��Ŀ����봰���²��ĺ�ɫ����ʱ�ſ��Խ�ס������" & vbCrLf & _
                          "ֻ�ܽ�ס��ɫ����ָʾ��һ�������·��Ĺ�����"
    End Select
End Sub
Public Sub Wheel(Direction As Integer, Depth As Single)
    '�������¼�
    'Direction:����Depth�����
End Sub
Public Sub AnimationMsg(id As String, msg As String)
    '������Ϣ����
End Sub
Public Sub Enter()
    'ҳ������¼�
End Sub
Public Sub Leave()
    'ҳ���뿪�¼�
End Sub
Public Sub Gotfocus()
    '����ȡ�ý����¼�
End Sub
Public Sub Lostfocus()
    '����ʧȥ�����¼�
End Sub
Public Sub AnimationDone(id As Integer)
    '�������Ž����¼�
    'id�������Ķ���ID
End Sub
Private Sub Class_Initialize()
    '����ҳ�������
    Set Page = New GPage
    Page.Create Me
    '������Ϸ��Դ
    Page.Res.newImage App.Path & "\assets\bg\DarkSpace.png", GW, GH, "bg.png"
    '����ҳ��
    ECore.Add Page, "TipPage"
    
    '===============================================
    '   �����Ҫ���Ӷ�����������ڴ˴�
    
    '===============================================
End Sub