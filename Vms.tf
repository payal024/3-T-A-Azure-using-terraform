provider "azurerm" {
  features {}
}


resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = "West Europe"
}

resource "azurerm_virtual_network" "example" {
  name                = "example-network"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
}

resource "azurerm_subnet" "example" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefix       = "10.0.2.0/24"
}

resource "azurerm_network_interface" "example" {
  name                = "example-nic"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.example.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "example2" {
  name                = "VM-2"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  size                = "Standard_F2"
  admin_username      = "adminuser"
  network_interface_ids = [
    azurerm_network_interface.example.id,
  ]

  admin_ssh_key {
    username   = "adminuser"
    public_key = file("~/.ssh/id_rsa.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }
}

resource "azurerm_linux_virtual_machine" "example1" {
  name                = "VM-1"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  size                = "Standard_F2"
  admin_username      = "adminuser"
  network_interface_ids = [
    azurerm_network_interface.example.id,
  ]

  admin_ssh_key {
    username   = "adminuser"
    public_key = file("~/.ssh/id_rsa.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }
}

variable "pubdbdns" {
  type = string
  description = "describe your variable"
  value = module.database.dbdns
}

module "run_command" {
  source               = "innovationnorway/vm-run-command/azurerm"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_machine_name = azurerm_linux_virtual_machine.example1.name
  os_type              = "linux"

  script = <<EOF
sudo apt-get update
sudo apt-get install -y php apache2
sudo systemctl enable --now apache2
cd /var/www/html
sudo rm -rf *
sudo git clone https://github.com/Anirban2404/phpMySQLapp.git
sudo sed -i -e 's/127.0.0.1/"${var.pubdbdns}"/g' /var/www/html/books/includes/bookDatabase.php
EOF
}

module "run_command" {
  source               = "innovationnorway/vm-run-command/azurerm"
  resource_group_name  = azurerm_resource_group.example1.name
  virtual_machine_name = azurerm_linux_virtual_machine.example2.name
  os_type              = "linux"

  script = <<EOF
sudo apt-get update
sudo apt-get install -y php apache2
sudo systemctl enable --now apache2
cd /var/www/html
sudo rm -rf *
sudo git clone https://github.com/Anirban2404/phpMySQLapp.git
sudo sed -i -e 's/127.0.0.1/"${var.pubdbdns}"/g' /var/www/html/books/includes/bookDatabase.php
EOF
}

