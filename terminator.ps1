if (-not (Get-Process -Name vcxsrv -ErrorAction Ignore))
{
    &"C:\Program Files\VcXsrv\vcxsrv.exe" :0 -ac -terminate -lesspointer -multiwindow -clipboard -wgl -dpi auto
}

bash.exe -l -c "DISPLAY=:0 terminator"