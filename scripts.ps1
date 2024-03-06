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


