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