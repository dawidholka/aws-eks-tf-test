output "cicdpeerid" {
  value = aws_vpc_peering_connection.cicd-peer.id
}

output "peerid" {
  value = aws_vpc_peering_connection.def-peer.id
}
