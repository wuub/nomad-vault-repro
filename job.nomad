job "job" {
  datacenters = ["dc1"]

  task "job-app" {
    vault {
      policies = ["job"]
    }

    template {
      data = <<EOH
{{ with secret "secret/db/prod/job" }}
user ="{{.Data.role}}"
password="{{.Data.password}}")
}
{{ end }}
EOH

      destination = "${NOMAD_SECRETS_DIR}/config.cfg"
    }

    driver = "docker"

    config {
      image = "redis:latest"
    }

    resources {
      cpu     = 200
      memory  = 256
      network = {}
    }
  }
}
