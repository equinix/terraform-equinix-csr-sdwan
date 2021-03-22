variable "metro_code" {
  description = "Device location metro code"
  type        = string
  validation {
    condition     = can(regex("^[A-Z]{2}$", var.metro_code))
    error_message = "Valid metro code consits of two capital leters, i.e. SV, DC."
  }
}

variable "account_number" {
  description = "Billing account number for a device"
  type        = string
  default     = 0
}

variable "platform" {
  description = "Device platform flavor that determines number of CPU cores and memory"
  type        = string
  validation {
    condition     = can(regex("^(small|medium|large)$", var.platform))
    error_message = "One of following platform flavors are supported: small, medium, large."
  }
}

variable "software_package" {
  description = "Device software package"
  type        = string
  validation {
    condition     = can(regex("^(ADVANTAGE|ESSENTIALS|PREMIER)$", var.software_package))
    error_message = "One of following software packages are supported: ADVANTAGE, ESSENTIALS, PREMIER."
  }
}

variable "license_file" {
  description = "Path to the device license configuration file"
  type        = string
  validation {
    condition     = length(var.license_file) > 0
    error_message = "Device license configuration path has be an non empty string."
  }
}

variable "throughput" {
  description = "Device license throughput"
  type        = number
  validation {
    condition     = var.throughput > 0
    error_message = "Device license throughput has to be positive number."
  }
}

variable "throughput_unit" {
  description = "License throughput unit (Mbps or Gbps)"
  type        = string
  validation {
    condition     = can(regex("^(Mbps|Gbps)$", var.throughput_unit))
    error_message = "One of following throughput units are available: Mbps or Gbps."
  }
}

variable "name" {
  description = "Device name"
  type        = string
  validation {
    condition     = length(var.name) >= 2 && length(var.name) <= 50
    error_message = "Device name should consist of 2 to 50 characters."
  }
}

variable "term_length" {
  description = "Term length in months"
  type        = number
  validation {
    condition     = can(regex("^(1|12|24|36)$", var.term_length))
    error_message = "One of following term lengths are available: 1, 12, 24, 36 months."
  }
}

variable "notifications" {
  description = "List of email addresses that will receive device status notifications"
  type        = list(string)
  validation {
    condition     = length(var.notifications) > 0
    error_message = "Notification list cannot be empty."
  }
}

variable "acl_template_id" {
  description = "Identifier of an ACL template that will be applied on a device"
  type        = string
  validation {
    condition     = length(var.acl_template_id) > 0
    error_message = "ACL template identifier has to be an non empty string."
  }
}

variable "additional_bandwidth" {
  description = "Additional internet bandwidth for a device"
  type        = number
  default     = 0
  validation {
    condition     = var.additional_bandwidth == 0 || (var.additional_bandwidth >= 25 && var.additional_bandwidth <= 2001)
    error_message = "Additional internet bandwidth should be between 25 and 2001 Mbps."
  }
}

variable "site_id" {
  description = "Site identifier"
  type        = string
  validation {
    condition     = length(var.site_id) > 0
    error_message = "Site identifier has to be an non empty string."
  }
}

variable "system_ip_address" {
  description = "System IP address"
  type        = string
  validation {
    condition     = length(var.system_ip_address) > 0
    error_message = "System IP address has to be an non empty string."
  }
}

variable "interface_count" {
  description = "Number of network interfaces on a device"
  type        = number
  default     = 0
  validation {
    condition     = var.interface_count == 0 || var.interface_count == 10 || var.interface_count == 24
    error_message = "Device interface count has to be either 10 or 24."
  }
}

variable "secondary" {
  description = "Secondary device attributes"
  type        = map(any)
  default     = { enabled = false }
  validation {
    condition     = can(var.secondary.enabled)
    error_message = "Key 'enabled' has to be defined for secondary device."
  }
  validation {
    condition     = !try(var.secondary.enabled, false) || try(length(var.secondary.license_file) > 0, false)
    error_message = "Key 'license_file' has to be defined for secondary device. Valid license file path has to be an non empty string."
  }
  validation {
    condition     = !try(var.secondary.enabled, false) || can(regex("^[A-Z]{2}$", var.secondary.metro_code))
    error_message = "Key 'metro_code' has to be defined for secondary device. Valid metro code consits of two capital leters, i.e. SV, DC."
  }
  validation {
    condition     = !try(var.secondary.enabled, false) || try(length(var.secondary.acl_template_id) > 0, false)
    error_message = "Key 'acl_template_id' has to be defined for secondary device. Valid ACL template identifier has to be an non empty string."
  }
  validation {
    condition     = !try(var.secondary.enabled, false) || try(var.secondary.additional_bandwidth >= 25 && var.secondary.additional_bandwidth <= 2001, true)
    error_message = "Key 'additional_bandwidth' has to be between 25 and 2001 Mbps."
  }
  validation {
    condition     = !try(var.secondary.enabled, false) || try(length(var.secondary.site_id) > 0, false)
    error_message = "Key 'site_id' has to be defined for secondary device. Valid site identifier has to be an non empty string."
  }
  validation {
    condition     = !try(var.secondary.enabled, false) || try(length(var.secondary.system_ip_address) > 0, false)
    error_message = "Key 'system_ip_address' has to be defined for secondary device. Valid system IP address has to be an non empty string."
  }
}
