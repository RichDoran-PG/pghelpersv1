# Set Module MS Graph
Install-Module Microsoft.Graph -Scope CurrentUser -Force
Connect-MgGraph
Get-MgConditionalAccessPolicy

$policyName = "Block OCONUS Sign-ins"
$tenantId = (Get-AzTenant).Id

# Define the location condition (USA only)
$locationCondition = @{
    IncludeLocations = @("US")
    ExcludeLocations = @()
}

# Retrieve Global Administrator Role ID
$globalAdminRoleId = "62e90394-69f5-4237-9190-012177145e10"  # Default Azure Global Admin Role ID

# Get all users assigned to Global Admin role
$globalAdminUsers = Get-MgRoleManagementDirectoryRoleAssignment | Where-Object { $_.RoleDefinitionId -eq $globalAdminRoleId } | Select-Object -ExpandProperty PrincipalId

# Define the user exclusion condition (Exclude Global Admins)
$userCondition = @{
    IncludeUsers = @("All")
    ExcludeUsers = $globalAdminUsers  # Excludes Global Administrators
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
