// Parameters
@description('Specifies the name of the user-defined managed identity.')
param managedIdentityName string


@description('Specifies the resource group name of the virtual network.')
param virtualNetworkResourceGroup string

@description('Specifies the name of the existing virtual network.')
param virtualNetworkName string

@description('Specifies the name of the subnet hosting the worker nodes of the default system agent pool of the AKS cluster.')
param systemAgentPoolSubnetName string = 'AksSubnet'

@description('Specifies the location.')
param location string = resourceGroup().location

@description('Specifies the resource tags.')
param tags object


// Resources
resource managedIdentity 'Microsoft.ManagedIdentity/userAssignedIdentities@2023-01-31' = {
  name: managedIdentityName
  location: location
  tags: tags
}

module vnetRoleAssignment 'aksManagedIdentityVnetRoles.bicep' = {
  name: 'vnetRoleAssignment'
  scope: resourceGroup(virtualNetworkResourceGroup)
  params: {
    managedIdentity: managedIdentity.id
    principalId: managedIdentity.properties.principalId
    virtualNetworkName: virtualNetworkName
    systemAgentPoolSubnetName: systemAgentPoolSubnetName
  }
}

// Outputs
output id string = managedIdentity.id
output name string = managedIdentity.name
