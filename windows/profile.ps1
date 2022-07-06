oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\arcanine.omp.json" | Invoke-Expression

Set-PSReadLineOption -HistoryNoDuplicates:$true -HistorySearchCursorMovesToEnd:$true
Set-PSReadLineOption -HistorySearchCursorMovesToEnd:$true
Set-PSReadLineOption -PredictionSource History

try {
  Set-PSReadLineOption -PredictionViewStyle ListView -WarningAction SilentlyContinue -WarningVariable cantUsePredictionViewStyle

  if ($cantUsePredictionViewStyle) {
    Throw $cantUsePredictionViewStyle
  }
}
catch {
  Set-PSReadLineOption -PredictionViewStyle InlineView
}

Set-PSReadLineOption -EditMode Vi
Set-PSReadLineOption -ViModeIndicator Script
Set-PSReadLineOption -BellStyle None

Set-PSReadLineOption -Colors @{
  "Comment"                = "#566573"
  "Command"                = "#8E44AD"
  "ContinuationPrompt"     = "#D5D8DC"
  "Emphasis"               = "#27AE60"
  "Keyword"                = "#52BE80"
  "ListPrediction"         = "#1F618D"
  "ListPredictionSelected" = "#D35400"
  "Member"                 = "black"
  "Number"                 = "#E74C3C"
  "Operator"               = "#E74C3C"
  "Parameter"              = "#3498DB"
  "String"                 = "#28B463"
  "Type"                   = "#DE3163"
  "Variable"               = "#E0115F"
}

Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete
Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward
Set-PSReadLineKeyHandler -Chord Ctrl+Shift+a, Ctrl+Shift+A -Function SelectAll
Set-PSReadLineKeyHandler -Chord Ctrl+Shift+l, Ctrl+Shift+L -Function RevertLine
Set-PSReadLineKeyHandler -Chord Ctrl+Shift+j, Ctrl+Shift+J -Function BackwardWord
Set-PSReadLineKeyHandler -Chord Ctrl+Shift+l, Ctrl+Shift+L -Function NextWord
Set-PSReadLineKeyHandler -Chord Ctrl+u -Function DeleteLine
Set-PSReadLineKeyHandler -Chord Ctrl+d, Ctrl+c -Function CaptureScreen

