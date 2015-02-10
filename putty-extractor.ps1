$defined_options =  ,('PublicKeyFile','-i')
$defined_options += ,('RemoteCommand','-t')


# Returns an empty string if not set
Function set_option
{
    param ($option, $value)
    if ($value -ne "") #TODO check it required
    {
        $r='{0} "{1}"' -f $option, $value
        return $r
    }
    return ""
}

Get-ChildItem -Path Microsoft.PowerShell.Core\Registry::HKEY_CURRENT_USER\Software\SimonTatham\PuTTY\Sessions | ForEach-Object {
    $protocol = $_.GetValue('Protocol')
    $hostname = $_.GetValue('HostName')
    $port     = $_.GetValue('PortNumber')
    if ($hostname -ne "" -and $protocol -eq "ssh" -or $protocol -eq "telnet"){
        $f = $true
        # Extract defined_options from session settings
        foreach ($opt in $defined_options)
        {
            # Fortmat options for insertion
            $formatted = set_option $opt[1] $_.GetValue($opt[0])
            if ($f -eq $true)
            {
                if ($_.GetValue($opt[0])) # Check if required
                {
                    $options = ,($formatted)
                    $f = $false
                }
            }
            else
            {
                $options += ,($formatted)
            }
        }
        if ($protocol -eq "ssh")
        {
            $output = 'ssh {0} -p {1} {2}' -f $hostname, $port, $options
        }
        else # Telnet
        {
            $output = 'telnet {0} {1} {2}' -f $hostname, $port, $options
        }
        Write-Host $output
    }
}
