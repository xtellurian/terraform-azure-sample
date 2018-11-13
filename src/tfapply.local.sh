# run this locally to exec the terraform.sh script
set -e
cd "$(dirname "$0")"

./tfapply.sh \
    -p "dev.local.tfplan" 

