file=`date +"%Y-%m-%d-new.md"`
ctime=`date +"%Y-%m-%d"`
cat <<EOF >$file
---
layout: post
date: $ctime
---

EOF