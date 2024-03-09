# Token Variable Definition
variable "hcloud_token" {
  sensitive = true
}

# Obtain ssh key data
data "hcloud_ssh_key" "ssh_key" {
  fingerprint = "XXXXX"
}
