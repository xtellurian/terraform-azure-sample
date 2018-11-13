
###############################################################
# Script Parameters                                           #
###############################################################

while getopts a:g:n:t: option
do
    case "${option}"
    in
    a) ACCOUNT=${OPTARG};;
    g) RESOURCE_GROUP_NAME=${OPTARG};;
    n) CONTAINER_NAME=${OPTARG};;
    t) TOKEN=${OPTARG};;
    esac
done

if [ -z "$TOKEN" ]; then
    echo "-t is a required argument - Azure DevOps personal access token"
    exit 1
fi

if [ -z "$RESOURCE_GROUP_NAME" ]; then
    echo "Resource Group Name not provided. Using default tf-agents"
    RESOURCE_GROUP_NAME="tf-agents"
fi
if [ -z "$CONTAINER_NAME" ]; then
    echo "Container Name not provided. Using default vs-agent"
    CONTAINER_NAME="vs-agent"
fi
if [ -z "$ACCOUNT" ]; then
    echo "Azure DevOps account was not provided with flag -a - it is a required argument"
    exit 1
fi

ACR_NAME=agents
# use this image if you din't want to use your own ACR
# IMAGE="flanagan89/tf-vsts-agent:latest"

###############################################################
# Script Begins                                               #
###############################################################

# Create resource group
echo "Creating resource group $RESOURCE_GROUP_NAME"
az group create --name $RESOURCE_GROUP_NAME --location australiaeast

# create the container
ACR_PASSWORD=$(az acr credential show -g $RESOURCE_GROUP_NAME -n $ACR_NAME --query passwords[1].value --out tsv)

echo "Creating ACI $CONTAINER_NAME from image $ACR_NAME.azurecr.io/vsts-agent:latest"

az container create --resource-group $RESOURCE_GROUP_NAME --name $CONTAINER_NAME --assign-identity \
    --image $ACR_NAME.azurecr.io/vsts-agent:latest \
    --registry-login-server $ACR_NAME.azurecr.io \
    --registry-username $ACR_NAME \
    --registry-password $ACR_PASSWORD \
    --environment-variables VSTS_ACCOUNT=$ACCOUNT VSTS_TOKEN=$TOKEN VSTS_POOL=terraform-aci

# # use this line if you just want to use the regular image
# az container create --resource-group $RESOURCE_GROUP_NAME --name $CONTAINER_NAME --assign-identity \
#     --image $IMAGE \
#     --environment-variables VSTS_ACCOUNT=$ACCOUNT VSTS_TOKEN=$TOKEN VSTS_POOL=terraform-aci

#get identity of container
spID=$(az container show --resource-group $RESOURCE_GROUP_NAME --name $CONTAINER_NAME --query identity.principalId --out tsv)

# used with >~ terraform plan -var "use_msi=true"
SubscriptionId=$(az account show --query id --out tsv)
az role assignment create --assignee $spID --role 'Contributor' --scope /subscriptions/$SubscriptionId
echo "done"
# https://docs.microsoft.com/en-us/cli/azure/role/assignment?view=azure-cli-latest#az-role-assignment-create
