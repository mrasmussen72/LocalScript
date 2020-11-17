#region variables
$stringBuilder  = New-Object System.Text.StringBuilder                                      # Logging
[string] $LocalLogFileNameAndPath =                     "c:\Source\LocalScript.Log"         # File name and path of the log file 
[bool]$CleanUp =                                        $false                              # Deletes the log file
#endregion 

#region Template Functions 
####Functions#############################################################
function Write-Logging()
{
    param
    (
        [string]    $Message,
        [string]      $LocalLogFileNameAndPath,
        [bool]      $EndOfMessage
    )
    
    try 
    {
        $success = $false
        $dateTime = Get-Date -Format yyyyMMddTHHmmss

        #Create string
        $stringBuilder.Append($dateTime.ToString()) | Out-Null
        $stringBuilder.Append( "`t==>>`t") | Out-Null
        $stringBuilder.AppendLine( $Message) | Out-Null

        if($EndOfMessage)
        {
            #Write data
            $stringBuilder.ToString() | Out-File -FilePath $LocalLogFileNameAndPath -Append -Force
            $success = $true
            $stringBuilder.Clear()
        }
        $success = $true
    }
    catch {$success = $false; throw}
    return $success
} 
function CleanUp
{
    try {Remove-Item -Path $LocalLogFileNameAndPath}catch{}
}
function LoggingHelper
{
    param(
        [string]$Message,
        [bool]$EndOfMessage
    )
    if(!(Write-Logging -Message $Message -EndOfMessage $EndOfMessage -LocalLogFileNameAndPath $LocalLogFileNameAndPath)){Write-Host "Failed to log codetrace"}
}
#endregion

#region Begin Code (Expand line 68 to enter your code)
try 
{
    LoggingHelper -Message "Starting Script" -EndOfMessage $false
    Write-Host "Starting Script"
    try 
    {
        Add-Type -AssemblyName System.DirectoryServices.AccountManagement
        $user = [System.Security.Principal.WindowsIdentity]::getcurrent().Name
        LoggingHelper -Message "Current User: $($user)" -EndOfMessage $false
    }
    catch { continue }
    try
    {
        #region Add Your Code#######################################################################################################################################################

        #endregion End Add Your Code################################################################################################################################################################
    } catch{Write-Host ("Error: $($_.Exception.Message)")}
}
catch{}
if($CleanUp){CleanUp}
LoggingHelper -Message "Ending Script" -EndOfMessage $true
Write-Host "Ending Script"
#endregion