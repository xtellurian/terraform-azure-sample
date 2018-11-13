
while getopts p: option
do
    case "${option}"
    in
    p) PLAN_PATH=${OPTARG};;
    esac
done

if [ -z "$PLAN_PATH" ]; then
    echo "No plan provided. Using files."
    terraform apply -auto-approve \
    -var "use_msi=$USE_MSI" \
    -var "tenant=$TENANT_ID" \
    -var "subscription=$SUBSCRIPTION_ID" \
    -var "environment=$ENVIRONMENT" \
    $PLAN_PATH
else
    echo "Applying Plan $PLAN_PATH"
    terraform apply -auto-approve $PLAN_PATH
fi