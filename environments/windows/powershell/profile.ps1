oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\dcf.omp.json" | Invoke-Expression

Import-Module posh-git
Import-Module PSReadLine
Import-Module -Name Terminal-Icons

# $PSStyle.FileInfo.Directory = "`e[34m"

Set-PSReadLineOption -Colors @{
  "Comment"                = "#566573"
  "Command"                = "#a277ff"
  "ContinuationPrompt"     = "#D5D8DC"
  "Emphasis"               = "#27AE60"
  "Keyword"                = "#52BE80"
  "ListPrediction"         = "#1F618D"
  "ListPredictionSelected" = "#ff6767"
  "Member"                 = "#FFFFFF"
  "Number"                 = "#E74C3C"
  "Operator"               = "#E74C3C"
  "Parameter"              = "#0098DB"
  "String"                 = "#28B463"
  "Type"                   = "#DE3163"
  "Variable"               = "#E0115F"
}

Set-PSReadLineOption -HistorySearchCursorMovesToEnd
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle ListView

Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete
Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward

# Aliases
function workspace() { Set-Location "C:\Workspace" }
function psconfig { nvim $PROFILE }
