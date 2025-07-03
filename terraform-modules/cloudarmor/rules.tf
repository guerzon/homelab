resource "google_compute_security_policy_rule" "deny_non_ph_origins" {
  security_policy = google_compute_security_policy.default.name
  description     = "Deny non-PH origins"
  priority        = 8000
  action          = "deny(403)"
  match {
    expr {
      expression = "origin.region_code != 'PH'"
    }
  }
}

resource "google_compute_security_policy_rule" "preconfigured_java" {
  security_policy = google_compute_security_policy.default.name
  description     = "Java preconfigured WAF rule"
  priority        = 8001
  action          = "deny(403)"
  match {
    expr {
      expression = "evaluatePreconfiguredWaf('java-v33-stable', {'sensitivity': 3})"
    }
  }
}

resource "google_compute_security_policy_rule" "preconfigured_nodejs" {
  security_policy = google_compute_security_policy.default.name
  description     = "NodeJS preconfigured WAF rule"
  priority        = 8002
  action          = "deny(403)"
  match {
    expr {
      expression = "evaluatePreconfiguredWaf('nodejs-v33-stable', {'sensitivity': 1})"
    }
  }
}

resource "google_compute_security_policy_rule" "preconfigured_sqli" {
  security_policy = google_compute_security_policy.default.name
  description     = "SQL Injection"
  priority        = 9001
  action          = "deny(403)"
  match {
    expr {
      expression = "evaluatePreconfiguredWaf('sqli-v33-stable', {'sensitivity': 3})"
    }
  }
  preview = true
}

resource "google_compute_security_policy_rule" "preconfigured_xss" {
  security_policy = google_compute_security_policy.default.name
  description     = "XSS"
  priority        = 9002
  action          = "deny(403)"
  match {
    expr {
      expression = "evaluatePreconfiguredWaf('xss-v33-stable', {'sensitivity': 2})"
    }
  }
  preview = true
}

resource "google_compute_security_policy_rule" "preconfigured_lfi" {
  security_policy = google_compute_security_policy.default.name
  description     = "Local File Inclusion"
  priority        = 9003
  action          = "deny(403)"
  match {
    expr {
      expression = "evaluatePreconfiguredWaf('lfi-v33-stable', {'sensitivity': 1})"
    }
  }
}

resource "google_compute_security_policy_rule" "preconfigured_rce" {
  security_policy = google_compute_security_policy.default.name
  description     = "Remote Code Execution"
  priority        = 9004
  action          = "deny(403)"
  match {
    expr {
      expression = "evaluatePreconfiguredWaf('rce-v33-stable', {'sensitivity': 3})"
    }
  }
  preview = true
}

resource "google_compute_security_policy_rule" "preconfigured_rfi" {
  security_policy = google_compute_security_policy.default.name
  description     = "Remote File Inclusion"
  priority        = 9005
  action          = "deny(403)"
  match {
    expr {
      expression = "evaluatePreconfiguredWaf('rfi-v33-stable', {'sensitivity': 2})"
    }
  }
}

resource "google_compute_security_policy_rule" "preconfigured_scanner_detection" {
  security_policy = google_compute_security_policy.default.name
  description     = "Scanner Detection"
  priority        = 9006
  action          = "deny(403)"
  match {
    expr {
      expression = "evaluatePreconfiguredWaf('scannerdetection-v33-stable', {'sensitivity': 2})"
    }
  }
}

resource "google_compute_security_policy_rule" "preconfigured_protocol_attack" {
  security_policy = google_compute_security_policy.default.name
  description     = "Protocol Attack"
  priority        = 9007
  action          = "deny(403)"
  match {
    expr {
      expression = "evaluatePreconfiguredWaf('protocolattack-v33-stable', {'sensitivity': 3})"
    }
  }
  preview = true
}

resource "google_compute_security_policy_rule" "preconfigured_session_fixation" {
  security_policy = google_compute_security_policy.default.name
  description     = "Session Fixation"
  priority        = 9008
  action          = "deny(403)"
  match {
    expr {
      expression = "evaluatePreconfiguredWaf('sessionfixation-v33-stable', {'sensitivity': 1})"
    }
  }
}

resource "google_compute_security_policy_rule" "preconfigured_cve_canary" {
  security_policy = google_compute_security_policy.default.name
  description     = "CVEs canary"
  priority        = 9009
  action          = "deny(403)"
  match {
    expr {
      expression = "evaluatePreconfiguredWaf('cve-canary', {'sensitivity': 3})"
    }
  }
}