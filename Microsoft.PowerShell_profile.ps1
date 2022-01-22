Import-Module posh-git
Import-Module DockerCompletion
import-Module PSReadLine

set-alias g git
set-alias vi neovide
set-alias d docker
remove-item alias:\curl -erroraction silentlycontinue


$env:shell = 'powershell'
$env:shellcmdflag= '-command'
$env:EDITOR='nvim'
Set-PSReadlineOption -EditMode vi -ViModeIndicator Prompt
Set-PSReadLineOption -PredictionSource History

