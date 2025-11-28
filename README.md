to run the xiaomi concat script

for d in */; do     
  (cd "$d" && bash ../concat_xiaomi.sh); 
done
