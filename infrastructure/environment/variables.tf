variable "environment_name" {
  type        = string
  description = "The environment identifier"
}

variable "github_token" {
  type        = string
  description = "The GitHub token to use for creating environments in the repository"
  sensitive   = true
}
