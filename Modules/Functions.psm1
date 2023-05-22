Function Find-Dependency {
    <#
    .SYNOPSIS
    Looks for the Microsoft.Graph module.
    
    .DESCRIPTION
    Returns nothing or throws an error if not found.
    
    .EXAMPLE
    Find-Dependency
    
    .NOTES
    This is stupid simple, but could be extended down the road.
    #> 

    # No Params at this time.
    param()

    $Modules = Get-Module -Name "Microsoft.Graph" -ListAvailable

    if (!$Modules) {
        throw "Microsoft Graph is not installed."
    }
}

Function Get-NextAction {
    <#
    .SYNOPSIS
    Short description
    
    .DESCRIPTION
    Long description
    
    .EXAMPLE
    An example
    
    .NOTES
    General notes
    #>

    # No Params needs
    param()
    $Continue = ""

    ## Ask the user if they want to continue.
    While ($Continue.ToLower() -ne "y" -and $Continue.ToLower() -ne "n") {
        $Continue = Read-Host "`r`n Continue? Y/N "
        Write-Host $Continue.ToLower()
    }

    $Output = $False
    if ($Continue.ToLower() -eq "y") {
        $Output = $True
    }

    return $Output
}

Function Find-UserId {
    <#
    .SYNOPSIS
    Short description
    
    .DESCRIPTION
    Long description
    
    .EXAMPLE
    An example
    
    .NOTES
    General notes
    #>

    param()
    # Get Search Criteria
    $Search = Read-Host " Enter Search"

    # Check emails and names
    $MailLookup = Get-MgUser -Search "Mail:$Search" -ConsistencyLevel eventual
    $DisplayNameLookup = Get-MgUser -Search "DisplayName:$Search" -ConsistencyLevel eventual

    # Combine and Display
    $DisplayUsers = @()
    $DisplayUsers += $MailLookup 
    $DisplayUsers += $DisplayNameLookup

    return  $DisplayUsers
    
}

Function Show-Results {
    param(
        $Results
    )

    Write-Host "`r`n"

    ForEach($Result in $Results) {
        $Id = $Result.ID
        $Mail = $Result.Mail
        $Name = $Result.DisplayName
        Write-Host "$Id`: $Name`: $Mail" -ForegroundColor Yellow
    }
}