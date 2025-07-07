resource "aws_customer_gateway" "cgw" {
  bgp_asn    = 65000
  ip_address = var.customer_gateway_ip
  type       = "ipsec.1"

  tags = merge(local.tags, {
    Name = "onprem-cgw"
  })
}

resource "aws_vpn_gateway" "vgw" {
  vpc_id = aws_vpc.main.id

  tags = merge(local.tags, {
    Name = "vpn-vgw"
  })
}

resource "aws_vpn_connection" "vpn" {
  customer_gateway_id = aws_customer_gateway.cgw.id
  vpn_gateway_id      = aws_vpn_gateway.vgw.id
  type                = "ipsec.1"
  static_routes_only  = true

  tags = merge(local.tags, {
    Name = "vpn-connection"
  })
}

resource "aws_vpn_connection_route" "route" {
  destination_cidr_block = var.on_prem_cidr
  vpn_connection_id      = aws_vpn_connection.vpn.id
}

resource "aws_route" "to_onprem" {
  route_table_id         = aws_route_table.private.id
  destination_cidr_block = var.on_prem_cidr
  gateway_id             = aws_vpn_gateway.vgw.id
}
