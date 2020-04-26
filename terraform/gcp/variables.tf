variable "honeypot_regionmap" {
  type        = map(string)
  description = "Map: {Name}-{Zone}"
  default = {
    "NaNe1c" = "northamerica-northeast1-c"
  }
}
