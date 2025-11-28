to run the xiaomi concat script

for d in */; do     
  (cd "$d" && bash ../concat_xiaomi.sh); 
done

to delete raw files run this in powershell:
Get-ChildItem . -File -Recurse |
    Where-Object { $_.Name -ne "concatenated_output.mp4" } |
    Remove-Item -Force

to remove all the files
# Run this inside the parent directory that contains folders like YYYYMMDDHH
Get-ChildItem -Directory | ForEach-Object {

    $folder = $_.Name

    # Validate folder name format YYYYMMDDHH (10 digits)
    if ($folder -match '^\d{10}$') {

        # Extract DD and HH
        $day = $folder.Substring(6, 2)
        $hour = $folder.Substring(8, 2)

        $oldFile = Join-Path $_.FullName 'concatenated_output.mp4'
        $newFileName = "${day}_${hour}.mp4"
        $newFile = Join-Path $_.Parent.FullName $newFileName

        if (Test-Path $oldFile) {
            Rename-Item $oldFile -NewName $newFileName
            Move-Item (Join-Path $_.FullName $newFileName) $newFile -Force
        }
        else {
            Write-Host "No concatenated_output.mp4 in folder $folder"
        }
    }
}
