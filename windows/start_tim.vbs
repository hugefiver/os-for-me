Set shell = CreateObject("WScript.Shell")

' common_prog_path = shell.ExpandEnvironmentStrings("%CommonProgramFiles(x86)%")
' prog_path = shell.ExpandEnvironmentStrings("%ProgramFiles(x86)%")
qq_protect_name = "QQProtect.exe"
qq_protect = """%CommonProgramFiles(x86)%\Tencent\QQProtect\Bin\QQProtect.exe"""
tim = """%ProgramFiles(x86)%\Tencent\TIM\Bin\TIM.exe"""

' start qq_protect if it's not running 
Set wmi = GetObject("WinMgmts:")
Set p = wmi.ExecQuery("select * from Win32_Process where Name = '" _
        & qq_protect_name & "'")
if p.count = 0 then
    shell.Run qq_protect
end if

shell.Run tim
