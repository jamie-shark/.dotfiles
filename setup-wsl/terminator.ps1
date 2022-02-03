if (-not (Get-Process -Name vcxsrv -ErrorAction Ignore))
{
    &"C:\Program Files\VcXsrv\vcxsrv.exe" :0 -ac -terminate -lesspointer -multiwindow -clipboard -wgl -dpi auto
}

if (-not (Get-Process -Name pulseaudio -ErrorAction Ignore))
{
    &"C:\pulseaudio-1.1\bin\pulseaudio.exe" --use-pid-file=false -D
}

if (Get-Command "wsl" -ErrorAction SilentlyContinue)
{
    Write-Output "exec wsl"
    wsl -d "Ubuntu-20.04" -e "DISPLAY=:0.0 terminator"
}
else
{
    Write-Output "exec bash"
    bash.exe -l -c "DISPLAY=:0.0 terminator"
}
