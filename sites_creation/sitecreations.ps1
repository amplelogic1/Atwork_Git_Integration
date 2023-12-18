param (
    [string]$ProjectCode,
    [string]$DriveLetter = "C:"
)

# Function to create directories
function New-ProjectDirectories {
    param (
        [string]$ProjectCode,
        [string]$DriveLetter
    )

    $basePath = Join-Path $DriveLetter -ChildPath "Platform3.0_Projects\$ProjectCode"

    if (-not (Test-Path $basePath -PathType Container)) {
        New-Item -Path $basePath -ItemType Directory | Out-Null
    }

    $directories = @(
        "${ProjectCode}_Design_Client",
        "${ProjectCode}_Run_Client",
        "${ProjectCode}_Audit",
        "${ProjectCode}_Design_Server",
        "${ProjectCode}_Runner_files"  # Added this line
    )

    foreach ($dir in $directories) {
        $dirPath = Join-Path $basePath -ChildPath $dir
        if (-not (Test-Path $dirPath -PathType Container)) {
            New-Item -Path $dirPath -ItemType Directory | Out-Null
        }
    }
}

# Import the IIS module
Import-Module WebAdministration

# Function to create a website with ApplicationPoolIdentity
function New-WebsiteWithAppPoolIdentity {
    param (
        [string]$siteName
    )

    $appPort = Get-RandomAvailablePort
    $appPoolName = $siteName + "_AppPool"

    # Create the application pool with ApplicationPoolIdentity
    New-WebAppPool -Name $appPoolName -Force
    Set-ItemProperty "IIS:\AppPools\$appPoolName" -Name processModel.identityType -Value 4
    Set-ItemProperty "IIS:\AppPools\$appPoolName" -Name startMode -Value "AlwaysRunning"

    # Create the website with the application pool identity and the generated port
    New-Website -Name $siteName -PhysicalPath (Join-Path $DriveLetter -ChildPath "Platform3.0_Projects\$ProjectCode\$siteName") -ApplicationPool $appPoolName -Port $appPort -Force

    return $appPort
}

# Function to create the "Design_Server" website with ApplicationPoolUser
function New-WebsiteWithAppPoolUser {
    param (
        [string]$siteName
    )

    $appPort = Get-RandomAvailablePort
    $appPoolName = $siteName + "_AppPool"
    $appPoolUser = "corp\alplatform"
    $appPoolPassword = "Welcome2ALP"

    # Create the application pool
    New-WebAppPool -Name $appPoolName -Force

    # Set the application pool identity to use the existing user
    Set-ItemProperty "IIS:\AppPools\$appPoolName" -Name processModel -Value @{userName="$appPoolUser"; password="$appPoolPassword"; identityType=3}
    Set-ItemProperty "IIS:\AppPools\$appPoolName" -Name startMode -Value "AlwaysRunning"

    # Create the website
    New-Website -Name $siteName -PhysicalPath (Join-Path $DriveLetter -ChildPath "Platform3.0_Projects\$ProjectCode\$siteName") -ApplicationPool $appPoolName -Port $appPort -Force

    return $appPort
}

# Function to generate a random available port number
function Get-RandomAvailablePort {
    $minPort = 1000
    $maxPort = 9999

    while ($true) {
        $randomPort = Get-Random -Minimum $minPort -Maximum $maxPort
        $netstatResult = Test-NetConnection -ComputerName localhost -Port $randomPort -InformationLevel Detailed

        if (-not $netstatResult.TcpTestSucceeded) {
            return $randomPort
        }
    }
}

# Call the function to create directories
New-ProjectDirectories -ProjectCode $ProjectCode -DriveLetter $DriveLetter

# Create websites with random port numbers
$site1Name = "${ProjectCode}_Design_Client"
New-WebsiteWithAppPoolIdentity -siteName $site1Name

$site2Name = "${ProjectCode}_Run_Client"
New-WebsiteWithAppPoolIdentity -siteName $site2Name

$site3Name = "${ProjectCode}_Audit"
New-WebsiteWithAppPoolIdentity -siteName $site3Name

$site4Name = "${ProjectCode}_Design_Server"
New-WebsiteWithAppPoolUser -siteName $site4Name
