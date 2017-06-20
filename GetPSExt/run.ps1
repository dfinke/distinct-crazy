"Hello World"
$(foreach ($target in "vscode-powershell", "powershelleditorservices") {
        foreach ($branch in "master") {
            $url = "https://ci.appveyor.com/api/projects/PowerShell/{0}/branch/{1}" -f $target, $branch
            (Invoke-RestMethod $url).build | ForEach-Object {
                [PSCustomObject][Ordered]@{
                    Repo       = "$target/$branch"
                    Date       = (get-date $_.committed).ToShortDateString()
                    authorName = $_.authorName
                    message    = $_.message
                }
            }
        }
    }) | Sort-Object date | ConvertTo-JSON | Set-Content $res