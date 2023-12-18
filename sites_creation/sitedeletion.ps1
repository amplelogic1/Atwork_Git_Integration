param (
    [string]$ProjectCode,
    [string]$DriveLetter = "D:"
)

# Function to delete websites and resources
function Delete-ProjectResources {
    param (
        [string]$ProjectCode,
        [string]$DriveLetter
    )

    $siteNames = @("${ProjectCode}_Design_Client", "${ProjectCode}_Run_Client", "${ProjectCode}_Audit", "${ProjectCode}_Design_Server")

    foreach ($siteName in $siteNames) {
        $appPoolName = $siteName + "_AppPool"
        Remove-Website -Name $siteName -Confirm:$false
        Remove-WebAppPool -Name $appPoolName
    }

    $basePath = Join-Path $DriveLetter -ChildPath "Plaform3.0_Projects\$ProjectCode"
    if (Test-Path $basePath -PathType Container) {
        Remove-Item -Path $basePath -Recurse -Force
    }
}

# Call the function to delete websites and resources
Delete-ProjectResources -ProjectCode $ProjectCode -DriveLetter $DriveLetter
