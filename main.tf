
provider "azuread" {
}

resource "azuread_conditional_access_policy" "CP01" {
  display_name = "CP01-Block-LegacyAuthentication-AllAps-Everywhere"
  state        = "enable"

  conditions {
    client_app_types    = ["exchangeActiveSync","other"]
    sign_in_risk_levels = []
    user_risk_levels    = []
        

    applications {
      included_applications = ["all"]
      excluded_applications = []
    }
    
    locations {
      included_locations = []
      excluded_locations = []
    }
    platforms {
      included_platforms = ["all"]
      excluded_platforms = []
    }

    users {
      included_users = ["all"]
      excluded_users = []
      excluded_groups = [var.emergency_admins]
    }
  }

  grant_controls {
    operator          = "OR"
    built_in_controls = ["block"]
  }

}  

resource "azuread_conditional_access_policy" "CP02" {
  display_name = "CP02-Require-MFAAuthenticationforadmin-AllAps-Everywhere"
  state        = "enabledForReportingButNotEnforced" 

  conditions {
    client_app_types    = ["all"]
    sign_in_risk_levels = []
    user_risk_levels    = []

    applications {
      included_applications = ["all"]
      excluded_applications = []
    }

    locations {
      included_locations = []
      excluded_locations = []
    }
    platforms {
      included_platforms = ["all"]
      excluded_platforms = []
    }
    users {
      included_users = []
      included_roles = [var.global_admin_role]
      excluded_users = []
      excluded_groups = [var.emergency_admins]
    }
  }

  grant_controls {
    operator          = "OR"
    built_in_controls = ["mfa"]
  }

}

resource "azuread_conditional_access_policy" "CP03" {
  display_name = "CP03-Require-MFAAUthenticationforeveryone-AllAps-Everywhere"
  state        = "enabledForReportingButNotEnforced"

  conditions {
    client_app_types    = ["all"]
    sign_in_risk_levels = []
    user_risk_levels    = []
        

    applications {
      included_applications = ["all"]
      excluded_applications = []
    }
    
    locations {
      included_locations = []
      excluded_locations = []
    }
    platforms {
      included_platforms = ["all"]
      excluded_platforms = []
    }

    users {
      included_users = ["all"]
      excluded_users = []
      excluded_groups = [var.emergency_admins]
    }
  }

  grant_controls {
    operator          = "OR"
    built_in_controls = ["mfa"]
  }

}  
