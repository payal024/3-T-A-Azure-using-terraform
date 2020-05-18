variable "resource_group_name" {
  description = "The name of the resource group."
}

variable "virtual_machine_name" {
  description = "The name of the virtual machine."
}

variable "os_type" {
  description = "Specifies the operating system type."
}

variable "command" {
  default     = ""
  description = "Command to be executed."
}

variable "script" {
  default     = ""
  description = "Script to be executed."
}

variable "file_uris" {
  type        = "list"
  default     = []
  description = "List of files to be downloaded."
}

variable "timestamp" {
  default     = ""
  description = "An integer, intended to trigger re-execution of the script when changed."
}

variable "tags" {
  default     = {}
  description = "A mapping of tags to assign to the extension."
}


variable "prefix" {
  description = "(Required) Default prefix to use with your resource names."
  default     = "azure_lb"
}

variable "remote_port" {
  description = "Protocols to be used for remote vm access. [protocol, backend_port].  Frontend port will be automatically generated starting at 50000 and in the output."
  default     = {}
}

variable "lb_port" {
  description = "Protocols to be used for lb health probes and rules. [frontend_port, protocol, backend_port]"
  default     = {}
}

variable "lb_probe_unhealthy_threshold" {
  description = "Number of times the load balancer health probe has an unsuccessful attempt before considering the endpoint unhealthy."
  default     = 2
}

variable "lb_probe_interval" {
  description = "Interval in seconds the load balancer health probe rule does a check"
  default     = 5
}

variable "frontend_name" {
  description = "(Required) Specifies the name of the frontend ip configuration."
  default     = "myPublicIP"
}

variable "public_ip_address_allocation" {
  description = "(Required) Defines how an IP address is assigned. Options are Static or Dynamic."
  default     = "static"
}

variable "tags" {
  type = "map"

  default = {
    source = "terraform"
  }
}

variable "type" {
  type        = "string"
  description = "(Optional) Defined if the loadbalancer is private or public"
  default     = "public"
}

variable "frontend_subnet_id" {
  description = "(Optional) Frontend subnet id to use when in private mode"
  default     = ""
}

variable "frontend_private_ip_address" {
  description = "(Optional) Private ip address to assign to frontend. Use it with type = private"
  default     = ""
}

variable "frontend_private_ip_address_allocation" {
  description = "(Optional) Frontend ip allocation type (Static or Dynamic)"
  default     = "Dynamic"
}