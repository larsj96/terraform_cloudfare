# data "terraform_remote_state" "Homelabb-Fortigate" {
#   backend = "http"

#   config = { # this is the state for FORTIGATE project
#     address = "http://10.0.0.130/api/v4/projects/2/terraform/state/main" # TF_HTTP_ADDRESS env variable
#     username = "terraform"
#   #  password = "XXXXXXXX"
#   }
# }

data "tfe_outputs" "Homelabb-Fortigate" {

  organization = "lanilsen"
  workspace = "fortigate"
}


locals {
  fortigate = data.tfe_outputs.Homelabb-Fortigate.nonsensitive_values.wan_ip
}

