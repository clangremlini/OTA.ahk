#include JSON.ahk

global gh_repo = "clangremlini/aye-ahk-loader"
global file_to_download = "loader.exe"
global file_to_saving = "loader"

class OTA
{
    checkupd()
    {
        jsonStr := JSON.GetFromUrl("https://api.github.com/repos/" gh_repo "/releases/latest")
        if IsObject(jsonStr) 
        {
            MsgBox, % jsonStr[1]
            Return
        }
        if (jsonStr = "")
        Return
        obj := JSON.Parse(jsonStr)
        latest_tag := obj.tag_name
        change_log := obj.body
        if (version != latest_tag)
        {
            MsgBox, 68,, A new version is available.`n`nLatest version: %latest_tag%`nChangelog:`n`n%change_log%`n`n`nDo you want download update?
            IfMsgBox, Yes
                OTA.download(latest_tag)
        }
    }
    download(value)
    {
        download_url := "https://github.com/" gh_repo "/releases/download/" value "/" file_to_download 
        UrlDownloadToFile, %download_url%, %file_to_saving%-%value%.exe
        Run, %file_to_saving%-%value%.exe
        ExitApp
    }
}

