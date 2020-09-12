# Azure Infrastructure Operations Project: Deploying a scalable IaaS web server in Azure

### Introduction
For this project, you will write a Packer template and a Terraform template to deploy a customizable, scalable web server in Azure.

### Getting Started
1. Clone this repository

2. Create your infrastructure as code

3. Update this README to reflect how someone would use your code.

### Dependencies
1. Create an [Azure Account](https://portal.azure.com) 
2. Install the [Azure command line interface](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest)
3. Install [Packer](https://www.packer.io/downloads)
4. Install [Terraform](https://www.terraform.io/downloads.html)

### Instructions

1. Build packer image. [Find client_secret, subscription_id and client_id](https://aster.cloud/2019/07/30/how-to-retrieve-subscription-id-resource-group-id-tenant-id-client-id-and-client-secret-in-azure/).

```
packer build  -var 'client_secret=XXX' -var 'subscription_id=XXX' -var 'client_id=XXX'  server.json
```

2. Generate the terraform plan. Optionally, create tfvars file to override the default values.

```
terraform plan -out solution.plan [-var-file="default.tfvars"]
```

3. Apply the generated plan - 

```
terraform apply "solution.plan"
```

### Output
```
[0m[1mazurerm_resource_group.main: Creating...[0m[0m
[0m[1mazurerm_resource_group.main: Creation complete after 1s [id=/subscriptions/ee2b61e4-1698-4cdf-a676-53901178abbf/resourceGroups/udacity-azure-devops-nanodegree-resources][0m[0m
[0m[1mazurerm_network_security_group.main: Creating...[0m[0m
[0m[1mazurerm_availability_set.main: Creating...[0m[0m
[0m[1mazurerm_public_ip.main: Creating...[0m[0m
[0m[1mazurerm_virtual_network.main: Creating...[0m[0m
[0m[1mazurerm_availability_set.main: Creation complete after 1s [id=/subscriptions/ee2b61e4-1698-4cdf-a676-53901178abbf/resourceGroups/udacity-azure-devops-nanodegree-resources/providers/Microsoft.Compute/availabilitySets/udacity-azure-devops-nanodegree-aset][0m[0m
[0m[1mazurerm_network_security_group.main: Creation complete after 1s [id=/subscriptions/ee2b61e4-1698-4cdf-a676-53901178abbf/resourceGroups/udacity-azure-devops-nanodegree-resources/providers/Microsoft.Network/networkSecurityGroups/udacity-security-group][0m[0m
[0m[1mazurerm_network_security_rule.subnet_only: Creating...[0m[0m
[0m[1mazurerm_network_security_rule.deny_all: Creating...[0m[0m
[0m[1mazurerm_network_security_rule.deny_all: Creation complete after 1s [id=/subscriptions/ee2b61e4-1698-4cdf-a676-53901178abbf/resourceGroups/udacity-azure-devops-nanodegree-resources/providers/Microsoft.Network/networkSecurityGroups/udacity-security-group/securityRules/deny-all-rule][0m[0m
[0m[1mazurerm_network_security_rule.subnet_only: Creation complete after 1s [id=/subscriptions/ee2b61e4-1698-4cdf-a676-53901178abbf/resourceGroups/udacity-azure-devops-nanodegree-resources/providers/Microsoft.Network/networkSecurityGroups/udacity-security-group/securityRules/subnet-only-rule][0m[0m
[0m[1mazurerm_public_ip.main: Creation complete after 3s [id=/subscriptions/ee2b61e4-1698-4cdf-a676-53901178abbf/resourceGroups/udacity-azure-devops-nanodegree-resources/providers/Microsoft.Network/publicIPAddresses/acceptanceTestPublicIp1][0m[0m
[0m[1mazurerm_lb.main: Creating...[0m[0m
[0m[1mazurerm_lb.main: Creation complete after 1s [id=/subscriptions/ee2b61e4-1698-4cdf-a676-53901178abbf/resourceGroups/udacity-azure-devops-nanodegree-resources/providers/Microsoft.Network/loadBalancers/UdacityLoadBalancer][0m[0m
[0m[1mazurerm_lb_backend_address_pool.main: Creating...[0m[0m
[0m[1mazurerm_lb_backend_address_pool.main: Creation complete after 0s [id=/subscriptions/ee2b61e4-1698-4cdf-a676-53901178abbf/resourceGroups/udacity-azure-devops-nanodegree-resources/providers/Microsoft.Network/loadBalancers/UdacityLoadBalancer/backendAddressPools/BackEndAddressPool][0m[0m
[0m[1mazurerm_virtual_network.main: Still creating... [10s elapsed][0m[0m
[0m[1mazurerm_virtual_network.main: Creation complete after 11s [id=/subscriptions/ee2b61e4-1698-4cdf-a676-53901178abbf/resourceGroups/udacity-azure-devops-nanodegree-resources/providers/Microsoft.Network/virtualNetworks/udacity-azure-devops-nanodegree-network][0m[0m
[0m[1mazurerm_subnet.main: Creating...[0m[0m
[0m[1mazurerm_subnet.main: Still creating... [10s elapsed][0m[0m
[0m[1mazurerm_subnet.main: Creation complete after 11s [id=/subscriptions/ee2b61e4-1698-4cdf-a676-53901178abbf/resourceGroups/udacity-azure-devops-nanodegree-resources/providers/Microsoft.Network/virtualNetworks/udacity-azure-devops-nanodegree-network/subnets/internal][0m[0m
[0m[1mazurerm_network_interface.main[0]: Creating...[0m[0m
[0m[1mazurerm_network_interface.main[1]: Creating...[0m[0m
[0m[1mazurerm_network_interface.main[0]: Creation complete after 1s [id=/subscriptions/ee2b61e4-1698-4cdf-a676-53901178abbf/resourceGroups/udacity-azure-devops-nanodegree-resources/providers/Microsoft.Network/networkInterfaces/udacity-azure-devops-nanodegree-nic-0][0m[0m
[0m[1mazurerm_network_interface.main[1]: Creation complete after 1s [id=/subscriptions/ee2b61e4-1698-4cdf-a676-53901178abbf/resourceGroups/udacity-azure-devops-nanodegree-resources/providers/Microsoft.Network/networkInterfaces/udacity-azure-devops-nanodegree-nic-1][0m[0m
[0m[1mazurerm_network_interface_backend_address_pool_association.main[0]: Creating...[0m[0m
[0m[1mazurerm_network_interface_backend_address_pool_association.main[1]: Creating...[0m[0m
[0m[1mazurerm_linux_virtual_machine.main[1]: Creating...[0m[0m
[0m[1mazurerm_linux_virtual_machine.main[0]: Creating...[0m[0m
[0m[1mazurerm_network_interface_backend_address_pool_association.main[1]: Creation complete after 0s [id=/subscriptions/ee2b61e4-1698-4cdf-a676-53901178abbf/resourceGroups/udacity-azure-devops-nanodegree-resources/providers/Microsoft.Network/networkInterfaces/udacity-azure-devops-nanodegree-nic-1/ipConfigurations/internal|/subscriptions/ee2b61e4-1698-4cdf-a676-53901178abbf/resourceGroups/udacity-azure-devops-nanodegree-resources/providers/Microsoft.Network/loadBalancers/UdacityLoadBalancer/backendAddressPools/BackEndAddressPool][0m[0m
[0m[1mazurerm_network_interface_backend_address_pool_association.main[0]: Creation complete after 1s [id=/subscriptions/ee2b61e4-1698-4cdf-a676-53901178abbf/resourceGroups/udacity-azure-devops-nanodegree-resources/providers/Microsoft.Network/networkInterfaces/udacity-azure-devops-nanodegree-nic-0/ipConfigurations/internal|/subscriptions/ee2b61e4-1698-4cdf-a676-53901178abbf/resourceGroups/udacity-azure-devops-nanodegree-resources/providers/Microsoft.Network/loadBalancers/UdacityLoadBalancer/backendAddressPools/BackEndAddressPool][0m[0m
[0m[1mazurerm_linux_virtual_machine.main[1]: Still creating... [10s elapsed][0m[0m
[0m[1mazurerm_linux_virtual_machine.main[0]: Still creating... [10s elapsed][0m[0m
[0m[1mazurerm_linux_virtual_machine.main[1]: Still creating... [20s elapsed][0m[0m
[0m[1mazurerm_linux_virtual_machine.main[0]: Still creating... [20s elapsed][0m[0m
[0m[1mazurerm_linux_virtual_machine.main[0]: Still creating... [30s elapsed][0m[0m
[0m[1mazurerm_linux_virtual_machine.main[1]: Still creating... [30s elapsed][0m[0m
[0m[1mazurerm_linux_virtual_machine.main[1]: Still creating... [40s elapsed][0m[0m
[0m[1mazurerm_linux_virtual_machine.main[0]: Still creating... [40s elapsed][0m[0m
[0m[1mazurerm_linux_virtual_machine.main[0]: Still creating... [50s elapsed][0m[0m
[0m[1mazurerm_linux_virtual_machine.main[1]: Still creating... [50s elapsed][0m[0m
[0m[1mazurerm_linux_virtual_machine.main[1]: Still creating... [1m0s elapsed][0m[0m
[0m[1mazurerm_linux_virtual_machine.main[0]: Still creating... [1m0s elapsed][0m[0m
[0m[1mazurerm_linux_virtual_machine.main[0]: Still creating... [1m10s elapsed][0m[0m
[0m[1mazurerm_linux_virtual_machine.main[1]: Still creating... [1m10s elapsed][0m[0m
[0m[1mazurerm_linux_virtual_machine.main[1]: Still creating... [1m20s elapsed][0m[0m
[0m[1mazurerm_linux_virtual_machine.main[0]: Still creating... [1m20s elapsed][0m[0m
[0m[1mazurerm_linux_virtual_machine.main[0]: Still creating... [1m30s elapsed][0m[0m
[0m[1mazurerm_linux_virtual_machine.main[1]: Still creating... [1m30s elapsed][0m[0m
[0m[1mazurerm_linux_virtual_machine.main[0]: Creation complete after 1m36s [id=/subscriptions/ee2b61e4-1698-4cdf-a676-53901178abbf/resourceGroups/udacity-azure-devops-nanodegree-resources/providers/Microsoft.Compute/virtualMachines/udacity-azure-devops-nanodegree-vm-0][0m[0m
[0m[1mazurerm_linux_virtual_machine.main[1]: Creation complete after 1m36s [id=/subscriptions/ee2b61e4-1698-4cdf-a676-53901178abbf/resourceGroups/udacity-azure-devops-nanodegree-resources/providers/Microsoft.Compute/virtualMachines/udacity-azure-devops-nanodegree-vm-1][0m[0m
[0m[1m[32m
Apply complete! Resources: 16 added, 0 changed, 0 destroyed.[0m
[0m
The state of your infrastructure has been saved to the path
below. This state is required to modify and destroy your
infrastructure, so keep it safe. To inspect the complete state
use the `terraform show` command.

State path: terraform.tfstate[0m
```

