resource "aws_eip" "eipalloc-052dd24eaa93ed064" {
  public_ipv4_pool = "amazon"
  tags             = {}
  vpc              = true

  timeouts {}
}
