provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "main" {
  name     = "${var.prefix}-resources"
  location = var.location
  
  tags = {
    "project": "udacity-azure-devops-nanodegree-project-1"
  }	
  
}

resource "azurerm_virtual_network" "main" {
  name                = "${var.prefix}-network"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  tags = {
    "project": "udacity-azure-devops-nanodegree-project-1"
  }	

}

resource "azurerm_network_security_group" "main" {
  name                = "udacity-security-group"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  tags = {
    "project": "udacity-azure-devops-nanodegree-project-1"
  }	

}

resource "azurerm_network_security_rule" "subnet_only" {
  name                        = "subnet-only-rule"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "VirtualNetwork"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.main.name
  network_security_group_name = azurerm_network_security_group.main.name

}

resource "azurerm_network_security_rule" "deny_all" {
  name                        = "deny-all-rule"
  priority                    = 200
  direction                   = "Inbound"
  access                      = "Deny"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.main.name
  network_security_group_name = azurerm_network_security_group.main.name

}


resource "azurerm_subnet" "main" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = ["10.0.0.0/24"]
}

resource "azurerm_public_ip" "main" {
  name                = "acceptanceTestPublicIp1"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  allocation_method   = "Static"

  tags = {
    "project": "udacity-azure-devops-nanodegree-project-1"
  }	
}

resource "azurerm_lb" "main" {
  name                = "UdacityLoadBalancer"
  location            = "Southeast Asia"
  resource_group_name = azurerm_resource_group.main.name

  frontend_ip_configuration {
    name                 = "PublicIPAddress"
    public_ip_address_id = azurerm_public_ip.main.id
  }
  tags = {
    "project": "udacity-azure-devops-nanodegree-project-1"
  }	
}

resource "azurerm_lb_backend_address_pool" "main" {
  resource_group_name = azurerm_resource_group.main.name
  loadbalancer_id     = azurerm_lb.main.id
  name                = "BackEndAddressPool"

 
}

resource "azurerm_network_interface" "main" {

  count = var.vm_count

  name                = "${var.prefix}-nic-${count.index}"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.main.id
    private_ip_address_allocation = "Dynamic"
    
  }

  tags = {
    "project": "udacity-azure-devops-nanodegree-project-1"
  }	
}

resource "azurerm_network_interface_backend_address_pool_association" "main" {

    count = var.vm_count

    network_interface_id    = azurerm_network_interface.main[count.index].id
    ip_configuration_name   = "internal"
    backend_address_pool_id =azurerm_lb_backend_address_pool.main.id
}

resource "azurerm_availability_set" "main" {
  name                = "${var.prefix}-aset"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  tags = {
    "project": "udacity-azure-devops-nanodegree-project-1"
  }
}

resource "azurerm_linux_virtual_machine" "main" {
  
  count = var.vm_count

  name                            = "${var.prefix}-vm-${count.index}"
  resource_group_name             = azurerm_resource_group.main.name
  availability_set_id             = azurerm_availability_set.main.id
  location                        = azurerm_resource_group.main.location
  size                            = "Standard_D2s_V3"
  
  admin_username                  = "${var.admin_username}"
  admin_password                  = "${var.admin_password}"
  disable_password_authentication = false
  network_interface_ids = [
    azurerm_network_interface.main[count.index].id
  ]
  source_image_id = "/subscriptions/ee2b61e4-1698-4cdf-a676-53901178abbf/resourceGroups/udacity-resources/providers/Microsoft.Compute/images/project1"

  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }

  tags = {
    "project": "udacity-azure-devops-nanodegree-project-1"
  }	
}
