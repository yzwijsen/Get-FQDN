function Get-FQDN
{
    <#
    .SYNOPSIS
    Gets the fully qualified domain for a given hostname
    .DESCRIPTION
    Gets the fully qualified domain name for a hostname using dns lookup.
    Accepts input from the pipeline
    .PARAMETER Computers
    Hostname of computers to run against
    .EXAMPLE
    Get-FQDN -ComputerName host1, host2
    Get-Content computers.txt | Get-FQDN
    #>

    [cmdletbinding()]
    Param (
        [parameter(ValueFromPipeline, Mandatory=$true)]
        [string[]]$ComputerName
    )

    Process  
    {
        foreach ($Computer in $ComputerName)
        {
            Try { $FQDN = [System.Net.Dns]::GetHostEntry($Computer) | Select-Object -expandProperty HostName }
            Catch {
                Write-Debug "Error getting fqdn for $Computer ($($_.Exception.Message))"
                $FQDN = $Computer
            }
            Write-Host $FQDN
        }
    }
}
Export-ModuleMember -Function Get-FQDN
