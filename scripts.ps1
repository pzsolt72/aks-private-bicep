$template="bicep/main.bicep"
$parameters="bicep/main.parameters.json"

$location="westeurope"

# AKS cluster name
$aksPrefix="AsmlSapAks"
$aksName="${aksPrefix}Aks"
$aksResourceGroupName="${aksPrefix}RG"
$validateTemplate=1
$useWhatIf=1

$acrName="${aksPrefix}Acr"
$acrResourceGroupName="$aksResourceGroupName"
$acrSku="Premium"

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