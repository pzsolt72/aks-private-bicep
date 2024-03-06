$template="bicep/main.bicep"
$parameters="bicep/main.parameters.json"

$location="westeurope"

# AKS cluster name
$aksPrefix="AsmlSapAks"
$aksName="${aksPrefix}"
$aksResourceGroupName="${aksPrefix}RG"


$acrName="${aksPrefix}Acr"


$vmName="${aksPrefix}Vm"

$keyVaultName="${aksPrefix}KeyVault"

az group create --name $aksResourceGroupName --location $location

az deployment group create `
        --resource-group $aksResourceGroupName `
        --template-file $template `
        --parameters $parameters `
        --parameters aksClusterName=$aksName `
        aksClusterKubernetesVersion=$kubernetesVersion `
        acrName=$acrName `
        keyVaultName=$keyVaultName `
        vmName=$vmName

az aks command invoke -g AsmlSapAksRG -n AsmlSapAks -c "kubectl get pods"

$userPrincipalName=$(az account show --query user.name --output tsv)
$userPrincipalName
#$userObjectId=$(az ad user show --id $userPrincipalName --query id --output tsv)

$userObjectId='46aa1c0c-a400-4a58-bd46-160fd00fd2a2'
$aksClusterId=$(az aks show --name "$aksName" --resource-group "$aksResourceGroupName" --query id  --output tsv)
$aksClusterId

$role="Azure Kubernetes Service RBAC Cluster Admin"

az role assignment list --assignee $userObjectId --scope $aksClusterId --query "[?roleDefinitionName=='$role'].roleDefinitionName" `
  --output tsv


az role assignment create --role "$role" --assignee $userObjectId --scope $aksClusterId --only-show-errors


az acr import --name $acrName --source docker.io/library/nginx:latest --image nginx:latest