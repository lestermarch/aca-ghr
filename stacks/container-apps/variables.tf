variable "node_pool" {
  default = {
    maximum_nodes = 9
    minimum_nodes = 3
    size          = "small"
    type          = "general_purpose"
  }
  description = <<-EOT
  An object describing the container apps environment workload profile, in the format:
  ```
  {
    maximum_nodes = 9
    minimum_nodes = 3
    size          = "small"
    type          = "general_purpose"
  }
  ```
  EOT
  type = object({
    maximum_nodes = number
    minimum_nodes = number
    size          = optional(string)
    type          = optional(string)
  })

  # Check for valid node type
  validation {
    condition = contains(
      [
        "general_purpose",
        "memory_optimized"
      ],
      var.node_pool.type
    )
    error_message = "Node pool type must be one of \"general_purpose\", or \"memory_optimized\"."
  }

  # Check for valid node size
  validation {
    condition = contains(
      [
        "small",
        "medium",
        "large"
      ],
      var.node_pool.size
    )
    error_message = "Node pool size must be one of \"small\", \"medium\", or \"large\"."
  }
}
