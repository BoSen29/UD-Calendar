function Get-UDCalElement {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
        [string]$Id
    )
    try {
        return ((Get-UDElement -Id $Id).Attributes.date | Out-UDCalDate);
    }
    catch {
        throw "Failed getting the calendar data."
    }
}