variable "project_id" {
  description = "The GCP project ID where resources will be managed."
  type        = string
}

variable "region" {
  description = "The default GCP region to deploy resources in."
  type        = string
  default     = "us-central1"
}

variable "environment" {
  description = "The deployment environment (e.g., dev, staging, prod)."
  type        = string
  default     = "dev"
}

