file=`date +"%Y-%m-%d-new.md"`
ctime=`date +"%Y-%m-%d %H:%M:%S"`
cat <<EOF >$file
---
layout: post
date: $ctime
---

EOF