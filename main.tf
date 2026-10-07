# Terraform GCP Project Baseline Configuration

# -----------------------------------------------------------------------------
# STEP 2: Required Core APIs for Baseline
# -----------------------------------------------------------------------------
# Only APIs justified for the initial project baseline are managed here.
# - serviceusage.googleapis.com: Required to manage GCP API lifecycles in Terraform.
# - cloudresourcemanager.googleapis.com: Required for project metadata & label operations.
locals {
  required_services = [
    "serviceusage.googleapis.com",
    "cloudresourcemanager.googleapis.com"
  ]
}

resource "google_project_service" "required_apis" {
  for_each = toset(local.required_services)

  project = var.project_id
  service = each.key

  # Prevent accidental disabling of fundamental APIs upon destroy
  disable_on_destroy = false
}

# -----------------------------------------------------------------------------
# STEP 3: Project Management & Metadata
# -----------------------------------------------------------------------------
# Declarative import of the existing GCP project into Terraform state.
import {
  to = google_project.project
  id = "project-c0447804-00a1-47a8-b36"
}

resource "google_project" "project" {
  name            = "My First Project"
  project_id      = var.project_id
  org_id          = "36825721252"
  deletion_policy = "PREVENT"

  # Non-authoritative project labels
  labels = {
    environment = var.environment
    managed_by  = "terraform"
  }
}
