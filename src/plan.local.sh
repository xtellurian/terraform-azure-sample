# run this locally to exec the terraform.sh script
set -e

cd "$(dirname "$0")"

./plan.sh \
    -e dev \
    -g tf-master \
    -a tfstatenkadsnf \
    -m false \
    -r "true" \
    -p "dev.local.tfplan" \
    -f "dev.plan.summary" \
    -s "dev" \

# ./vault-outputs.sh -n "tf-dev" -g "tf-master"
