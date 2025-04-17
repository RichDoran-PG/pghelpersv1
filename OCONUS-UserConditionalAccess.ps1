$policyName = "Block OCONUS Sign-ins"
$tenantId = (Get-AzTenant).Id

# Define the location condition (USA only)
$locationCondition = @{
    IncludeLocations = @("US")
    ExcludeLocations = @()
}

# Define the user exclusion condition
$userCondition = @{
    IncludeUsers = @("All")
    ExcludeUsers = @("Pgadmin")  # Excludes "Pgadmin" user
}

# Define the policy settings (Set to Report-Only)
$policySettings = @{
    DisplayName = $policyName
    State = "ReportOnly"  # Change from 'Enabled' to 'ReportOnly'
    Conditions = @{
        Locations = $locationCondition
        Users = $userCondition
    }
    GrantControls = @{
        BuiltInControls = @("Block")
    }
}

# Create the policy
New-AzConditionalAccessPolicy -TenantId $tenantId -Settings $policySettings
