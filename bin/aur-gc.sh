

#!/bin/bash
# Remove unused build files in aur-sync cache
XDG_CACHE_HOME=${XDG_CACHE_HOME:-$HOME/.cache}
AURDEST=${AURDEST:-$XDG_CACHE_HOME/aurutils/sync}

# Assumes build files were retrieved through git(1)
find "$AURDEST" -name .git -execdir git clean -xf \;

# Print directories which do not contain a PKGBUILD file
for d in "$AURDEST"/*; do
   [[ -f $d/PKGBUILD ]] || printf '%s\n' "$d"
done
