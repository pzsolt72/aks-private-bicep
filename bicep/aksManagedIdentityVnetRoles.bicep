
@description('Specifies the name of the existing virtual network.')
param virtualNetworkName string

@description('Specifies the name of the subnet hosting the worker nodes of the default system agent pool of the AKS cluster.')
param systemAgentPoolSubnetName string = 'AksSubnet'


@description('User managed.')
param managedIdentity string 

@description('Specifies the name of the subnet delegated to the API server when configuring the AKS cluster to use API server VNET integration.')
param principalId string = 'ApiServerSubnet'


// Variables
var networkContributorRoleDefinitionId = resourceId('Microsoft.Authorization/roleDefinitions', '4d97b98b-1d4f-4787-a291-c67834d212e7')


resource virtualNetwork 'Microsoft.Network/virtualNetworks@2023-09-01' existing =  {
  name: virtualNetworkName
}

resource systemAgentPoolSubnet 'Microsoft.Network/virtualNetworks/subnets@2023-09-01' existing = {
  parent: virtualNetwork
  name: systemAgentPoolSubnetName
}


resource systemAgentPoolSubnetNetworkContributorRoleAssignment 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  name: guid(managedIdentity, systemAgentPoolSubnet.id, networkContributorRoleDefinitionId, '123456')
  scope: systemAgentPoolSubnet
  properties: {
    roleDefinitionId: networkContributorRoleDefinitionId
    principalId: principalId
    principalType: 'ServicePrincipal'
  }
}


// Outputs

