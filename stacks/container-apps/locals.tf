locals {
  # Determine the node pool SKU
  node_pool_sku = join("",
    local.node_pool_sku_lookup.type,
    local.node_pool_sku_lookup.size
  )

  # Map friendly node pool size and type names to values
  node_pool_sku_conversion = {
    size = {
      small  = "4"
      medium = "8"
      large  = "16"
    }
    type = {
      general_purpose  = "D"
      memory_optimized = "E"
    }
  }

  # Lookup node pool size and type values using friendly name
  node_pool_sku_lookup = {
    size = lookup(local.node_pool_sku_conversion.size, var.node_pool.size, "4")
    type = lookup(local.node_pool_sku_conversion.type, var.node_pool.type, "D")
  }
}
