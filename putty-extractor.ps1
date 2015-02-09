$defined_options =  ,('PublicKeyFile','-i')
$defined_options += ,('RemoteCommand','-t')
$defined_options += ,('PortNumber','-p')


# Returns an empty string if not set
Function set_option
{
    param ($option, $value)
    if ($value -ne "") # THIS IS ALWAYS TRUE?!
    {   
        $r='{0} "{1}"' -f $option, $value
        return $r
    }
    return ""
}

Get-ChildItem -Path Microsoft.PowerShell.Core\Registry::HKEY_CURRENT_USER\Software\SimonTatham\PuTTY\Sessions | ForEach-Object {
    
    if ($_.GetValue('HostName') -ne "" -and $_.GetValue('Protocol') -eq "ssh"){
        $hostname=$_.GetValue('HostName')
        $f = $true
        foreach ($opt in $defined_options){
            $formatted = set_option $opt[1] $_.GetValue($opt[0])
            if ($f -eq $true){ 
                if ($_.GetValue($opt[0])){ # THIS IS ALWAYS TRUE?!
                    
                    $options = ,($formatted)
                    $f = $false
                }
            } else {
                $options += ,($formatted)
            }
        }
        Write-Host "ssh $hostname $options"
    }
}
