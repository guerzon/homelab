data "terraform_remote_state" "common_gcp" {
  backend = "gcs"
  config = {
    bucket = "terraform-sreafterhours-dev"
    prefix = "terraform/common-gcp"
  }
}

module "node1" {
  source                 = "guerzon/gcp/modules//computeinstance"
  version                = "1.5.0"
  server_name            = "node1"
  instance_type          = "e2-standard-2"
  vm_instance_image      = var.instance_image
  region                 = var.region
  zone                   = "${var.region}-a"
  subnetwork             = data.terraform_remote_state.common_gcp.outputs.singapore_subnet
  environment            = "devops-lab"
  compute_engine_sa_name = "devops-lab-serviceaccount"
  public_instance        = true
  vm_metadata = {
    ssh-keys = var.ssh_string
  }
  metadata_startup_script = <<-EOF
    #!/bin/bash
    dnf install -y lvm2
    mkdir /data
    echo "/dev/mapper/vgdata-lvdata /data xfs defaults 0 0" | tee -a /etc/fstab
    systemctl daemon-reload
    vgchange -ay
    mount /data
    EOF
  tags                    = var.tags
}