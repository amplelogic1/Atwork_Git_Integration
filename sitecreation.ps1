param (
    [string]$ProjectCode,
    [int]$StartingPort,
    [string]$DriveLetter = "D:"
)

# Function to create directories
function New-ProjectDirectories {
    param (
        [string]$ProjectCode,
        [string]$DriveLetter
    )

    $basePath = Join-Path $DriveLetter -ChildPath "Plaform3.0_Projects\$ProjectCode"

    if (-not (Test-Path $basePath -PathType Container)) {
        New-Item -Path $basePath -ItemType Directory | Out-Null
    }

    $directories = @("${ProjectCode}_Design_Client", "${ProjectCode}_Run_Client", "${ProjectCode}_Audit", "${ProjectCode}_Design_Server")

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
        [string]$siteName,
        [string]$appPort
    )

    $appPoolName = $siteName + "_AppPool"
    
    # Create the application pool with ApplicationPoolIdentity
    New-WebAppPool -Name $appPoolName -Force
    Set-ItemProperty "IIS:\AppPools\$appPoolName" -Name processModel -Value @{identityType=4}

    # Create the website with the application pool identity
    New-Website -Name $siteName -PhysicalPath (Join-Path $DriveLetter -ChildPath "Plaform3.0_Projects\$ProjectCode\$siteName") -ApplicationPool $appPoolName -Port $appPort -Force
}

# Function to create a website with ApplicationPoolUser
function New-WebsiteWithAppPoolUser {
    param (
        [string]$siteName,
        [int]$appPort,
        [string]$appPoolUser,
        [string]$appPoolPassword
    )

    $appPoolName = $siteName + "_AppPool"

    # Create the application pool
    New-WebAppPool -Name $appPoolName -Force

    # Set the application pool identity to use the existing user
    Set-ItemProperty "IIS:\AppPools\$appPoolName" -Name processModel -Value @{userName="$appPoolUser"; password="$appPoolPassword"; identityType=3}

    # Create the website
    New-Website -Name $siteName -PhysicalPath (Join-Path $DriveLetter -ChildPath "Plaform3.0_Projects\$ProjectCode\$siteName") -ApplicationPool $appPoolName -Port $appPort -Force
}

# Function to generate the next available port number
function Get-NextAvailablePort {
    $portInUse = Get-NetTCPConnection -LocalPort (1..65535) -State Listen -ErrorAction SilentlyContinue
    $allPorts = 1..65535
    $availablePort = $allPorts | Where-Object { $portInUse -notcontains $_ }
    return $availablePort[0]
}

# Call the function to create directories
New-ProjectDirectories -ProjectCode $ProjectCode -DriveLetter $DriveLetter

# Create websites
$startingPort = $StartingPort

$site1Name = "${ProjectCode}_Design_Client"
$site1Port = $startingPort
$startingPort++
New-WebsiteWithAppPoolIdentity -siteName $site1Name -appPort $site1Port

$site2Name = "${ProjectCode}_Run_Client"
$site2Port = $startingPort
$startingPort++
New-WebsiteWithAppPoolIdentity -siteName $site2Name -appPort $site2Port

$site3Name = "${ProjectCode}_Audit"
$site3Port = $startingPort
$startingPort++
New-WebsiteWithAppPoolIdentity -siteName $site3Name -appPort $site3Port

$site4Name = "${ProjectCode}_Design_Server"
$site4Port = $startingPort
$appPoolUser = "corp\alplatform"
$appPoolPassword = "Welcome2ALP"
New-WebsiteWithAppPoolUser -siteName $site4Name -appPort $site4Port -appPoolUser $appPoolUser -appPoolPassword $appPoolPassword
