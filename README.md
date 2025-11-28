to run the xiaomi concat script

for d in */; do     
  (cd "$d" && bash ../concat_xiaomi.sh); 
done

to delete raw files run this in powershell:
Get-ChildItem . -File -Recurse |
    Where-Object { $_.Name -ne "concatenated_output.mp4" } |
    Remove-Item -Force
