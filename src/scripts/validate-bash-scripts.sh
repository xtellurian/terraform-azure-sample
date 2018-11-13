# be in root directory

cd "$(dirname "$0")"
cd ../..

# this same code is run in the build pipe

# find all files with .sh and validate with bash -n
find . -name '*.sh' | while read p; do (>&2 bash -n $p) done 