﻿; Generated by KLFC 1.5.7
; https://github.com/39aldo39/klfc

#MaxHotkeysPerInterval 200
#MaxThreadsPerHotkey 10

SendUps(ByRef modifiers) {
  for index, modifier in modifiers {
    if (modifier == "Caps")
      SetCapsLockState, off
    else if (modifier == "Num")
      SetNumLockState, off
    else if InStr(modifier, "Extend")
      %modifier% := false
    else
      Send {%modifier% Up}
  }
  modifiers := Object()
}

SendAsUnicode(string) {
  Result := ""
  Loop, Parse, string
    Result .= Format("{{}U+{:04x}{}}", Ord(A_LoopField))
  Send {Blind}%Result%
}

DeadKeys := ComObjCreate("Scripting.Dictionary")

DeadKey(baseChar, table, name := "") {
  Global ActiveDeadKey
  if (ActiveDeadKey != "") {
    NewActiveDeadKey := ComObjCreate("Scripting.Dictionary")
    for key in table {
      value := table.item(key)
      NewActiveDeadKey.item(key) := ActiveDeadKey.item(value)
    }
    result := ActiveDeadKey.item(name)
    if (IsObject(result)) {
      for key in result {
        value := result.item(key)
        NewActiveDeadKey.item(key) := value
      }
    } else if (result != "") {
      ActiveDeadKey := ""
      SendAsUnicode(result)
      Return
    }
    ActiveDeadKey := NewActiveDeadKey
    Return
  }
  ActiveDeadKey := table
  Input key, L1, {Esc}{F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}{Left}{Right}{Up}{Down}{Home}{End}{PgUp}{PgDn}{Del}{Ins}{BS}{PrintScreen}{Pause}{AppsKey}
  If InStr(ErrorLevel, "EndKey:") {
    ActiveDeadKey := ""
    value := SubStr(ErrorLevel, 8)
    Send {Blind}{%value%}
    SendAsUnicode(baseChar)
  } else if (ErrorLevel != "NewInput") {
    value := ActiveDeadKey.item(key)
    ActiveDeadKey := ""
    if (IsObject(value)) {
      DeadKey(baseChar, value)
    } else if (value != "") {
      SendAsUnicode(value)
    } else {
      SendAsUnicode(baseChar . key)
    }
  }
}

*SC029::Send {Blind}{VKc0SC029 DownR} ; QWERTY ~: ~
*SC029 up::Send {Blind}{VKc0SC029 Up}
*SC002::Send {Blind}{VK36SC002 DownR} ; QWERTY 1: 6
*SC002 up::Send {Blind}{VK36SC002 Up}
*SC003::Send {Blind}{VK37SC003 DownR} ; QWERTY 2: 7
*SC003 up::Send {Blind}{VK37SC003 Up}
*SC004::Send {Blind}{VK38SC004 DownR} ; QWERTY 3: 8
*SC004 up::Send {Blind}{VK38SC004 Up}
*SC005::Send {Blind}{VK39SC005 DownR} ; QWERTY 4: 9
*SC005 up::Send {Blind}{VK39SC005 Up}
*SC006::Send {Blind}{VKdbSC006 DownR} ; QWERTY 5: [
*SC006 up::Send {Blind}{VKdbSC006 Up}
*SC007::Send {Blind}{VKddSC007 DownR} ; QWERTY 6: ]
*SC007 up::Send {Blind}{VKddSC007 Up}
*SC008::Send {Blind}{VK30SC008 DownR} ; QWERTY 7: 0
*SC008 up::Send {Blind}{VK30SC008 Up}
*SC009::Send {Blind}{VK31SC009 DownR} ; QWERTY 8: 1
*SC009 up::Send {Blind}{VK31SC009 Up}
*SC00a::Send {Blind}{VK32SC00a DownR} ; QWERTY 9: 2
*SC00a up::Send {Blind}{VK32SC00a Up}
*SC00b::Send {Blind}{VK33SC00b DownR} ; QWERTY 0: 3
*SC00b up::Send {Blind}{VK33SC00b Up}
*SC00c::Send {Blind}{VK34SC00c DownR} ; QWERTY -: 4
*SC00c up::Send {Blind}{VK34SC00c Up}
*SC00d::Send {Blind}{VK35SC00d DownR} ; QWERTY +: 5
*SC00d up::Send {Blind}{VK35SC00d Up}
*SC010::Send {Blind}{VK58SC010 DownR} ; QWERTY Q: X
*SC010 up::Send {Blind}{VK58SC010 Up}
*SC011::Send {Blind}{VK59SC011 DownR} ; QWERTY W: Y
*SC011 up::Send {Blind}{VK59SC011 Up}
*SC012::Send {Blind}{VK55SC012 DownR} ; QWERTY E: U
*SC012 up::Send {Blind}{VK55SC012 Up}
*SC013::Send {Blind}{VKbcSC013 DownR} ; QWERTY R: ,
*SC013 up::Send {Blind}{VKbcSC013 Up}
*SC014::Send {Blind}{VKbdSC014 DownR} ; QWERTY T: -
*SC014 up::Send {Blind}{VKbdSC014 Up}
*SC015::Send {Blind}{VK56SC015 DownR} ; QWERTY Y: V
*SC015 up::Send {Blind}{VK56SC015 Up}
*SC016::Send {Blind}{VK4dSC016 DownR} ; QWERTY U: M
*SC016 up::Send {Blind}{VK4dSC016 Up}
*SC017::Send {Blind}{VK48SC017 DownR} ; QWERTY I: H
*SC017 up::Send {Blind}{VK48SC017 Up}
*SC018::Send {Blind}{VK50SC018 DownR} ; QWERTY O: P
*SC018 up::Send {Blind}{VK50SC018 Up}
*SC019::Send {Blind}{VK4aSC019 DownR} ; QWERTY P: J
*SC019 up::Send {Blind}{VK4aSC019 Up}
*SC01a::Send {Blind}{VK5aSC01a DownR} ; QWERTY [: Z
*SC01a up::Send {Blind}{VK5aSC01a Up}
*SC01b::Send {Blind}{VKbbSC01b DownR} ; QWERTY ]: +
*SC01b up::Send {Blind}{VKbbSC01b Up}
*SC02b::Send {Blind}{VKdcSC02b DownR} ; QWERTY \: \
*SC02b up::Send {Blind}{VKdcSC02b Up}
*SC01e::Send {Blind}{VK44SC01e DownR} ; QWERTY A: D
*SC01e up::Send {Blind}{VK44SC01e Up}
*SC01f::Send {Blind}{VK49SC01f DownR} ; QWERTY S: I
*SC01f up::Send {Blind}{VK49SC01f Up}
*SC020::Send {Blind}{VK45SC020 DownR} ; QWERTY D: E
*SC020 up::Send {Blind}{VK45SC020 Up}
*SC021::Send {Blind}{VK41SC021 DownR} ; QWERTY F: A
*SC021 up::Send {Blind}{VK41SC021 Up}
*SC022::Send {Blind}{VK4fSC022 DownR} ; QWERTY G: O
*SC022 up::Send {Blind}{VK4fSC022 Up}
*SC023::Send {Blind}{VK43SC023 DownR} ; QWERTY H: C
*SC023 up::Send {Blind}{VK43SC023 Up}
*SC024::Send {Blind}{VK53SC024 DownR} ; QWERTY J: S
*SC024 up::Send {Blind}{VK53SC024 Up}
*SC025::Send {Blind}{VK4eSC025 DownR} ; QWERTY K: N
*SC025 up::Send {Blind}{VK4eSC025 Up}
*SC026::Send {Blind}{VK54SC026 DownR} ; QWERTY L: T
*SC026 up::Send {Blind}{VK54SC026 Up}
*SC027::Send {Blind}{VK52SC027 DownR} ; QWERTY ;: R
*SC027 up::Send {Blind}{VK52SC027 Up}
*SC028::Send {Blind}{VK57SC028 DownR} ; QWERTY ': W
*SC028 up::Send {Blind}{VK57SC028 Up}
*SC02d::Send {Blind}{VKbfSC02d DownR} ; QWERTY X: /
*SC02d up::Send {Blind}{VKbfSC02d Up}
*SC02e::Send {Blind}{VKdeSC02e DownR} ; QWERTY C: '
*SC02e up::Send {Blind}{VKdeSC02e Up}
*SC02f::Send {Blind}{VKbeSC02f DownR} ; QWERTY V: .
*SC02f up::Send {Blind}{VKbeSC02f Up}
*SC030::Send {Blind}{VKbaSC030 DownR} ; QWERTY B: ;
*SC030 up::Send {Blind}{VKbaSC030 Up}
*SC031::Send {Blind}{VK46SC031 DownR} ; QWERTY N: F
*SC031 up::Send {Blind}{VK46SC031 Up}
*SC032::Send {Blind}{VK47SC032 DownR} ; QWERTY M: G
*SC032 up::Send {Blind}{VK47SC032 Up}
*SC033::Send {Blind}{VK4cSC033 DownR} ; QWERTY ,: L
*SC033 up::Send {Blind}{VK4cSC033 Up}
*SC034::Send {Blind}{VK42SC034 DownR} ; QWERTY .: B
*SC034 up::Send {Blind}{VK42SC034 Up}
*SC035::Send {Blind}{VK51SC035 DownR} ; QWERTY /: Q
*SC035 up::Send {Blind}{VK51SC035 Up}

; QWERTY ~
#if
SC029::Send {Blind}{U+0060} ; `
+SC029::Send {Blind}{U+007e} ; ~
>!<^SC029::Return
+>!<^SC029::Return

; QWERTY 1
#if
SC002::Send {Blind}{U+0036} ; 6
+SC002::Send {Blind}{U+005e} ; ^
>!<^SC002::Return
+>!<^SC002::Return

; QWERTY 2
#if
SC003::Send {Blind}{U+0037} ; 7
+SC003::Send {Blind}{U+0026} ; &
>!<^SC003::Return
+>!<^SC003::Return

; QWERTY 3
#if
SC004::Send {Blind}{U+0038} ; 8
+SC004::Send {Blind}{U+002a} ; *
>!<^SC004::Return
+>!<^SC004::Return

; QWERTY 4
#if
SC005::Send {Blind}{U+0039} ; 9
+SC005::Send {Blind}{U+0028} ; (
>!<^SC005::Return
+>!<^SC005::Return

; QWERTY 5
#if
SC006::Send {Blind}{U+005b} ; [
+SC006::Send {Blind}{U+007b} ; {
>!<^SC006::Return
+>!<^SC006::Return

; QWERTY 6
#if
SC007::Send {Blind}{U+005d} ; ]
+SC007::Send {Blind}{U+007d} ; }
>!<^SC007::Return
+>!<^SC007::Return

; QWERTY 7
#if
SC008::Send {Blind}{U+0030} ; 0
+SC008::Send {Blind}{U+0029} ; )
>!<^SC008::Return
+>!<^SC008::Return

; QWERTY 8
#if
SC009::Send {Blind}{U+0031} ; 1
+SC009::Send {Blind}{U+0021} ; !
>!<^SC009::Return
+>!<^SC009::Return

; QWERTY 9
#if
SC00a::Send {Blind}{U+0032} ; 2
+SC00a::Send {Blind}{U+0040} ; @
>!<^SC00a::Return
+>!<^SC00a::Return

; QWERTY 0
#if
SC00b::Send {Blind}{U+0033} ; 3
+SC00b::Send {Blind}{U+0023} ; #
>!<^SC00b::Return
+>!<^SC00b::Return

; QWERTY -
#if
SC00c::Send {Blind}{U+0034} ; 4
+SC00c::Send {Blind}{U+0024} ; $
>!<^SC00c::Return
+>!<^SC00c::Return

; QWERTY +
#if
SC00d::Send {Blind}{U+0035} ; 5
+SC00d::Send {Blind}{U+0025} ; %
>!<^SC00d::Return
+>!<^SC00d::Return

; QWERTY Q
#if
SC010::
if not GetKeyState("CapsLock", "T") {
  Send {Blind}{U+0078} ; x
} else {
  Send {Blind}{U+0058} ; X
}
Return
+SC010::
if not GetKeyState("CapsLock", "T") {
  Send {Blind}{U+0058} ; X
} else {
  Send {Blind}{U+0078} ; x
}
Return
>!<^SC010::Return
+>!<^SC010::Return

; QWERTY W
#if
SC011::
if not GetKeyState("CapsLock", "T") {
  Send {Blind}{U+0079} ; y
} else {
  Send {Blind}{U+0059} ; Y
}
Return
+SC011::
if not GetKeyState("CapsLock", "T") {
  Send {Blind}{U+0059} ; Y
} else {
  Send {Blind}{U+0079} ; y
}
Return
>!<^SC011::Return
+>!<^SC011::Return

; QWERTY E
#if
SC012::
if not GetKeyState("CapsLock", "T") {
  Send {Blind}{U+0075} ; u
} else {
  Send {Blind}{U+0055} ; U
}
Return
+SC012::
if not GetKeyState("CapsLock", "T") {
  Send {Blind}{U+0055} ; U
} else {
  Send {Blind}{U+0075} ; u
}
Return
>!<^SC012::Return
+>!<^SC012::Return

; QWERTY R
#if
SC013::Send {Blind}{U+002c} ; ,
+SC013::Send {Blind}{U+003c} ; <
>!<^SC013::Return
+>!<^SC013::Return

; QWERTY T
#if
SC014::Send {Blind}{U+002d} ; -
+SC014::Send {Blind}{U+005f} ; _
>!<^SC014::Return
+>!<^SC014::Return

; QWERTY Y
#if
SC015::
if not GetKeyState("CapsLock", "T") {
  Send {Blind}{U+0076} ; v
} else {
  Send {Blind}{U+0056} ; V
}
Return
+SC015::
if not GetKeyState("CapsLock", "T") {
  Send {Blind}{U+0056} ; V
} else {
  Send {Blind}{U+0076} ; v
}
Return
>!<^SC015::Return
+>!<^SC015::Return

; QWERTY U
#if
SC016::
if not GetKeyState("CapsLock", "T") {
  Send {Blind}{U+006d} ; m
} else {
  Send {Blind}{U+004d} ; M
}
Return
+SC016::
if not GetKeyState("CapsLock", "T") {
  Send {Blind}{U+004d} ; M
} else {
  Send {Blind}{U+006d} ; m
}
Return
>!<^SC016::Return
+>!<^SC016::Return

; QWERTY I
#if
SC017::
if not GetKeyState("CapsLock", "T") {
  Send {Blind}{U+0068} ; h
} else {
  Send {Blind}{U+0048} ; H
}
Return
+SC017::
if not GetKeyState("CapsLock", "T") {
  Send {Blind}{U+0048} ; H
} else {
  Send {Blind}{U+0068} ; h
}
Return
>!<^SC017::Return
+>!<^SC017::Return

; QWERTY O
#if
SC018::
if not GetKeyState("CapsLock", "T") {
  Send {Blind}{U+0070} ; p
} else {
  Send {Blind}{U+0050} ; P
}
Return
+SC018::
if not GetKeyState("CapsLock", "T") {
  Send {Blind}{U+0050} ; P
} else {
  Send {Blind}{U+0070} ; p
}
Return
>!<^SC018::Return
+>!<^SC018::Return

; QWERTY P
#if
SC019::
if not GetKeyState("CapsLock", "T") {
  Send {Blind}{U+006a} ; j
} else {
  Send {Blind}{U+004a} ; J
}
Return
+SC019::
if not GetKeyState("CapsLock", "T") {
  Send {Blind}{U+004a} ; J
} else {
  Send {Blind}{U+006a} ; j
}
Return
>!<^SC019::Return
+>!<^SC019::Return

; QWERTY [
#if
SC01a::
if not GetKeyState("CapsLock", "T") {
  Send {Blind}{U+007a} ; z
} else {
  Send {Blind}{U+005a} ; Z
}
Return
+SC01a::
if not GetKeyState("CapsLock", "T") {
  Send {Blind}{U+005a} ; Z
} else {
  Send {Blind}{U+007a} ; z
}
Return
>!<^SC01a::Return
+>!<^SC01a::Return

; QWERTY ]
#if
SC01b::Send {Blind}{U+003d} ; =
+SC01b::Send {Blind}{U+002b} ; +
>!<^SC01b::Return
+>!<^SC01b::Return

; QWERTY \
#if
SC02b::Send {Blind}{U+005c} ; \
+SC02b::Send {Blind}{U+007c} ; |
>!<^SC02b::Return
+>!<^SC02b::Return

; QWERTY A
#if
SC01e::
if not GetKeyState("CapsLock", "T") {
  Send {Blind}{U+0064} ; d
} else {
  Send {Blind}{U+0044} ; D
}
Return
+SC01e::
if not GetKeyState("CapsLock", "T") {
  Send {Blind}{U+0044} ; D
} else {
  Send {Blind}{U+0064} ; d
}
Return
>!<^SC01e::Return
+>!<^SC01e::Return

; QWERTY S
#if
SC01f::
if not GetKeyState("CapsLock", "T") {
  Send {Blind}{U+0069} ; i
} else {
  Send {Blind}{U+0049} ; I
}
Return
+SC01f::
if not GetKeyState("CapsLock", "T") {
  Send {Blind}{U+0049} ; I
} else {
  Send {Blind}{U+0069} ; i
}
Return
>!<^SC01f::Return
+>!<^SC01f::Return

; QWERTY D
#if
SC020::
if not GetKeyState("CapsLock", "T") {
  Send {Blind}{U+0065} ; e
} else {
  Send {Blind}{U+0045} ; E
}
Return
+SC020::
if not GetKeyState("CapsLock", "T") {
  Send {Blind}{U+0045} ; E
} else {
  Send {Blind}{U+0065} ; e
}
Return
>!<^SC020::Return
+>!<^SC020::Return

; QWERTY F
#if
SC021::
if not GetKeyState("CapsLock", "T") {
  Send {Blind}{U+0061} ; a
} else {
  Send {Blind}{U+0041} ; A
}
Return
+SC021::
if not GetKeyState("CapsLock", "T") {
  Send {Blind}{U+0041} ; A
} else {
  Send {Blind}{U+0061} ; a
}
Return
>!<^SC021::Return
+>!<^SC021::Return

; QWERTY G
#if
SC022::
if not GetKeyState("CapsLock", "T") {
  Send {Blind}{U+006f} ; o
} else {
  Send {Blind}{U+004f} ; O
}
Return
+SC022::
if not GetKeyState("CapsLock", "T") {
  Send {Blind}{U+004f} ; O
} else {
  Send {Blind}{U+006f} ; o
}
Return
>!<^SC022::Return
+>!<^SC022::Return

; QWERTY H
#if
SC023::
if not GetKeyState("CapsLock", "T") {
  Send {Blind}{U+0063} ; c
} else {
  Send {Blind}{U+0043} ; C
}
Return
+SC023::
if not GetKeyState("CapsLock", "T") {
  Send {Blind}{U+0043} ; C
} else {
  Send {Blind}{U+0063} ; c
}
Return
>!<^SC023::Return
+>!<^SC023::Return

; QWERTY J
#if
SC024::
if not GetKeyState("CapsLock", "T") {
  Send {Blind}{U+0073} ; s
} else {
  Send {Blind}{U+0053} ; S
}
Return
+SC024::
if not GetKeyState("CapsLock", "T") {
  Send {Blind}{U+0053} ; S
} else {
  Send {Blind}{U+0073} ; s
}
Return
>!<^SC024::Return
+>!<^SC024::Return

; QWERTY K
#if
SC025::
if not GetKeyState("CapsLock", "T") {
  Send {Blind}{U+006e} ; n
} else {
  Send {Blind}{U+004e} ; N
}
Return
+SC025::
if not GetKeyState("CapsLock", "T") {
  Send {Blind}{U+004e} ; N
} else {
  Send {Blind}{U+006e} ; n
}
Return
>!<^SC025::Return
+>!<^SC025::Return

; QWERTY L
#if
SC026::
if not GetKeyState("CapsLock", "T") {
  Send {Blind}{U+0074} ; t
} else {
  Send {Blind}{U+0054} ; T
}
Return
+SC026::
if not GetKeyState("CapsLock", "T") {
  Send {Blind}{U+0054} ; T
} else {
  Send {Blind}{U+0074} ; t
}
Return
>!<^SC026::Return
+>!<^SC026::Return

; QWERTY ;
#if
SC027::
if not GetKeyState("CapsLock", "T") {
  Send {Blind}{U+0072} ; r
} else {
  Send {Blind}{U+0052} ; R
}
Return
+SC027::
if not GetKeyState("CapsLock", "T") {
  Send {Blind}{U+0052} ; R
} else {
  Send {Blind}{U+0072} ; r
}
Return
>!<^SC027::Return
+>!<^SC027::Return

; QWERTY '
#if
SC028::
if not GetKeyState("CapsLock", "T") {
  Send {Blind}{U+0077} ; w
} else {
  Send {Blind}{U+0057} ; W
}
Return
+SC028::
if not GetKeyState("CapsLock", "T") {
  Send {Blind}{U+0057} ; W
} else {
  Send {Blind}{U+0077} ; w
}
Return
>!<^SC028::Return
+>!<^SC028::Return

; QWERTY X
#if
SC02d::Send {Blind}{U+002f} ; /
+SC02d::Send {Blind}{U+003f} ; ?
>!<^SC02d::Return
+>!<^SC02d::Return

; QWERTY C
#if
SC02e::Send {Blind}{U+0027} ; '
+SC02e::Send {Blind}{U+0022} ; "
>!<^SC02e::Return
+>!<^SC02e::Return

; QWERTY V
#if
SC02f::Send {Blind}{U+002e} ; .
+SC02f::Send {Blind}{U+003e} ; >
>!<^SC02f::Return
+>!<^SC02f::Return

; QWERTY B
#if
SC030::Send {Blind}{U+003b} ; ;
+SC030::Send {Blind}{U+003a} ; :
>!<^SC030::Return
+>!<^SC030::Return

; QWERTY N
#if
SC031::
if not GetKeyState("CapsLock", "T") {
  Send {Blind}{U+0066} ; f
} else {
  Send {Blind}{U+0046} ; F
}
Return
+SC031::
if not GetKeyState("CapsLock", "T") {
  Send {Blind}{U+0046} ; F
} else {
  Send {Blind}{U+0066} ; f
}
Return
>!<^SC031::Return
+>!<^SC031::Return

; QWERTY M
#if
SC032::
if not GetKeyState("CapsLock", "T") {
  Send {Blind}{U+0067} ; g
} else {
  Send {Blind}{U+0047} ; G
}
Return
+SC032::
if not GetKeyState("CapsLock", "T") {
  Send {Blind}{U+0047} ; G
} else {
  Send {Blind}{U+0067} ; g
}
Return
>!<^SC032::Return
+>!<^SC032::Return

; QWERTY ,
#if
SC033::
if not GetKeyState("CapsLock", "T") {
  Send {Blind}{U+006c} ; l
} else {
  Send {Blind}{U+004c} ; L
}
Return
+SC033::
if not GetKeyState("CapsLock", "T") {
  Send {Blind}{U+004c} ; L
} else {
  Send {Blind}{U+006c} ; l
}
Return
>!<^SC033::Return
+>!<^SC033::Return

; QWERTY .
#if
SC034::
if not GetKeyState("CapsLock", "T") {
  Send {Blind}{U+0062} ; b
} else {
  Send {Blind}{U+0042} ; B
}
Return
+SC034::
if not GetKeyState("CapsLock", "T") {
  Send {Blind}{U+0042} ; B
} else {
  Send {Blind}{U+0062} ; b
}
Return
>!<^SC034::Return
+>!<^SC034::Return

; QWERTY /
#if
SC035::
if not GetKeyState("CapsLock", "T") {
  Send {Blind}{U+0071} ; q
} else {
  Send {Blind}{U+0051} ; Q
}
Return
+SC035::
if not GetKeyState("CapsLock", "T") {
  Send {Blind}{U+0051} ; Q
} else {
  Send {Blind}{U+0071} ; q
}
Return
>!<^SC035::Return
+>!<^SC035::Return
