@description('Specifies the location of AKS cluster.')
param location string = resourceGroup().location

@description('Specifies the name of the AKS cluster.')
param aksClusterName string = 'aks-${uniqueString(resourceGroup().id)}'

@description('Specifies whether creating metric alerts or not.')
param createMetricAlerts bool = true

@description('Specifies whether metric alerts as either enabled or disabled.')
param metricAlertsEnabled bool = true

@description('Specifies metric alerts eval frequency.')
param metricAlertsEvalFrequency string = 'PT1M'

@description('Specifies metric alerts window size.')
param metricAlertsWindowsSize string = 'PT1H'

@description('Specifies the DNS prefix specified when creating the managed cluster.')
param aksClusterDnsPrefix string = aksClusterName

@description('Specifies the network plugin used for building Kubernetes network. - azure or kubenet.')
@allowed([
  'azure'
  'kubenet'
])
param aksClusterNetworkPlugin string = 'kubenet'

@description('Specifies the network policy used for building Kubernetes network. - calico or azure')
@allowed([
  'azure'
  'calico'
])
param aksClusterNetworkPolicy string = 'calico'

@description('Specifies the CIDR notation IP range from which to assign pod IPs when kubenet is used.')
param aksClusterPodCidr string = '192.168.0.0/16'

@description('A CIDR notation IP range from which to assign service cluster IPs. It must not overlap with any Subnet IP ranges.')
param aksClusterServiceCidr string = '172.16.0.0/16'

@description('Specifies the IP address assigned to the Kubernetes DNS service. It must be within the Kubernetes service address range specified in serviceCidr.')
param aksClusterDnsServiceIP string = '172.16.0.10'


@description('Specifies the sku of the load balancer used by the virtual machine scale sets used by nodepools.')
@allowed([
  'basic'
  'standard'
])
param aksClusterLoadBalancerSku string = 'standard'

@description('Specifies outbound (egress) routing method. - loadBalancer or userDefinedRouting.')
@allowed([
  'loadBalancer'
  'userDefinedRouting'
])
param aksClusterOutboundType string = 'loadBalancer'

@description('Specifies the tier of a managed cluster SKU: Standard or Free')
@allowed([
  'Standard'
  'Free'
])
param aksClusterSkuTier string = 'Standard'

@description('Specifies the version of Kubernetes specified when creating the managed cluster.')
param aksClusterKubernetesVersion string = '1.18.8'

@description('Specifies the administrator username of Linux virtual machines.')
param aksClusterAdminUsername string = 'azureuser'

@description('Specifies the SSH RSA public key string for the Linux nodes.')
param aksClusterSshPublicKey string

@description('Specifies the tenant id of the Azure Active Directory used by the AKS cluster for authentication.')
param aadProfileTenantId string = subscription().tenantId

@description('Specifies the AAD group object IDs that will have admin role of the cluster.')
param aadProfileAdminGroupObjectIDs array = []

@description('Specifies the upgrade channel for auto upgrade. Allowed values include rapid, stable, patch, node-image, none.')
@allowed([
  'rapid'
  'stable'
  'patch'
  'node-image'
  'none'
])
param aksClusterUpgradeChannel string = 'stable'

@description('Specifies whether to create the cluster as a private cluster or not.')
param aksClusterEnablePrivateCluster bool = true

@description('Specifies the Private DNS Zone mode for private cluster. When the value is equal to None, a Public DNS Zone is used in place of a Private DNS Zone')
param aksPrivateDNSZone string = 'system'

@description('Specifies whether to create additional public FQDN for private cluster or not.')
param aksEnablePrivateClusterPublicFQDN bool = false

@description('Specifies whether to enable managed AAD integration.')
param aadProfileManaged bool = true

@description('Specifies whether to  to enable Azure RBAC for Kubernetes authorization.')
param aadProfileEnableAzureRBAC bool = true

@description('Specifies the unique name of of the system node pool profile in the context of the subscription and resource group.')
param systemAgentPoolName string = 'nodepool1'

@description('Specifies the vm size of nodes in the system node pool.')
param systemAgentPoolVmSize string = 'Standard_DS5_v2'

@description('Specifies the OS Disk Size in GB to be used to specify the disk size for every machine in the system agent pool. If you specify 0, it will apply the default osDisk size according to the vmSize specified.')
param systemAgentPoolOsDiskSizeGB int = 100

@description('Specifies the OS disk type to be used for machines in a given agent pool. Allowed values are \'Ephemeral\' and \'Managed\'. If unspecified, defaults to \'Ephemeral\' when the VM supports ephemeral OS and has a cache disk larger than the requested OSDiskSizeGB. Otherwise, defaults to \'Managed\'. May not be changed after creation. - Managed or Ephemeral')
@allowed([
  'Ephemeral'
  'Managed'
])
param systemAgentPoolOsDiskType string = 'Ephemeral'

@description('Specifies the number of agents (VMs) to host docker containers in the system node pool. Allowed values must be in the range of 1 to 100 (inclusive). The default value is 1.')
param systemAgentPoolAgentCount int = 3

@description('Specifies the OS type for the vms in the system node pool. Choose from Linux and Windows. Default to Linux.')
@allowed([
  'Linux'
  'Windows'
])
param systemAgentPoolOsType string = 'Linux'

@description('Specifies the maximum number of pods that can run on a node in the system node pool. The maximum number of pods per node in an AKS cluster is 250. The default maximum number of pods per node varies between kubenet and Azure CNI networking, and the method of cluster deployment.')
param systemAgentPoolMaxPods int = 30

@description('Specifies the maximum number of nodes for auto-scaling for the system node pool.')
param systemAgentPoolMaxCount int = 5

@description('Specifies the minimum number of nodes for auto-scaling for the system node pool.')
param systemAgentPoolMinCount int = 3

@description('Specifies whether to enable auto-scaling for the system node pool.')
param systemAgentPoolEnableAutoScaling bool = true

@description('Specifies the virtual machine scale set priority in the system node pool: Spot or Regular.')
@allowed([
  'Spot'
  'Regular'
])
param systemAgentPoolScaleSetPriority string = 'Regular'

@description('Specifies the ScaleSetEvictionPolicy to be used to specify eviction policy for spot virtual machine scale set. Default to Delete. Allowed values are Delete or Deallocate.')
@allowed([
  'Delete'
  'Deallocate'
])
param systemAgentPoolScaleSetEvictionPolicy string = 'Delete'

@description('Specifies the Agent pool node labels to be persisted across all nodes in the system node pool.')
param systemAgentPoolNodeLabels object = {}

@description('Specifies the taints added to new nodes during node pool create and scale. For example, key=value:NoSchedule.')
param systemAgentPoolNodeTaints array = []

@description('Determines the placement of emptyDir volumes, container runtime data root, and Kubelet ephemeral storage.')
@allowed([
  'OS'
  'Temporary'
])
param systemAgentPoolKubeletDiskType string = 'OS'

@description('Specifies the type for the system node pool: VirtualMachineScaleSets or AvailabilitySet')
@allowed([
  'VirtualMachineScaleSets'
  'AvailabilitySet'
])
param systemAgentPoolType string = 'VirtualMachineScaleSets'

@description('Specifies the availability zones for the agent nodes in the system node pool. Requirese the use of VirtualMachineScaleSets as node pool type.')
param systemAgentPoolAvailabilityZones array = [
  '1'
  '2'
  '3'
]

@description('Specifies whether the httpApplicationRouting add-on is enabled or not.')
param httpApplicationRoutingEnabled bool = false

@description('Specifies whether the Open Service Mesh add-on is enabled or not.')
param openServiceMeshEnabled bool = false

@description('Specifies whether the Kubernetes Event-Driven Autoscaler (KEDA) add-on is enabled or not.')
param kedaEnabled bool = false

@description('Specifies whether the aciConnectorLinux add-on is enabled or not.')
param aciConnectorLinuxEnabled bool = false

@description('Specifies whether the azurepolicy add-on is enabled or not.')
param azurePolicyEnabled bool = true

@description('Specifies whether the kubeDashboard add-on is enabled or not.')
param kubeDashboardEnabled bool = false

@description('Specifies whether the pod identity addon is enabled..')
param podIdentityProfileEnabled bool = false

@description('Specifies the scan interval of the auto-scaler of the AKS cluster.')
param autoScalerProfileScanInterval string = '10s'

@description('Specifies the scale down delay after add of the auto-scaler of the AKS cluster.')
param autoScalerProfileScaleDownDelayAfterAdd string = '10m'

@description('Specifies the scale down delay after delete of the auto-scaler of the AKS cluster.')
param autoScalerProfileScaleDownDelayAfterDelete string = '20s'

@description('Specifies scale down delay after failure of the auto-scaler of the AKS cluster.')
param autoScalerProfileScaleDownDelayAfterFailure string = '3m'

@description('Specifies the scale down unneeded time of the auto-scaler of the AKS cluster.')
param autoScalerProfileScaleDownUnneededTime string = '10m'

@description('Specifies the scale down unready time of the auto-scaler of the AKS cluster.')
param autoScalerProfileScaleDownUnreadyTime string = '20m'

@description('Specifies the utilization threshold of the auto-scaler of the AKS cluster.')
param autoScalerProfileUtilizationThreshold string = '0.5'

@description('Specifies the max graceful termination time interval in seconds for the auto-scaler of the AKS cluster.')
param autoScalerProfileMaxGracefulTerminationSec string = '600'

@description('Specifies the name of the virtual network.')
param virtualNetworkName string = '${aksClusterName}Vnet'

@description('Specifies the name of the existing virtual network resource group.')
param virtualNetworkResourceGroup string

@description('Specifies the name of the subnet hosting the worker nodes of the default system agent pool of the AKS cluster.')
param systemAgentPoolSubnetName string = 'AksSubnet'

@description('Specifies whether to enable the Azure Blob CSI Driver. The default value is false.')
param blobCSIDriverEnabled bool = false

@description('Specifies whether to enable the Azure Disk CSI Driver. The default value is true.')
param diskCSIDriverEnabled bool = true

@description('Specifies whether to enable the Azure File CSI Driver. The default value is true.')
param fileCSIDriverEnabled bool = true

@description('Specifies whether to enable the Snapshot Controller. The default value is true.')
param snapshotControllerEnabled bool = true

@description('Specifies whether to enable Defender threat detection. The default value is false.')
param defenderSecurityMonitoringEnabled bool = false

@description('Specifies whether to enable ImageCleaner on AKS cluster. The default value is false.')
param imageCleanerEnabled bool = false

@description('Specifies whether ImageCleaner scanning interval in hours.')
param imageCleanerIntervalHours int = 24

@description('Specifies whether to enable Workload Identity. The default value is false.')
param workloadIdentityEnabled bool = true

@description('Specifies whether the OIDC issuer is enabled.')
param oidcIssuerProfileEnabled bool = true

@description('Specifies the name of the subnet hosting the pods running in the AKS cluster.')
param podSubnetName string = 'PodSubnet'

@description('Specifies the name of the subnet delegated to the API server when configuring the AKS cluster to use API server VNET integration.')
param apiServerSubnetName string = 'ApiServerSubnet'

@description('Specifies the name of the subnet which contains the virtual machine.')
param vmSubnetName string = 'VmSubnet'

@description('Specifies the name of the subnet where the private endpoints go.')
param pepSubnetName string

@description('Specifies the name of the Log Analytics Workspace.')
param logAnalyticsWorkspaceName string = '${aksClusterName}Workspace'

@description('Specifies the service tier of the workspace: Free, Standalone, PerNode, Per-GB.')
@allowed([
  'Free'
  'Standalone'
  'PerNode'
  'PerGB2018'
])
param logAnalyticsSku string = 'PerNode'

@description('Specifies the workspace data retention in days. -1 means Unlimited retention for the Unlimited Sku. 730 days is the maximum allowed for all other Skus.')
param logAnalyticsRetentionInDays int = 30

@description('Specifies the name of the virtual machine.')
param vmName string = 'TestVm'

@description('Specifies the size of the virtual machine.')
param vmSize string = 'Standard_DS3_v2'

@description('Specifies the image publisher of the disk image used to create the virtual machine.')
param imagePublisher string = 'Canonical'

@description('Specifies the offer of the platform image or marketplace image used to create the virtual machine.')
param imageOffer string = '0001-com-ubuntu-server-jammy'

@description('Specifies the Ubuntu version for the VM. This will pick a fully patched image of this given Ubuntu version.')
param imageSku string = '22_04-lts'

@description('Specifies the type of authentication when accessing the Virtual Machine. SSH key is recommended.')
@allowed([
  'sshPublicKey'
  'password'
])
param authenticationType string = 'password'

@description('Specifies the name of the administrator account of the virtual machine.')
param vmAdminUsername string

@description('Specifies the SSH Key or password for the virtual machine. SSH key is recommended.')
@secure()
param vmAdminPasswordOrKey string

@description('Specifies the storage account type for OS and data disk.')
@allowed([
  'Premium_LRS'
  'StandardSSD_LRS'
  'Standard_LRS'
  'UltraSSD_LRS'
])
param diskStorageAccounType string = 'Premium_LRS'

@description('Specifies the number of data disks of the virtual machine.')
@minValue(0)
@maxValue(64)
param numDataDisks int = 1

@description('Specifies the size in GB of the OS disk of the VM.')
param osDiskSize int = 50

@description('Specifies the size in GB of the OS disk of the virtual machine.')
param dataDiskSize int = 50

@description('Specifies the caching requirements for the data disks.')
param dataDiskCaching string = 'ReadWrite'

@description('Specifies the globally unique name for the storage account used to store the boot diagnostics logs of the virtual machine.')
param blobStorageAccountName string = 'boot${uniqueString(resourceGroup().id)}'

@description('Specifies the name of the private link to the boot diagnostics storage account.')
param blobStorageAccountPrivateEndpointName string = 'BlobStorageAccountPrivateEndpoint'

@description('Specifies the name of the private link to the Azure Container Registry.')
param acrPrivateEndpointName string = 'AcrPrivateEndpoint'

@description('Name of your Azure Container Registry')
@minLength(5)
@maxLength(50)
param acrName string = 'acr${uniqueString(resourceGroup().id)}'

@description('Enable admin user that have push / pull permission to the registry.')
param acrAdminUserEnabled bool = false

@description('Tier of your Azure Container Registry.')
@allowed([
  'Basic'
  'Standard'
  'Premium'
])
param acrSku string = 'Premium'

@description('Specifies the name of the private link to the Key Vault.')
param keyVaultPrivateEndpointName string = 'KeyVaultPrivateEndpoint'

@description('Specifies the name of the Key Vault resource.')
param keyVaultName string = 'keyvault-${uniqueString(resourceGroup().id)}'

@description('The default action of allow or deny when no other rules match. Allowed values: Allow or Deny')
@allowed([
  'Allow'
  'Deny'
])
param keyVaultNetworkAclsDefaultAction string = 'Allow'

@description('Specifies whether the Azure Key Vault resource is enabled for deployments.')
param keyVaultEnabledForDeployment bool = true

@description('Specifies whether the Azure Key Vault resource is enabled for disk encryption.')
param keyVaultEnabledForDiskEncryption bool = true

@description('Specifies whether the Azure Key Vault resource is enabled for template deployment.')
param keyVaultEnabledForTemplateDeployment bool = true

@description('Specifies whether the soft deelete is enabled for this Azure Key Vault resource.')
param keyVaultEnableSoftDelete bool = true

@description('Specifies the object ID ofthe service principals to configure in Key Vault access policies.')
param keyVaultObjectIds array = []

@description('Specifies the resource tags.')
param tags object = {
  IaC: 'Bicep'
}

@description('Specifies the resource tags.')
param clusterTags object = {
  IaC: 'Bicep'
  ApiServerVnetIntegration: true
  PodSubnet: true
  PerAgentPoolSubnet: true
}

@description('Specifies the deployment script uri.')
param deploymentScriptUri string

// Modules
module keyVault 'keyVault.bicep' = {
  name: 'keyVault'
  params: {
    name: keyVaultName
    networkAclsDefaultAction: keyVaultNetworkAclsDefaultAction
    enabledForDeployment: keyVaultEnabledForDeployment
    enabledForDiskEncryption: keyVaultEnabledForDiskEncryption
    enabledForTemplateDeployment: keyVaultEnabledForTemplateDeployment
    enableSoftDelete: keyVaultEnableSoftDelete
    objectIds: keyVaultObjectIds
    workspaceId: workspace.outputs.id
    location: location
    tags: tags
  }
}

module workspace 'logAnalytics.bicep' = {
  name: 'workspace'
  params: {
    name: logAnalyticsWorkspaceName
    location: location
    sku: logAnalyticsSku
    retentionInDays: logAnalyticsRetentionInDays
    tags: tags
  }
}

module containerRegistry 'containerRegistry.bicep' = {
  name: 'containerRegistry'
  params: {
    name: acrName
    sku: acrSku
    adminUserEnabled: acrAdminUserEnabled
    workspaceId: workspace.outputs.id
    location: location
    tags: tags
  }
}

module storageAccount 'storageAccount.bicep' = {
  name: 'storageAccount'
  params: {
    name: blobStorageAccountName
    createContainers: true
    containerNames: [
      'todoapi'
      'todoweb'
    ]
    keyVaultName: keyVault.outputs.name
    workspaceId: workspace.outputs.id
    location: location
    tags: tags
  }
}

module network 'network.bicep' = {
  name: 'network'
  params: {
    virtualNetworkName: virtualNetworkName
    virtualNetworkResourceGroup: virtualNetworkResourceGroup
    systemAgentPoolSubnetName: systemAgentPoolSubnetName
    pepSubnetName: pepSubnetName
    vmSubnetNsgName: '${vmSubnetName}Nsg'
    createAcrPrivateEndpoint: acrSku == 'Premium'
    storageAccountPrivateEndpointName: blobStorageAccountPrivateEndpointName
    storageAccountId: storageAccount.outputs.id
    keyVaultPrivateEndpointName: keyVaultPrivateEndpointName
    keyVaultId: keyVault.outputs.id
    acrPrivateEndpointName: acrPrivateEndpointName
    acrId: containerRegistry.outputs.id
    workspaceId: workspace.outputs.id
    location: location
    tags: tags
  }
}

module virtualMachine 'virtualMachine.bicep' = {
  name: 'virtualMachine'
  params: {
    vmName: vmName
    vmSize: vmSize
    vmSubnetId: network.outputs.aksSubnetId
    storageAccountName: storageAccount.outputs.name
    imagePublisher: imagePublisher
    imageOffer: imageOffer
    imageSku: imageSku
    authenticationType: authenticationType
    vmAdminUsername: vmAdminUsername
    vmAdminPasswordOrKey: vmAdminPasswordOrKey
    diskStorageAccounType: diskStorageAccounType
    numDataDisks: numDataDisks
    osDiskSize: osDiskSize
    dataDiskSize: dataDiskSize
    dataDiskCaching: dataDiskCaching
    workspaceName: workspace.outputs.name
    location: location
    tags: tags
  }
}

module aksManageIdentity 'aksManagedIdentity.bicep' = {
  name: 'aksManageIdentity'
  params: {
    managedIdentityName: '${aksClusterName}Identity'
    virtualNetworkResourceGroup: virtualNetworkResourceGroup
    virtualNetworkName: network.outputs.virtualNetworkName
    systemAgentPoolSubnetName: systemAgentPoolSubnetName
    location: location
    tags: tags
  }
}

module kubeletManageIdentity 'kubeletManagedIdentity.bicep' = {
  name: 'kubeletManageIdentity'
  params: {
    aksClusterName: aksCluster.outputs.name
    acrName: containerRegistry.outputs.name
  }
}

module aksCluster 'aksCluster.bicep' = {
  name: 'aksCluster'
  params: {
    name: aksClusterName
    virtualNetworkName: network.outputs.virtualNetworkName
    virtualNetworkResourceGroup: virtualNetworkResourceGroup
    systemAgentPoolSubnetName: systemAgentPoolSubnetName
    managedIdentityName: aksManageIdentity.outputs.name
    dnsPrefix: aksClusterDnsPrefix
    networkPlugin: aksClusterNetworkPlugin
    networkPolicy: aksClusterNetworkPolicy
    podCidr: aksClusterPodCidr
    serviceCidr: aksClusterServiceCidr
    dnsServiceIP: aksClusterDnsServiceIP
    loadBalancerSku: aksClusterLoadBalancerSku
    outboundType: aksClusterOutboundType
    skuTier: aksClusterSkuTier
    kubernetesVersion: aksClusterKubernetesVersion
    adminUsername: aksClusterAdminUsername
    sshPublicKey: aksClusterSshPublicKey
    aadProfileTenantId: aadProfileTenantId
    aadProfileAdminGroupObjectIDs: aadProfileAdminGroupObjectIDs
    aadProfileManaged: aadProfileManaged
    aadProfileEnableAzureRBAC: aadProfileEnableAzureRBAC
    upgradeChannel: aksClusterUpgradeChannel
    enablePrivateCluster: aksClusterEnablePrivateCluster
    privateDNSZone: aksPrivateDNSZone
    enablePrivateClusterPublicFQDN: aksEnablePrivateClusterPublicFQDN
    systemAgentPoolName: systemAgentPoolName
    systemAgentPoolVmSize: systemAgentPoolVmSize
    systemAgentPoolOsDiskSizeGB: systemAgentPoolOsDiskSizeGB
    systemAgentPoolOsDiskType: systemAgentPoolOsDiskType
    systemAgentPoolAgentCount: systemAgentPoolAgentCount
    systemAgentPoolOsType: systemAgentPoolOsType
    systemAgentPoolMaxPods: systemAgentPoolMaxPods
    systemAgentPoolMaxCount: systemAgentPoolMaxCount
    systemAgentPoolMinCount: systemAgentPoolMinCount
    systemAgentPoolEnableAutoScaling: systemAgentPoolEnableAutoScaling
    systemAgentPoolScaleSetPriority: systemAgentPoolScaleSetPriority
    systemAgentPoolScaleSetEvictionPolicy: systemAgentPoolScaleSetEvictionPolicy
    systemAgentPoolNodeLabels: systemAgentPoolNodeLabels
    systemAgentPoolNodeTaints: systemAgentPoolNodeTaints
    systemAgentPoolType: systemAgentPoolType
    systemAgentPoolAvailabilityZones: systemAgentPoolAvailabilityZones
    systemAgentPoolKubeletDiskType: systemAgentPoolKubeletDiskType
    httpApplicationRoutingEnabled: httpApplicationRoutingEnabled
    openServiceMeshEnabled: openServiceMeshEnabled
    kedaEnabled: kedaEnabled
    aciConnectorLinuxEnabled: aciConnectorLinuxEnabled
    azurePolicyEnabled: azurePolicyEnabled
    kubeDashboardEnabled: kubeDashboardEnabled
    autoScalerProfileScanInterval: autoScalerProfileScanInterval
    autoScalerProfileScaleDownDelayAfterAdd: autoScalerProfileScaleDownDelayAfterAdd
    autoScalerProfileScaleDownDelayAfterDelete: autoScalerProfileScaleDownDelayAfterDelete
    autoScalerProfileScaleDownDelayAfterFailure: autoScalerProfileScaleDownDelayAfterFailure
    autoScalerProfileScaleDownUnneededTime: autoScalerProfileScaleDownUnneededTime
    autoScalerProfileScaleDownUnreadyTime: autoScalerProfileScaleDownUnreadyTime
    autoScalerProfileUtilizationThreshold: autoScalerProfileUtilizationThreshold
    autoScalerProfileMaxGracefulTerminationSec: autoScalerProfileMaxGracefulTerminationSec
    blobCSIDriverEnabled: blobCSIDriverEnabled
    diskCSIDriverEnabled: diskCSIDriverEnabled
    fileCSIDriverEnabled: fileCSIDriverEnabled
    snapshotControllerEnabled: snapshotControllerEnabled
    defenderSecurityMonitoringEnabled: defenderSecurityMonitoringEnabled
    imageCleanerEnabled: imageCleanerEnabled
    imageCleanerIntervalHours: imageCleanerIntervalHours
    workloadIdentityEnabled: workloadIdentityEnabled
    oidcIssuerProfileEnabled: oidcIssuerProfileEnabled
    podIdentityProfileEnabled: podIdentityProfileEnabled
    workspaceId: workspace.outputs.id
    location: location
    tags: clusterTags
  }
}

module aksmetricalerts 'metricAlerts.bicep' = if (createMetricAlerts) {
  name: 'aksmetricalerts'
  scope: resourceGroup()
  params: {
    aksClusterName: aksCluster.outputs.name
    metricAlertsEnabled: metricAlertsEnabled
    evalFrequency: metricAlertsEvalFrequency
    windowSize: metricAlertsWindowsSize
    alertSeverity: 'Informational'
    tags: tags
  }
}

module deploymentScript 'deploymentScript.bicep' = {
  name: 'deploymentScript'
  params: {
    clusterName: aksCluster.outputs.name
    primaryScriptUri: deploymentScriptUri
    resourceGroupName: resourceGroup().name
    subscriptionId: subscription().subscriptionId
    location: location
    tags: tags
  }
}
