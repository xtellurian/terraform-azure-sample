cd "$(dirname "$0")"

./plan.sh \
    -e dev \
    -g tf-master \
    -a tfstatenkadsnf \
    -m false \
    -p "dev.local.tfplan" \
    -f "dev.plan.summary" \
    -z "-destroy"