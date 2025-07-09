# File: terraform/modules/azurepolicies/locals.tf
# This file contains local variables used in the Azure Policies module.
locals {
  split_region_env = {
    for combo in setproduct(var.subscription_policies, var.region_env_keys) :
    "${combo[0]}-${combo[1]}" => {
      subscription_id = combo[0]
      region          = split("-", combo[1])[0]
      env             = split("-", combo[1])[1]
      env_scope       = contains(["prd"], split("-", combo[1])[1]) ? "prd" : "nonprd"
      region_short    = lookup(var.regions_short, split("-", combo[1])[0], "unk")
      law_key         = "${split("-", combo[1])[0]}-${contains(["prd"], split("-", combo[1])[1]) ? "prd" : "nonprd"}"
    }
  }

  # Resource-specific diagnostics configuration
  resource_diagnostics = {
    "Microsoft.Compute/virtualMachines" = {
      logs = [
        { category = "BootDiagnostics", enabled = true },
        { category = "SystemEvent", enabled = true },
        { category = "SecurityProfile", enabled = true },
        { category = "GuestOSMetrics", enabled = true },
        { category = "AuditEvent", enabled = true }
      ],
      metrics = [
        { category = "Percentage CPU", enabled = true },
        { category = "Available Memory Bytes", enabled = true },
        { category = "Disk Read Bytes", enabled = true },
        { category = "Disk Write Bytes", enabled = true },
        { category = "Network In Total", enabled = true },
        { category = "Network Out Total", enabled = true }
      ]
    },
    "Microsoft.Compute/virtualMachineScaleSets" = {
      logs = [
        { category = "BootDiagnostics", enabled = true },
        { category = "SystemEvent", enabled = true },
        { category = "SecurityProfile", enabled = true }
      ],
      metrics = [
        { category = "Percentage CPU", enabled = true },
        { category = "Available Memory Bytes", enabled = true },
        { category = "Disk Read Bytes", enabled = true },
        { category = "Disk Write Bytes", enabled = true }
      ]
    },
    "Microsoft.ContainerService/managedClusters" = {
      logs = [
        { category = "kube-audit", enabled = true },
        { category = "kube-apiserver", enabled = true },
        { category = "kube-controller-manager", enabled = true },
        { category = "kube-scheduler", enabled = true }
      ],
      metrics = [
        { category = "node_cpu_usage_percentage", enabled = true },
        { category = "node_memory_working_set_bytes", enabled = true },
        { category = "node_disk_usage_bytes", enabled = true }
      ]
    },
  #Web Apps
    "Microsoft.Web/sites" = {
      logs = [
        { category = "AppServiceAuditLogs", enabled = true },
        { category = "AppServiceHTTPLogs", enabled = true },
        { category = "AppServiceConsoleLogs", enabled = true }
      ],
      metrics = [
        { category = "Requests", enabled = true },
        { category = "ResponseTime", enabled = true },
        { category = "Http5xx", enabled = true }
      ]
    },
#Functions
    "Microsoft.Web/sites/functions" = {
      logs = [
        { category = "FunctionAppLogs", enabled = true },
        { category = "FunctionExecutionLogs", enabled = true }
      ],
      metrics = [
        { category = "FunctionExecutionCount", enabled = true },
        { category = "FunctionExecutionUnits", enabled = true }
      ]
    },
   
#Storage Accounts
    "Microsoft.Storage/storageAccounts" = {
      logs = [
        { category = "StorageRead", enabled = true },
        { category = "StorageWrite", enabled = true },
        { category = "StorageDelete", enabled = true }
      ],
      metrics = [
        { category = "Availability", enabled = true },
        { category = "Ingress", enabled = true },
        { category = "Egress", enabled = true }
      ]
    },
#Virtual Networks
    "Microsoft.Network/virtualNetworks" = {
      logs = [
        { category = "VMProtectionAlerts", enabled = true }
      ],
      metrics = [
        { category = "PingMeshAverageRoundtripMs", enabled = true },
        { category = "PingMeshProbesFailedPercent", enabled = true }
      ]
    }
#NSGs
    "Microsoft.Network/networkSecurityGroups" = {
      logs = [
        { category = "NetworkSecurityGroupEvent", enabled = true },
        { category = "NetworkSecurityGroupRuleCounter", enabled = true }
      ],
      metrics = [
        { category = "PacketsInDDoS", enabled = true },
        { category = "PacketsDroppedDDoS", enabled = true }
      ]
    },
    
#Application Gateways
    "Microsoft.Network/applicationGateways" = {
      logs = [
        { category = "ApplicationGatewayAccessLog", enabled = true },
        { category = "ApplicationGatewayPerformanceLog", enabled = true },
        { category = "ApplicationGatewayFirewallLog", enabled = true }
      ],
      metrics = [
        { category = "TotalRequests", enabled = true },
        { category = "FailedRequests", enabled = true },
        { category = "Throughput", enabled = true }
      ]
    },
    
#Load Balancers
    "Microsoft.Network/loadBalancers" = {
      logs = [
        { category = "LoadBalancerAlertEvent", enabled = true },
        { category = "LoadBalancerProbeHealthStatus", enabled = true }
      ],
      metrics = [
        { category = "DataPathAvailability", enabled = true },
        { category = "HealthProbeStatus", enabled = true }
      ]
    },
    
#Azure Firewalls
    "Microsoft.Network/azureFirewalls" = {
      logs = [
        { category = "AzureFirewallApplicationRule", enabled = true },
        { category = "AzureFirewallNetworkRule", enabled = true }
      ],
      metrics = [
        { category = "ApplicationRulesHitCount", enabled = true },
        { category = "NetworkRulesHitCount", enabled = true }
      ]
    },
    
#VPN Gateways
    "Microsoft.Network/vpnGateways" = {
      logs = [
        { category = "GatewayDiagnosticLog", enabled = true },
        { category = "TunnelDiagnosticLog", enabled = true }
      ],
      metrics = [
        { category = "TunnelIngressBytes", enabled = true },
        { category = "TunnelEgressBytes", enabled = true }
      ]
    },
    
#Key Vaults
    "Microsoft.KeyVault/vaults" = {
      logs = [
        { category = "AuditEvent", enabled = true }
      ],
      metrics = [
        { category = "ServiceApiHit", enabled = true },
        { category = "ServiceApiLatency", enabled = true }
      ]
    },
    
# SQL Databases
    "Microsoft.Sql/servers/databases" = {
      logs = [
        { category = "SQLSecurityAuditEvents", enabled = true },
        { category = "QueryStoreRuntimeStatistics", enabled = true },
        { category = "Errors", enabled = true }
      ],
      metrics = [
        { category = "cpu_percent", enabled = true },
        { category = "physical_data_read_percent", enabled = true },
        { category = "log_write_percent", enabled = true }
      ]
    },
    
#  Log Analytics Workspaces
    "Microsoft.OperationalInsights/workspaces" = {
      logs = [
        { category = "Audit", enabled = true }
      ],
      metrics = [
        { category = "DataVolume", enabled = true },
        { category = "DataCollectorLatency", enabled = true }
      ]
    },
    
#  Application Insights
    "Microsoft.Insights/components" = {
      logs = [
        { category = "Audit", enabled = true }
      ],
      metrics = [
        { category = "requests/count", enabled = true },
        { category = "requests/duration", enabled = true }
      ]
    },
    
#  Databricks
    "Microsoft.Databricks/workspaces" = {
      logs = [
        { category = "dbfs", enabled = true },
        { category = "clusters", enabled = true },
        { category = "accounts", enabled = true }
      ],
      metrics = [
        { category = "job_runs_total", enabled = true },
        { category = "cluster_nodes", enabled = true }
      ]
    },
    
#  Machine Learning
    "Microsoft.MachineLearningServices/workspaces" = {
      logs = [
        { category = "AmlComputeClusterEvent", enabled = true },
        { category = "AmlComputeClusterNodeEvent", enabled = true }
      ],
      metrics = [
        { category = "Total Nodes", enabled = true },
        { category = "Active Nodes", enabled = true }
      ]
    },
    
#  Recovery Services Vaults
    "Microsoft.RecoveryServices/vaults" = {
      logs = [
        { category = "AzureBackupReport", enabled = true },
        { category = "CoreAzureBackup", enabled = true }
      ],
      metrics = [
        { category = "BackupHealthEvent", enabled = true },
        { category = "RestoreHealthEvent", enabled = true }
      ]
    },
    
# Event Hubs
    "Microsoft.EventHub/namespaces" = {
      logs = [
        { category = "OperationalLogs", enabled = true },
        { category = "AutoScaleLogs", enabled = true }
      ],
      metrics = [
        { category = "IncomingMessages", enabled = true },
        { category = "OutgoingMessages", enabled = true }
      ]
    },
    
#  Service Bus
    "Microsoft.ServiceBus/namespaces" = {
      logs = [
        { category = "OperationalLogs", enabled = true }
      ],
      metrics = [
        { category = "IncomingMessages", enabled = true },
        { category = "OutgoingMessages", enabled = true }
      ]
    },
    
#  Cosmos DB
    "Microsoft.DocumentDB/databaseAccounts" = {
      logs = [
        { category = "DataPlaneRequests", enabled = true },
        { category = "QueryRuntimeStatistics", enabled = true }
      ],
      metrics = [
        { category = "TotalRequests", enabled = true },
        { category = "TotalRequestUnits", enabled = true }
      ]
    },
    
#   API Management
    "Microsoft.ApiManagement/service" = {
      logs = [
        { category = "GatewayLogs", enabled = true }
      ],
      metrics = [
        { category = "Requests", enabled = true },
        { category = "Duration", enabled = true }
      ]
    },
    
#   Redis Cache
    "Microsoft.Cache/Redis" = {
      logs = [
        { category = "RedisAuditLog", enabled = true }
      ],
      metrics = [
        { category = "connectedclients", enabled = true },
        { category = "percentProcessorTime", enabled = true }
      ]
    }
  }
}