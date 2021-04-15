#!pwsh

$base = "E:\backup"
$scriptDir = $PSScriptRoot

function Make-Backup
{
    pushd $base
    $buname = "mydir_backup_$(get-date -f 'yyyyMMdd').7z"
    $bufile = "$base\$buname"
    
    if (-not (test-path $bufile)) {
      & Archive-Backup $bufile E:\mydir
    }
    & Copy-ToAzure $bufile

    popd
}

function Copy-ToAzure ($archiveFileName) 
{
    $env:AZCOPY_CRED_TYPE = "Anonymous";
    $args = @(
        'copy',
        $archiveFileName,
        "https://samobackupstorage.blob.core.windows.net/mybu?sv=2019-10-10&st=2020-11-23T09%3A18%3A38Z&se=2023-11-24T09%3A18%3A00Z&sr=c&sp=acw&sig=DXi9rkZH0hxjRM87JDZSrOcDEnMlNE8FNFLR3ufE4xs%3D",
        '--from-to=LocalBlob',
        '--blob-type',
        'Detect',
        '--follow-symlinks',
        '--put-md5',
        '--follow-symlinks',
        '--recursive',
        '--cap-mbps=20'
    )
    azcopy @args
    $env:AZCOPY_CRED_TYPE = "";
}

function Archive-Backup ($bufile, $mydirLocation)
{
    $PlainPassword  = & Load-PasswordFile
    7z a -r -mhe "-p$PlainPassword" $bufile $mydirLocation\*
}

function Load-PasswordFile
{
    $SecureString = cat "$scriptDir\hpdesk_make_backup.ps1.secure" | ConvertTo-SecureString 
    $BSTR =     [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($SecureString)
    $PlainPassword = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR) 
    $PlainPassword
}

function Create-PasswordFile
{
    Write-Host 'Enter password'
    $password = read-host 
    Write-Host 'Confirm password'
    $password2 =read-host
    if ($password -ne $password2)
    { 
        Write-Host 'Passwords mismatch'
    }
    else
    {
        $SecurePassword = $password | ConvertTo-SecureString -AsPlainText -Force
         $SecureStringAsPlainText = $SecurePassword | ConvertFrom-SecureString 
        echo $SecureStringAsPlainText > hpdesk_make_backup.ps1.secure
        Write-Host "Password created in hpdesk_make_backup.ps1.secure"
    }
}


# $isDotSourced = $MyInvocation.InvocationName -eq '.' -or $MyInvocation.Line -eq ''
# echo ivocName: $MyInvocation.InvocationName
# echo Line: $MyInvocation.Line
# if (-not $isDotSourced)
# {
    & Make-Backup
#}
