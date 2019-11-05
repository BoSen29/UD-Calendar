function Out-UDCalDate {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
        [string]$date
    )
    try {
        return [datetime]$date
    }
    catch {
        throw "Failed to convert time to datetime."
    }
    
}