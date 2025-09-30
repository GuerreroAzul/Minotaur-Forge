find . -type f -name "*.exe" -printf "%f\n" | while read f; do echo "$f : $(md5sum "$f" | awk '{print $1}')"; done > checksums.txt
