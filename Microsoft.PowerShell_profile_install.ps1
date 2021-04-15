$target = "$PSScriptRoot\Microsoft.PowerShell_profile.ps1"
new-item -Type SymbolicLink -path ~\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1 -Target $target

new-item -Type SymbolicLink -path ~\Documents\PowerShell\profile.ps1 -Target $target 