locals {
  subnets = [
      {
          name = "snet01"
          address_prefix = "192.168.1.0/24"
      },
      {
          name = "snet02"
          address_prefix = "192.168.2.0/24"
      }
  ]
}

resource "azurerm_virtual_network" "vnet" {
  name = "vnet"
  resource_group_name = azurerm_resource_group.myrg.name
  location = azurerm_resource_group.myrg.location
  address_space = ["192.168.0.0/16"]

  dynamic "subnet" {
      for_each = local.subnets
      content {
          name = subnet.value.name 
          address_prefix = subnet.value.address_prefix
      }
  }
}