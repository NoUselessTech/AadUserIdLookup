# AAD User ID Lookup
# Author: Connor Peoples
# Date: 20230522

## Imports
Import-Module .\Modules\Functions.psm1

## Logic
try {
    Clear-Host
    Write-Host " Starting the user lookup tool." -ForegroundColor White

    ## Check Dependencies
    Write-Host " Checking for Microsoft.Graph." -ForegroundColor White
    Find-Dependency

    ## Login to Microsoft Graph
    Write-Host " Logging in." -ForegroundColor White
    Connect-MgGraph -Scope User.Read.All

    ## User Lookup Time...
    $Continue = $true

    while ($Continue) {
        Clear-Host

        ## Search
        $SearchResults = Find-UserId
        Show-Results -Results $SearchResults

        ## Move Forward
        $Continue = Get-NextAction

    }

} catch {
    ## Handle the Error
    Write-Host "`r`n An issue has occurred. `r`n $_" -ForegroundColor Red

} finally {
    ## Log out
    Disconnect-MgGraph -ErrorAction Ignore

    ## Remove Module
    Remove-Module -Name Functions

    ## Exit
    Write-Host "`r`n Closing the user lookup tool." -ForegroundColor White
}
