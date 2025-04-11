############## Environment Variables ############### 
environment = "infrarnd"

# Root Management Group Name
root_management_group_name = "infrarnd"

############## Management Groups Variables ###############
layer1_management_group_names = {
  infrarnd-mg-infrastructure  = {}
  infrarnd-mg-landingzones    = {}
  infrarnd-mg-sandbox         = {}
  infrarnd-mg-decomissioned   = {}
}

layer2_management_group_names = {
  infrarnd-mg-corp = {
    parent_management_group = "infrarnd-mg-landingzones"
  }
  infrarnd-mg-online = {
    parent_management_group = "infrarnd-mg-landingzones"
  }
  infrarnd-mg-connectivty = {
    parent_management_group = "infrarnd-mg-infrastructure"
    subscription_ids = ["6e23ce02-4979-42eb-a162-ce3aba865da8"]

  }
  infrarnd-mg-identity = {
    parent_management_group = "infrarnd-mg-infrastructure"
    subscription_ids = ["08676b30-52fc-4afa-8121-1e90ee19d6ec"]
  }
  infrarnd-mg-management = {
    parent_management_group = "infrarnd-mg-infrastructure"
    subscription_ids = ["af3c0053-b798-4162-bd26-0046ac7996de"]
  }
}

layer3_management_group_names = {
  infrarnd-mg-enterpriseops = {
    parent_management_group = "infrarnd-mg-corp"
    subscription_ids = ["f5a9901a-e6eb-43b2-952b-6e3eba98e317"]
  }
  infrarnd-mg-surgeryplus = {
    parent_management_group = "infrarnd-mg-corp"
    subscription_ids = ["f16006b9-b33d-4611-bd82-edb011dd1639"]
  }
  infrarnd-mg-cancercare = {
    parent_management_group = "infrarnd-mg-corp"
  }
  infrarnd-mg-infusioncare = {
    parent_management_group = "infrarnd-mg-corp"
  }
    infrarnd-mg-dataops = {
    parent_management_group = "infrarnd-mg-corp"
  }
}
################## END of Management Group Variables #################