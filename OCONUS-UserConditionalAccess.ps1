$policyName = "Block Non-USA Sign-ins"
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

# Define the policy settings
$policySettings = @{
    DisplayName = $policyName
    State = "Enabled"
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