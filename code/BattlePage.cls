VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "BattlePage"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
'======================================
'   ҳ�������
    Dim Page As GPage
    Dim RoundTime As Long
    Dim RoundText As String
    Dim Step As Long
    Dim UMaxHp As Long, UHP As Long
    Dim MaxHp As Long, Hp As Long
    Dim LastHp As Long
    Dim ATK As Long, UATK As Long, ATKKind As Integer
'======================================
Public Sub UAttack()

    Randomize
    ATKKind = Int(Rnd * 3)
    UATK = Int(Rnd * 50 + 145)
    LastHp = Hp
    Select Case ATKKind
        Case 0 '��
            UATK = UATK * 1.5
            Page.SwitchChannel "Ԫ��֮�ڡ�����", "Default"
        Case 1 '��
            UATK = UATK * 1
            Page.SwitchChannel "Ԫ��֮�ڡ�����", "Default"
        Case Else 'ˮ
            UATK = UATK * 0.8
            Page.SwitchChannel "Ԫ��֮�ڡ���ˮ", "Default"
    End Select
    Hp = Hp - UATK
    If Hp <= 500 Then
        BGM.Create App.Path & "\music\bgm\OST 11 - Heartbeat.mp3"
    End If
    RoundTime = GetTickCount
    Step = 3
    ECore.NewTransform
End Sub
Public Sub Update()
    '��Ϸÿһ֡�Ĺ��̣����ƹ�������ڴ˴���
    
    Page.Clear '��ջ���

    Page.DrawImage "Meadow.png", 0, 0, Alpha:=1
    Page.DrawImage "Stone2.png", 0, 0, Alpha:=1
    
    Dim SinBuff As Long
    
    SinBuff = 500 + IIf(Step = 2, 0, Sin((GetTickCount / 400) + 1) * IIf(Step = 1, 170, 80))
    Page.DrawImage "kx1-normal.png", GW / 2 - 480, SinBuff, Alpha:=1, pos:=posOnCenter
    For i = 0 To 10
        Page.DrawImage "kx1-normal.png", GW / 2 - 480, 500 + IIf(Step = 2, 0, Sin((GetTickCount / 400) + i / 10) * IIf(Step = 1, 170 * (1 + (1 - UHP / UMaxHp) / 2.5), 80)), Alpha:=0.1, pos:=posOnCenter
    Next
    
    Dim pro As Single
    
    If Step = 2 Then
        If ATK <> 0 Then
            Page.DrawAnimation "��ͭ��", GW / 2, GH / 2
            If GetTickCount Mod 300 < 150 Then
                Page.Writes "-" & ATK, GW / 2, GH / 2, 48, argb(255, 255, 255, 255), align:=StringAlignmentCenter, style:=FontStyleBold
                If ATK > 180 Then Page.Writes "EXCELLENT !", GW / 2, GH / 2 + 70, 48, argb(255, 255, 255, 255), align:=StringAlignmentCenter, style:=FontStyleBold
            End If
        Else
            If GetTickCount Mod 300 < 150 Then Page.Writes "MISS", GW / 2, GH / 2, 48, argb(255, 255, 255, 255), align:=StringAlignmentCenter, style:=FontStyleBold
        End If
        If GetTickCount - RoundTime >= 3000 Then
            Call UAttack
        End If
    End If
    
    If Step = 3 Then
        pro = (GetTickCount - RoundTime) / 1000
        pro = Cubic(pro, 0, 1, 1, 1)
        If pro > 1 Then pro = 1
        
        Select Case ATKKind
            Case 0 '��
                Page.DrawAnimation "Ԫ��֮�ڡ�����", GW / 2, GH - 250
            Case 1 '��
                Page.DrawAnimation "Ԫ��֮�ڡ�����", GW / 2, GH - 250
            Case Else 'ˮ
                Page.DrawAnimation "Ԫ��֮�ڡ���ˮ", GW / 2, GH - 250
        End Select
        
        If Hp <= 500 Then
            Page.Paint 0, 0, 0, GW + 1, GH + 1, argb(pro * 255, 255, 0, 0)
            If GetTickCount Mod 300 < 150 And pro = 1 Then Page.Writes "��ʧ���ˣ����װ��ĵ�һ�˸�", GW / 2, GH / 2 - 24, 48, argb(255, 255, 255, 255), align:=StringAlignmentCenter, style:=FontStyleBold
        Else
            If pro = 1 Then Page.Paint 0, 0, 0, GW + 1, GH + 1, argb(60, 255, 0, 0)
            If GetTickCount Mod 300 < 150 And pro = 1 Then Page.Writes "-" & UATK, GW / 2, GH - 150, 48, argb(255, 255, 255, 255), align:=StringAlignmentCenter, style:=FontStyleBold
        End If
        
        If GetTickCount - RoundTime >= 3000 Then
            Step = 0
            ECore.NewTransform
        End If
    End If
    If Step = 4 Then
        pro = (GetTickCount - RoundTime) / 1000
        pro = Cubic(pro, 0, 1, 1, 1)
        If pro > 1 Then pro = 1
        
        Page.DrawAnimation "��������", GW / 2, GH - 150
        
        If GetTickCount Mod 300 < 150 And pro = 1 Then Page.Writes "+" & -UATK, GW / 2, GH - 130, 48, argb(255, 255, 255, 255), align:=StringAlignmentCenter, style:=FontStyleBold
        
        If GetTickCount - RoundTime >= 3000 Then
            Call UAttack
        End If
    End If
    If Step = 2 Then
        pro = (GetTickCount - RoundTime) / 1000
        pro = Cubic(pro, 0, 1, 1, 1)
        If pro > 1 Then pro = 1
        
        Page.Paint 2, GW / 2, 85, 600 - 5, 30 - 2, argb(255, 64, 64, 64), 40, pos:=posOnCenter
        Page.Paint 2, GW / 2 - 300, 85 - 30 / 2, (UHP + ATK - ATK * pro) / UMaxHp * 600, 30, argb(255, 254, 84, 57), 40
        
        Page.Writes UHP & " / " & UMaxHp, GW / 2, 85 - 14, 20, argb(255, 255, 255, 255), align:=StringAlignmentCenter, style:=FontStyleBold
    End If
    
    If Step = 0 Then
        Dim m As Integer
        Page.DrawImage "atk0.png", GW / 2 - 100, GH - 150, Alpha:=0, pos:=posOnCenter
        m = CheckMouse2
        If m >= MButtonState.mMouseIn Then Page.DrawAnimation "attackbg", GW / 2 - 100, GH - 150
        Page.DrawImage "atk" & IIf(m >= mMouseIn, 1, 0) & ".png", GW / 2 - 100, GH - 150, Alpha:=1, pos:=posOnCenter
        If m = MButtonState.mMouseUp Then SE.Play "Cursor.mp3": Step = 1: ECore.NewTransform
        
        Page.DrawImage "def0.png", GW / 2 + 100, GH - 150, Alpha:=1, pos:=posOnCenter
        m = CheckMouse2
        If m >= MButtonState.mMouseIn Then Page.DrawAnimation "attackbg", GW / 2 + 100, GH - 150
        Page.DrawImage "def" & IIf(m >= mMouseIn, 1, 0) & ".png", GW / 2 + 100, GH - 150, Alpha:=1, pos:=posOnCenter
        If m = MButtonState.mMouseUp Then
            UATK = (Hp - LastHp)
            Hp = LastHp
            Page.SwitchChannel "��������", "Default"
            RoundTime = GetTickCount
            SE.Play "Cursor.mp3": Step = 4: ECore.NewTransform
        End If
    End If
    
    If Step = 1 Then
        Page.Paint 0, 0, 0, GW + 1, GH + 1, argb(80, 255, 0, 0)
        Page.PaintLine GW / 2 - 50, GH / 2, GW / 2 + 50, GH / 2, argb(255, 255, 0, 0), 3
        Page.PaintLine GW / 2, GH / 2 - 50, GW / 2, GH / 2 + 50, argb(255, 255, 0, 0), 3
        
        If GetTickCount Mod 300 < 150 Then Page.Writes "������깥��", GW / 2, GH / 2 + 150, 20, argb(255, 255, 255, 255), align:=StringAlignmentCenter, style:=FontStyleBold
        If Mouse.button = 1 And Mouse.state = 2 Then
            ATK = 0
            Randomize
            ATK = (Abs(SinBuff - 382 - GH / 2))
            ATK = (ATK) / (80) * 70 * (Rnd * 0.3 + 1)
            If ATK < 0 Then ATK = 0
            If ATK > 400 Then ATK = 0
            UHP = UHP - ATK
            Mouse.state = 0: Mouse.button = 0
            Page.SwitchChannel "��ͭ��", "Default"
            SE.Play "Magic1.mp3"
            RoundTime = GetTickCount
            ECore.NewTransform transHighLight, 100
            Step = 2
        End If
    End If
    
    Page.Writes "HP     " & Int(Hp + IIf(Step = 3 Or Step = 4, UATK - UATK * pro, 0)) & "/" & MaxHp, 50, GH - 80, 20, argb(255, 255, 255, 255), align:=StringAlignmentNear
    
    If BGM.PlayState = musStopped And BGM.length <> 0 Then BGM.Play
    If BGS.PlayState = musStopped And BGS.length <> 0 Then BGS.Play
    
    If Hp <= 500 And Step = 0 Then
        SE.Play "Collapse4.mp3"
        Hp = MaxHp: UHP = UMaxHp
        BGM.Create App.Path & "\music\bgm\OST 5 - Firecrackers.mp3"
        Step = 0: ECore.NewTransform transFallDark, 2000
    End If
    If UHP <= 500 And Step = 0 Then
        NovelPage.RunNovel
        ECore.NewTransform transHighLight, 3000, "NovelPage"
    End If
End Sub
Public Sub Wheel(Direction As Integer, Depth As Single)
    '�������¼�
    'Direction:����Depth�����
End Sub
Public Sub AnimationMsg(id As String, msg As String)
    '������Ϣ����
   ' If id = "��ͭ��" And msg = "ok" Then
  '      Step = 0
  '      ECore.NewTransform
   ' End If
End Sub
Public Sub Enter()
    'ҳ������¼�
    BGM.Create App.Path & "\music\bgm\OST 5 - Firecrackers.mp3"
    BGM.Play
    BGS.Create App.Path & "\music\bgs\Wind_1_3D_loop.mp3"
    BGS.Play
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
    Page.Res.NewImages App.Path & "\assets\battleui"
    Page.Res.HotLoad = True
    Page.Res.NoLoadCrash = True
    Page.Res.NewImages App.Path & "\assets\battle\images", 1.8
    Page.LoadAnimationsFromDir App.Path & "\battle_animation"
    
    Page.CreatePlayAnimation "attackbg", "attackbg", "Default"
    Page.CreatePlayAnimation "rpgmv_Laser1", "��ͭ��", "Default"
    Page.CreatePlayAnimation "rpgmv_Recovery1", "��������", "Default"
    Page.CreatePlayAnimation "rpgmv_Fire2", "Ԫ��֮�ڡ�����", "Default"
    Page.CreatePlayAnimation "rpgmv_Earth2", "Ԫ��֮�ڡ�����", "Default"
    Page.CreatePlayAnimation "rpgmv_Water2", "Ԫ��֮�ڡ���ˮ", "Default"
    
    UMaxHp = 1700: UHP = UMaxHp
    MaxHp = 2200: Hp = MaxHp: LastHp = MaxHp
    '����ҳ��
    ECore.Add Page, "BattlePage"
    
    '===============================================
    '   �����Ҫ���Ӷ�����������ڴ˴�
    
    '===============================================
End Sub