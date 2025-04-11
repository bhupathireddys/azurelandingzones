


environment  = "prd"

regions_short = {
  centralus = "cus"
  westus3   = "wus3"
}

firewall_sku = "Basic"
enable_firewall = true  # Fallback NAT Gateway Route (only if firewall is not enabled)

 
subscription_settings = {

####################### Prod Subscriptions #########################
### All Prod CIDR Starts as Below
#### Central US Region : 10.200.0.0/21
#### West US3 Region: 10.210.0.0/21

### Connectivity Subscription - Hub vNet in Central US Region
  hubcus = {
    subscription_name = "hubcus"
    env               = "prd"
    subscription_id   = "##{hubsub_ID}##"
    root_id           = "lc"
    cidr              = "10.200.0.0/21"
    region            = "centralus"
    workload          = "hub"
  }
### Connectivity Subscription - Hub vNet in West US3 RegionRegion
  hubwus3 = {
    subscription_name = "hubwus3"
    env               = "prd"
    subscription_id   = "##{hubsub_ID}##"
    root_id           = "lc"
    cidr              = "10.210.0.0/21"
    region            = "westus3"
    workload          = "hub"
  }

# Identity Subscritpion Prod vNet in Central US Region 
  iamprdcus = {
    subscription_name = "iamprdcus"
    env               = "prd"
    subscription_id   = "##{iamsub_ID}##"
    root_id           = "lc"
    cidr              = "10.200.8.0/21"
    region            = "centralus"
    workload          = "iam"
  }
#  Identity Subscritpion Prod vNet in West US3 Region    
  iamprdwus3 = {
    subscription_name = "iamprdwus3"
    env               = "prd"
    subscription_id   = "##{iamsub_ID}##"
    root_id           = "lc"
    cidr              = "10.210.8.0/21"
    region            = "westus3"
    workload          = "iam"
  }

# Identity Subscritpion Dev vNet in Central US Region 
  iamdevcus = {
    subscription_name = "iamdevcus"
    env               = "dev"
    subscription_id   = "##{iamsub_ID}##"
    root_id           = "lc"
    cidr              = "10.201.8.0/21"
    region            = "centralus"
    workload          = "iam"
  }
#  Identity Subscritpion Dev vNet in West US3 Region    
  iamdevwus3 = {
    subscription_name = "iamdevwus3"
    env               = "dev"
    subscription_id   = "##{iamsub_ID}##"
    root_id           = "lc"
    cidr              = "10.211.8.0/21"
    region            = "westus3"
    workload          = "iam"
  }
}