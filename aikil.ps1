function aikill {
    param (
        [switch]$register,
        [switch]$unregister,
        [switch]$check
    )
    $wait = 'Start-Sleep 1'
    
    function jobstart {
        $action = New-ScheduledTaskAction -Execute 'powershell.exe' -Argument "-WindowStyle Hidden -File <HOME>\Documents\WindowsPowerShell\aikiller.ps1"
        $trigger = New-ScheduledTaskTrigger -AtLogOn
        Register-ScheduledTask -Action $action -Trigger $trigger -TaskName "aikiller" -Description "kills illustrator when you hate everything"
    }
    function jobstop {
        Unregister-ScheduledTask -TaskName aikiller -Confirm:$false
    }
    function cleanup {
        Remove-Item -Path $HOME\Documents\WindowsPowerShell\aikiller.ps1
    }
    function appension {
        Add-Content -Path $HOME\Documents\WindowsPowerShell\aikiller.ps1 -Value 'Add-Type -AssemblyName PresentationFramework'
        Add-Content -Path $HOME\Documents\WindowsPowerShell\aikiller.ps1 -Value '$msgdiag1 = "Adobe Illustrator has crashed due to insufficient RAM. Do you want to close?"'
        Add-Content -Path $HOME\Documents\WindowsPowerShell\aikiller.ps1 -Value '$title1 = "Low Memory Error"'
        Add-Content -Path $HOME\Documents\WindowsPowerShell\aikiller.ps1 -Value '$button1 = "YesNo"'
        Add-Content -Path $HOME\Documents\WindowsPowerShell\aikiller.ps1 -Value '$img1 = "Warning"'
        Add-Content -Path $HOME\Documents\WindowsPowerShell\aikiller.ps1 -Value '$msgdiag2 = "AMD GPU Driver has failed due to user forcing Illustrator to run on Low Memory. Forcing Adobe Illustrator to close."'
        Add-Content -Path $HOME\Documents\WindowsPowerShell\aikiller.ps1 -Value '$title2 = "AMD GPU Crash"'
        Add-Content -Path $HOME\Documents\WindowsPowerShell\aikiller.ps1 -Value '$button2 = "OK"'
        Add-Content -Path $HOME\Documents\WindowsPowerShell\aikiller.ps1 -Value '$img2 = "None"'
        Add-Content -Path $HOME\Documents\WindowsPowerShell\aikiller.ps1 -Value '$wait = "Start-Sleep 1"'
        Add-Content -Path $HOME\Documents\WindowsPowerShell\aikiller.ps1 -Value '$wait2 = "Start-Sleep 5"'
        Add-Content -Path $HOME\Documents\WindowsPowerShell\aikiller.ps1 -Value '$appname = "Stop-Process -Name *<appname_lowercase>*"'
        Add-Content -Path $HOME\Documents\WindowsPowerShell\aikiller.ps1 -Value '$i = 0'
        Add-Content -Path $HOME\Documents\WindowsPowerShell\aikiller.ps1 -Value 'while (1) {'
        Add-Content -Path $HOME\Documents\WindowsPowerShell\aikiller.ps1 -Value 'if (Get-Process -Name *<appname_lowercase>*) {'
        Add-Content -Path $HOME\Documents\WindowsPowerShell\aikiller.ps1 -Value 'Invoke-Expression $wait'
        Add-Content -Path $HOME\Documents\WindowsPowerShell\aikiller.ps1 -Value '$aicrsh = [System.Windows.Messagebox]::Show($msgdiag1, $title1, $button1, $img1)'
        Add-Content -Path $HOME\Documents\WindowsPowerShell\aikiller.ps1 -Value 'switch ($aicrsh) {'
        Add-Content -Path $HOME\Documents\WindowsPowerShell\aikiller.ps1 -Value '"Yes" {Invoke-Expression $appname; Invoke-Expression $wait2; break}'
        Add-Content -Path $HOME\Documents\WindowsPowerShell\aikiller.ps1 -Value '"No" {$i++; Invoke-Expression $wait}'
        Add-Content -Path $HOME\Documents\WindowsPowerShell\aikiller.ps1 -Value '}'
        Add-Content -Path $HOME\Documents\WindowsPowerShell\aikiller.ps1 -Value '}'
        Add-Content -Path $HOME\Documents\WindowsPowerShell\aikiller.ps1 -Value 'if ($i -eq 4) {'
        Add-Content -Path $HOME\Documents\WindowsPowerShell\aikiller.ps1 -Value '$i = 0'
        Add-Content -Path $HOME\Documents\WindowsPowerShell\aikiller.ps1 -Value 'gpucrash'
        Add-Content -Path $HOME\Documents\WindowsPowerShell\aikiller.ps1 -Value '}'
        Add-Content -Path $HOME\Documents\WindowsPowerShell\aikiller.ps1 -Value 'function gpucrash {'
        Add-Content -Path $HOME\Documents\WindowsPowerShell\aikiller.ps1 -Value 'Invoke-Expression $wait'
        Add-Content -Path $HOME\Documents\WindowsPowerShell\aikiller.ps1 -Value '$gpcrsh = [System.Windows.Messagebox]::Show($msgdiag2, $title2, $button2, $img2)'
        Add-Content -Path $HOME\Documents\WindowsPowerShell\aikiller.ps1 -Value 'switch ($gpcrsh) {'
        Add-Content -Path $HOME\Documents\WindowsPowerShell\aikiller.ps1 -Value '"OK" {Invoke-Expression $appname; Invoke-Expression $wait2; break}'
        Add-Content -Path $HOME\Documents\WindowsPowerShell\aikiller.ps1 -Value '}'
        Add-Content -Path $HOME\Documents\WindowsPowerShell\aikiller.ps1 -Value '}'
        Add-Content -Path $HOME\Documents\WindowsPowerShell\aikiller.ps1 -Value '}'
    }    
    if ($register) {
        Write-Host 'checking runtime script'
        Invoke-Expression $wait
        if (!(Test-Path $HOME\Documents\WindowsPowerShell\aikiller.ps1)) {
            Write-Host 'runtime script does not exist'
            Invoke-Expression $wait
            Write-Host 'creating runtime script'
            New-Item -Path $HOME\Documents\WindowsPowerShell\ -Name 'aikiller.ps1'
            appension
            
        }
        else {
            Write-Host 'runtime script exists'
        }
        Invoke-Expression $wait
        Write-Host 'checking task scheduler for existing jobs'
        if (!(Get-ScheduledTask -TaskName aikiller -ErrorAction SilentlyContinue)) {
            Write-Host 'task does not exist'
            Invoke-Expression $wait
            Write-Host 'creating new scheduled task'
            Invoke-Expression $wait
            jobstart
        }
        else {
            Write-Host 'task already exists'
        }
        Invoke-Expression $wait
    }
    if ($unregister) {
        Write-Host 'checking task scheduler for existing jobs'
        Invoke-Expression $wait
        if (Get-ScheduledTask -TaskName aikiller -ErrorAction SilentlyContinue) {
            Write-Host 'task found'
            Invoke-Expression $wait
            Write-Host 'stopping scheduled task'
            Invoke-Expression $wait
            jobstop
        }
        else {
            Write-Host 'no such tast exists or have been created'
        }
        if (Test-Path $HOME\Documents\WindowsPowerShell\aikiller.ps1) {
            Write-Host 'runtime file exists'
            Invoke-Expression $wait
            Write-Host 'initiating cleanup'
            cleanup
        }
        else {
            Write-Host 'runetime file does not exist thus no cleanup required'
        }
    }
    if ($check) {
        if (Test-Path $HOME\Documents\WindowsPowerShell\aikiller.ps1) {
            Write-Host 'runtime file exists'
        }
        else {
            Write-Host 'runetime file does not exist'
        }
        if (Get-ScheduledTask -TaskName aikiller -ErrorAction SilentlyContinue) {
            Write-Host 'scheduled task has been created and is ready'
        }
        else {
            Write-Host 'no such tast exists or have been created'
        }
        Invoke-Expression $wait
    }
}