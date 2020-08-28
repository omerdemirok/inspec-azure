require 'azure_generic_resource'

class AzureAksCluster < AzureGenericResource
  name 'azure_aks_cluster'
  desc 'Verifies settings for AKS Clusters'
  example <<-EXAMPLE
    describe azure_aks_cluster(resource_group: 'example', name: 'name') do
      its(name) { should eq 'name'}
    end
  EXAMPLE

  def initialize(opts = {})
    # Options should be Hash type. Otherwise Ruby will raise an error when we try to access the keys.
    raise ArgumentError, 'Parameters must be provided in an Hash object.' unless opts.is_a?(Hash)

    opts[:resource_provider] = specific_resource_constraint('Microsoft.ContainerService/managedClusters', opts)

    super(opts, true)
  end

  def to_s
    super(AzureAksCluster)
  end
end

# Provide the same functionality under the old resource name.
# This is for backward compatibility.
class AzurermAksCluster < AzureAksCluster
  name 'azurerm_aks_cluster'
  desc 'Verifies settings for AKS Clusters'
  example <<-EXAMPLE
    describe azurerm_aks_cluster(resource_group: 'example', name: 'name') do
      its(name) { should eq 'name'}
    end
  EXAMPLE

  def initialize(opts = {})
    Inspec::Log.warn Helpers.resource_deprecation_message(@__resource_name__, AzureAksCluster.name)
    super
  end
end