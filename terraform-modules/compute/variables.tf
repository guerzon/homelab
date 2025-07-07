variable "environment" {
  type        = string
  description = "Environment for which the compute engine instance is being created (e.g., non-production, production)"
  validation {
    condition     = can(regex("^(non-production|production)$", var.environment))
    error_message = "Environment must be either 'non-production' or 'production'."
  }
}

variable "compute_engine_sa_name" {
  type        = string
  description = "Name of the service account to be used by the compute engine instance"
}

variable "compute_engine_sa_scopes" {
  type = list(any)
  default = [
    "https://www.googleapis.com/auth/devstorage.read_only",
    "https://www.googleapis.com/auth/logging.write",
    "https://www.googleapis.com/auth/monitoring.write",
    "https://www.googleapis.com/auth/service.management.readonly",
    "https://www.googleapis.com/auth/servicecontrol",
    "https://www.googleapis.com/auth/trace.append",
  ]
}

variable "region" {
  type    = string
  default = "asia-east1"
}

variable "server_name" {
  type        = string
  description = "Name of the compute engine instance to be created"
}

variable "vm_instance_image" {
  type        = string
  description = "Image to be used for the compute engine instance"
  default     = "ubuntu-minimal-2204-jammy-v20250521"
}

variable "vm_metadata" {
  type    = map(any)
  default = null
}

variable "vm_auto_delete" {
  type    = bool
  default = false
}

variable "network_name" {
  type        = string
  description = "Self ID of the VPC network"
}

variable "subnetwork" {
  type        = string
  description = "Name of the subnet wherein the compute engine instance will be created"
}

variable "zone" {
  type        = string
  description = "Zone suffix where the compute engine instance will be created"
}

variable "instance_type" {
  type        = string
  description = "Type of the compute engine instance"
  default     = "e2-medium"
}

variable "tags" {
  type        = list(string)
  description = "List of tags to be applied to the compute engine instance"
  default     = []
}

variable "ip" {
  type        = string
  description = "Static IP address for the main instance"
}

variable "metadata_startup_script" {
  type        = string
  description = "Startup script to be executed on the compute engine instance"
  default     = <<-EOT
    #!/bin/bash
    set +x
    echo "Running startup script for VM"
    echo "Installing Docker"
    sudo apt-get update
    sudo apt-get install -y ca-certificates curl
    sudo install -m 0755 -d /etc/apt/keyrings
    sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
    sudo chmod a+r /etc/apt/keyrings/docker.asc
    echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu jammy stable" | \
      sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt-get update
    sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
    echo "Done installing Docker"
    echo "Setting up the app user"
    sudo useradd app
    sudo mkdir /home/app && sudo chown -R app:app /home/app
    sudo usermod -s /bin/bash -d /home/app app
    sudo usermod -aG docker app
    sudo mkdir /home/app/.ssh && sudo chmod 0700 /home/app/.ssh
    echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDG6CsZObJyoRt8qt1A6TUK/TUjMrUHC6XhDdJL659jDvLN6lTa3ce+bzy5spxaSNzyXLUt3eeSqRfMCKSnHQ9tW/AnnIoFcpyox/YUKxhnK9iG+46ujXjMtaMU1NEMrIf+tldmUijwsop+5k8UArzp0lZ+fznI6EhBhkZtqerYGOJmqEy0kHyDo/uLMKhtb6pEIedARdr1FggBjAXjXVP3nb6XfmhbeIzZvdgT6nFvX+lI/w0NSyklSs+DQwGHPbYZUP7vFx+OFla9X985hdLWeqdgoMsszK6X6/4L0oho0lRTrLlv8hNfWLpo8uy10RGda4GrpkaPBv+kv74QNUDyioEWvSJugq2l8EMYLtLEfi1MQ1amtQuFZC4lUh7zGDQ6psvb+Xz/zTCOBITeid3ZwSOAkcTmlmIR5rQvKfbKhHvrnRL5fBCDpFaXK/3GBJMkaFcSvK9Yl4npRWzjEkUM8N9FiqIh0QwKQEAh8L5lToTSWwL9nYQs3hT9RlU4wfM= app key pair" \
      | sudo tee /home/app/.ssh/authorized_keys
    sudo mkdir /home/app/secrets && sudo chmod 0700 /home/app/secrets
    echo ewogICJ0eXBlIjogInNlcnZpY2VfYWNjb3VudCIsCiAgInByb2plY3RfaWQiOiAibm9uLXByb2R1Y3Rpb24tNDYwNjE0IiwKICAicHJpdmF0ZV9rZXlfaWQiOiAiN2E3NzI2MjE0ZmRjYzFjYjc5MGJlZjBhOTM4NTFiMDE4M2YzYzUzMyIsCiAgInByaXZhdGVfa2V5IjogIi0tLS0tQkVHSU4gUFJJVkFURSBLRVktLS0tLVxuTUlJRXZRSUJBREFOQmdrcWhraUc5dzBCQVFFRkFBU0NCS2N3Z2dTakFnRUFBb0lCQVFEM09GQ1JEU3RIa2VDelxuSkROa2Z0U3FlN3dENzd3K2MzRzQ5YXJlSkUxKzJEb0hEZmNSLzRNYlFBUzdtMlBwNUNVQnlld2tzeG10K3o0NFxuLy9STlhmWDdlTmhzd3liZVBKSzd6Sk1iTUQ3VWovTmFqK2pZQ0hnSXZBNGFxRllCMGZQMmJtZkVreU5ZRTNPOVxuMFVxTU1kREZrK2ttZjY5S3VmcjBzdk5ITlZmL1RtVWtjY0NWNmJKMnlxN3BrZ2E1TDhXNDB5RGg1VEx1ZklGRFxuSm95dFBaQktyWVVSNUFPc090b0laVnp4YklvU2Q0M2ZuaWdjbHpQZzdpaE1tbkJQS1NNdnkraGJyQWc5SHRQTFxuN1pIem0wL2J0Y21mR2xkR2JPa1dUanhXNHZmdEdZOWlvWmNXOXorZW9QTTdvdXpvUlVkaXJBcVNnY2VGR3Q1UlxudUxsRFNPODNBZ01CQUFFQ2dnRUFFY1hYS081bzc1N0JxQzlRa0lkN3MzdnN3dDJ2eTArU1cra3hiUUh3SGsvZVxuTUJhbGJnSlFBeHdCbXhrclFDdmFLenhBZ1V6czZqQ1hReExIbGU1TTJsVFFQbFZ6VEdQUGFyZmsxWDRNN2t3aFxuQXlBNGJadUNRYUovWXhRNkJxeDQzUDBIOGI1Z09wcy9aV1NQOXU4MzRwUmxIUkx0MzdIcUpFQmZNLzNXUXpEVFxuOEd3aWhNcmcwZHczMmRKcEd1ZHBqRjZYZXdwK0FGdHBkUzlCbFBKQ011V1N6a1AzTStjNWl6ejBRc2hWOUhxWVxuZzBXRThLTFJJYWZMSkxyRlUzcVV4dnBwNWx1REJTVnNYYWh2WDljMW9pS2dRaHhKWXJCWW4yWWtHaUR4UUJOWlxucTVoU1R3YXdhQ0xOcTdKbG52aXZaYkFsTmRQTkd2WEJYTUUwRG5Dd0NRS0JnUUQvcVNXZ1IvK291RnFTbXB1L1xudUFMU0dOZ1hEVzBVZy9Zc2J2RXA2ekxlWnA4V2IyYTZ4bG5KLzltTDdWS0YzY0Q1aVk3ZFVPanE2dHRPajJXUlxuWnhlSkNZUkJoMVdLY0dQdmlhaW5aUWZTY1hWU0lRTVAwUHg3NEttM0dReW45Ly9ZUlN2ekpveUhmWWlrY3BJeFxudmkxOVlxMU5GRVYyWkJSMy90ZENvOUN5dndLQmdRRDNqRXpjNTlMM2VXNGtucHBtam1SRWRkWUxXQmo1eG5icFxuQmRVQ0I4b2pDUXMzSTkrditwV3o0Z3pBK1d0bHhsUWY1emJkSTQzT0kxMjFSMm1naXhzN2szUzZzNDBvd2JQOVxuakNZTlYvYjZuSlJJMVQzM1NlQ0F5TGFyR1RaOStuSnVZL1cycW5YamhvQUVVYS80V2xwaVIvV3IrTFRWL2N2V1xuQ1VlN2ZDTjVpUUtCZ1FETXc2TDVMdkZiSnR5VUV2U3ZweWZMTWs3UWw5WkgyakZ2QVNSeTJJZ1RqTW5hWkRzNVxuV09oTlczZllGS3BGd1lodjFIYnlWMzFWdWVrUWtOVmVrZDFOeXF0OCtISFF3WmVwSU81TnRDT0JyNUd4eC9MMVxuMWdLRERUdWhCSlVZYXc4bEhySEd1NWRPWllMdGd6NElUVE9OKzF5bUlaaEk3SHRnYUdIc1k5d2hiUUtCZ0h2alxucElnZUlYQW5QcDluSFFEY25JUENzWWZsNUVJRk9IZXdxb1VrbnQ1ZjVWUUlTU2ZLY21lZlp5Q2c4MFh4TnlMc1xuVllIaERGUXhVUEdydHNwWk5CemgxRmFvQzZwdEh3Wnl3SXlIREowcUJmQlpnSFNsYlkwbVpuMUUxZ2ZBY3NxYVxuamx1SC9nNEx2ei9xSGZaZVNjUE1IY0NlYk9wMzVTN09ZQzhObHJkNUFvR0FkKzVXN1Z4VkZoYUtKMlBsQmJzdVxuL1VHRExoemQ5UG1pa3UwTTRKcHA1QS9lRUltZmFSVVhwMUIrSDloUEdCS2pxMndKN1BKRFdVN2tSbHc2WC9LK1xuV3Bid3M0RXdWQ1hjNE9tQ0dYZzBnOUhVbTRWSXVoa01MREMzS3FtMmZURkY5WmFQY2VheFpKU3RzZ3BxdmFPSlxucnhnRERESFF6UWFKNUxMNlZoY1NxaUE9XG4tLS0tLUVORCBQUklWQVRFIEtFWS0tLS0tXG4iLAogICJjbGllbnRfZW1haWwiOiAiZ2l0aHViLWRvY2tlci1zZXJ2aWNlYWNjb3VudEBub24tcHJvZHVjdGlvbi00NjA2MTQuaWFtLmdzZXJ2aWNlYWNjb3VudC5jb20iLAogICJjbGllbnRfaWQiOiAiMTE3NTc2OTE3MjIxNTcxODYyMzc5IiwKICAiYXV0aF91cmkiOiAiaHR0cHM6Ly9hY2NvdW50cy5nb29nbGUuY29tL28vb2F1dGgyL2F1dGgiLAogICJ0b2tlbl91cmkiOiAiaHR0cHM6Ly9vYXV0aDIuZ29vZ2xlYXBpcy5jb20vdG9rZW4iLAogICJhdXRoX3Byb3ZpZGVyX3g1MDlfY2VydF91cmwiOiAiaHR0cHM6Ly93d3cuZ29vZ2xlYXBpcy5jb20vb2F1dGgyL3YxL2NlcnRzIiwKICAiY2xpZW50X3g1MDlfY2VydF91cmwiOiAiaHR0cHM6Ly93d3cuZ29vZ2xlYXBpcy5jb20vcm9ib3QvdjEvbWV0YWRhdGEveDUwOS9naXRodWItZG9ja2VyLXNlcnZpY2VhY2NvdW50JTQwbm9uLXByb2R1Y3Rpb24tNDYwNjE0LmlhbS5nc2VydmljZWFjY291bnQuY29tIiwKICAidW5pdmVyc2VfZG9tYWluIjogImdvb2dsZWFwaXMuY29tIgp9Cg== \
      | base64 -d | sudo tee /home/app/secrets/service-key.json
    sudo chown -R app:app /home/app
    echo "Service account key added to /home/app/secrets/service-key.json"
    echo "Startup script completed"
  EOT
}

variable "backend_port_name" {
  type        = string
  description = "Port name of the backend API application"
}

variable "backend_port" {
  type        = number
  description = "Port number of the backend API application"
}

variable "frontend_port_name" {
  type        = string
  description = "Port name of the NodeJS frontend application"
}

variable "frontend_port" {
  type        = number
  description = "Port number of the NodeJS frontend application"
}
