VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "FlyPage"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
'======================================
'   ҳ�������
    Dim Page As GPage
    Dim PX As Single, PY As Long
    Dim Jumptime As Long, JumpMode As Long
    Private Type BlockerInfo
        X As Long
        CY As Long
    End Type
    Dim Blockers() As BlockerInfo
    Dim Crash As New GCrashBox
    Dim Heart As Long, HurtTime As Long
    Dim NoPower As Boolean, HitTop As Long
'======================================

Public Sub Update()
    If Err.Number <> 0 Then ErrCrash Err.Number, Err.Description
    On Error Resume Next

    '��Ϸÿһ֡�Ĺ��̣����ƹ�������ڴ˴���
    
    Page.Clear '��ջ���
    
    Dim CX As Long
    CX = PX Mod (GW * 2)
    Page.DrawImage "Sky.png", -CX, 0, alpha:=1, Direction:=DirNormal
    Page.DrawImage "Sky.png", GW - CX, 0, alpha:=1, Direction:=DirHorizontal
    Page.DrawImage "Sky.png", GW * 2 - CX, 0, alpha:=1, Direction:=DirNormal
    
    If GetTickCount - HurtTime <= 3000 Then
        If GetTickCount Mod 300 < 150 Then Page.DrawImage "yzhurt.png", 150, PY, alpha:=1, Pos:=posOnCenter
    Else
        Page.DrawImage "yz.png", 150, PY, alpha:=1, Pos:=posOnCenter
    End If
    
    Crash.Reset
    
    Dim DrawX As Long
    For i = 0 To UBound(Blockers)
        DrawX = Blockers(i).X - PX + 150
        If DrawX > -20 And DrawX <= GW Then
            Page.Paint 0, DrawX, 0, 20, Blockers(i).CY, argb(100 - 100 * Abs(DrawX - 20) / GW, 0, 0, 0)
            Crash.IsCrash
            Page.Paint 0, DrawX, Blockers(i).CY + (400 - i / 30 * 150), 20, GH - (400 - i / 30 * 150) - Blockers(i).CY, argb(100 - 100 * Abs(DrawX - 20) / GW, 0, 0, 0)
            Crash.IsCrash
        End If
    Next
    
    Dim IsHurt As Boolean
    
    If PY > GH Then Heart = 0: NoPower = False
    If Crash.CrashResult Then IsHurt = True
    
    If IsHurt And GetTickCount - HurtTime > 3000 Then
        NoPower = False
        Heart = Heart - 1
        HurtTime = GetTickCount
        SE.Play "Damage2.mp3"
    End If
    
    If Heart <= 0 Then
        PX = 0: PY = 0
        Heart = 3
        SE.Play "Collapse4.mp3"
        ECore.NewTransform transDarkTo, 1000
    End If
    
    PX = PX + 1 + 2 * (PX / 8888)
    
    If (IsKeyPress(VK_SPACE) Or Mouse.button = 1) And JumpMode = 0 Then
        Mouse.button = 0
        JumpMode = 1
        Jumptime = GetTickCount
    End If
    
    Dim Pro As Single
    If JumpMode = 0 Then
        Pro = (GetTickCount - Jumptime) / 500
    Else
        Pro = (GetTickCount - Jumptime) / 300
    End If
    
    If Pro > 1 Then Pro = 1
    
    If JumpMode = 0 Then
        Pro = Cubic(Pro, 0, 0, 0, 1)
    Else
        Pro = Cubic(Pro, 0, 1, 1, 1)
    End If
    
    If Pro = 1 And JumpMode = 1 Then JumpMode = 0: Jumptime = GetTickCount: SE.Play "Jump1.mp3"
    
    PY = PY - IIf(JumpMode = 0, -3 * Pro - 1, 4 * Pro)
    
    If PX > 15000 Then
        SE.Play "Applause1.mp3"
        NovelPage.RunNovel
        ECore.NewTransform transHighLight, 3000, "NovelPage"
    End If
    
    If PY < 0 Then
        PY = 0: HitTop = HitTop + 1
        If HitTop >= 233 Then
            NoPower = True
            HitTop = 0
            Heart = 0
        End If
    End If
    
    If NoPower And X <= 500 Then
        If GetTickCount Mod 300 < 150 Then Page.Writes "ѿ�ӷ��ײ�컨��ײ���ˡ�", GW / 2, GH / 2, 48, argb(255, 0, 0, 0), align:=StringAlignmentCenter, style:=FontStyleBold
    End If
    
    For i = 1 To 3
        Page.DrawImage IIf(Heart >= i, "", "un") & "heart.png", 50 + (i - 1) * 100, 50, alpha:=1
    Next
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
    BGM.Create App.Path & "\music\bgm\OST 17 - Good Day with Blues.mp3"
    BGM.Play
    BGS.Dispose
    Jumptime = GetTickCount
    JumpMode = 0
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
    ReDim Blockers(0)

    '����ҳ�������
    Set Page = New GPage
    Page.Create Me
    '������Ϸ��Դ
    Page.Res.NewImages App.Path & "\assets\flyyz"
    Page.Res.NoLoadDirection = False
    Page.Res.newImage App.Path & "\assets\fg\Sky.png", GW, GH
    '����ҳ��
    ECore.Add Page, "FlyPage"
    
    Randomize
    ReDim Blockers(30)
    For i = 0 To 30
        Blockers(i).X = 1000 + i * 400
        Blockers(i).CY = Int(Rnd * (GH - (400 - i / 30 * 150)))
    Next
    Heart = 3
    '===============================================
    '   �����Ҫ���Ӷ�����������ڴ˴�
    
    '===============================================
End Sub