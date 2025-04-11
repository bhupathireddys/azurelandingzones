############## Environment Variables ############### 

environment  = "prd"

# Root Management Group Name
root_management_group_name = "lantern"

############## Management Groups Variables ###############

layer1_management_group_names = {
  lantern-mg-infrastructure  = {}
  lantern-mg-landingzones    = {}
  lantern-mg-sandbox         = { subscription_ids = ["a13b3006-4110-4504-b318-96c337c098c8"] }
  lantern-mg-decomissioned   = {}
}

layer2_management_group_names = {
  lantern-mg-corp = {
    parent_management_group = "lantern-mg-landingzones"
  }
  lantern-mg-online = {
    parent_management_group = "lantern-mg-landingzones"
  }
  lantern-mg-connectivty = {
    parent_management_group = "lantern-mg-infrastructure"
    subscription_ids = ["9d6956df-dcc5-428d-a7c3-34253d5750c0"]
  }
  lantern-mg-identity = {
    parent_management_group = "lantern-mg-infrastructure"
    subscription_ids = ["381010c4-d056-45b1-a507-7120a8ed1aa6"]
  }
  lantern-mg-management = {
    parent_management_group = "lantern-mg-infrastructure"
    subscription_ids = ["938b7efe-6fcf-43e8-a559-fd319ec2ca51"]
  }
}

layer3_management_group_names = {
  lantern-mg-enterpriseops = {
    parent_management_group = "lantern-mg-corp"
    subscription_ids = ["8faaf8d9-1299-48ac-bbd2-e0cebf453d3f", "d5778a79-2f56-472b-aa1d-cc5467e404ec", "08c35f06-4547-483a-adf6-7cfa05161815", "55aad710-ffb3-424e-ac8c-4faaa661e03a"]
  }
  lantern-mg-surgeryplus = {
    parent_management_group = "lantern-mg-corp"
    subscription_ids = ["2c0ff465-01b7-420b-b912-3105e30cc2df", "68796dce-c05b-4211-8ab7-cb8004bcea9c"]
  }
  lantern-mg-cancercare = {
    parent_management_group = "lantern-mg-corp"
    subscription_ids = ["6640b63d-9a21-4cd2-a5da-cbbbaa8bd37f", "34aa272b-3e4e-4758-9631-94951d510a8a"]
  }
  lantern-mg-infusioncare = {
    parent_management_group = "lantern-mg-corp"
    subscription_ids = ["c33eeca5-e1e4-4c1e-9b90-c2230af093d3", "79495940-e89c-470b-aec9-eeac44b0cb4d"]
  }
  lantern-mg-dataops = {
    parent_management_group = "lantern-mg-corp"
    subscription_ids = ["0a8c5c39-a24b-4f82-b450-3979eb3e73c8", "efdb5761-697f-4b7d-a4f7-aa16b47f61e1"]
  }
}
################## END of Management Group Variables #################