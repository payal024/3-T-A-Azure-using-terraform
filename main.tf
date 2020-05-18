provider "azurerm" {
    version = "~>2.10"
    subscription_id = "604ea29f-c546-47be-90e2-31f63d121f6b"
    client_id       = "1aa7e3e5-c392-4f47-a3fc-e5540de5960c"
    client_secret    = "abcf4ae8-f4d6-4f77-9468-9f1754f45e0b"
    tenant_id       = "fa0a885b-d425-45fd-92eb-721f1da718e9"
    features{}
    
}

resource  "azurerm_resource_group" "resource_gp" {
    name ="Three-Tier-Architecture-app"
    location ="Central India"

    
}