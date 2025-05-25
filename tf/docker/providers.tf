terraform {
  required_providers {
    proxmox = {
      source  = "Telmate/proxmox"
      version = "2.9.14"
    }
  }
}

provider "proxmox" {
  pm_log_enable = true
  pm_log_file   = "terraform-plugin-proxmox.log"
  pm_debug      = true
  pm_log_levels = {
    _default    = "debug"
    _capturelog = ""
  }

  pm_tls_insecure = true # local only.
  # Warning!! Do not check these in! Use environment variables with all caps!
  #pm_api_url = ""
  #pm_api_token_id = ""
  #pm_api_token_secret = ""
}
