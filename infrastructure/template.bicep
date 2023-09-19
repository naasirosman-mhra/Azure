param subscriptionId string
param name string
param location string
param hostingPlanName string
param serverFarmResourceGroup string
param alwaysOn bool
param ftpsState string
param linuxFxVersion string
param dockerRegistryUrl string
param dockerRegistryUsername string

@secure()
param dockerRegistryPassword string
param dockerRegistryStartupCommand string

resource name_resource 'Microsoft.Web/sites@2018-11-01' = {
  name: name
  location: location
  tags: null
  properties: {
    name: name
    siteConfig: {
      appSettings: [
        {
          name: 'DOCKER_REGISTRY_SERVER_URL'
          value: dockerRegistryUrl
        }
        {
          name: 'DOCKER_REGISTRY_SERVER_USERNAME'
          value: dockerRegistryUsername
        }
        {
          name: 'DOCKER_REGISTRY_SERVER_PASSWORD'
          value: dockerRegistryPassword
        }
        {
          name: 'WEBSITES_ENABLE_APP_SERVICE_STORAGE'
          value: 'false'
        }
      ]
      linuxFxVersion: linuxFxVersion
      appCommandLine: dockerRegistryStartupCommand
      alwaysOn: alwaysOn
      ftpsState: ftpsState
    }
    serverFarmId: '/subscriptions/${subscriptionId}/resourcegroups/${serverFarmResourceGroup}/providers/Microsoft.Web/serverfarms/${hostingPlanName}'
    clientAffinityEnabled: false
    virtualNetworkSubnetId: null
    httpsOnly: true
    publicNetworkAccess: 'Enabled'
  }
  dependsOn: []
}