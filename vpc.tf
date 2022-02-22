resource "aws_vpc" "vpc_aula01" {
  cidr_block            = "172.31.0.0/16"
  instance_tenancy      =   "default"
  enable_dns_support    =   true
  enable_dns_hostnames  =   true

  tags = {
    Name = "vpc_aula01"
  }
}

resource "aws_internet_gateway" "igw_aula01" {
  vpc_id = aws_vpc.vpc_aula01.id

  tags = {
    Name = "igw_aula01"
  }
}

resource "aws_nat_gateway" "nat_aula01" {
  allocation_id = aws_eip.eip_nat_aula01.id
  subnet_id     = aws_subnet.subpub1a.id

  tags = {
    Name = "nat_aula01"
  }

  depends_on = [aws_internet_gateway.igw_aula01]
}

resource "aws_eip" "eip_nat_aula01" {
  vpc      = true
}

resource "aws_route_table" "rtb_pub_aula01" {
  vpc_id = aws_vpc.vpc_aula01.id

  route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw_aula01.id
      }  

  tags = {
    Name = "rtb_pub_aula01"
  }
}

resource "aws_route_table" "rtb_priv_aula01" {
  vpc_id = aws_vpc.vpc_aula01.id

  route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_nat_gateway.nat_aula01.id
      }  

  tags = {
    Name = "rtb_priv_aula01"
  }
}

resource "aws_subnet" "subpriv1a" {
  vpc_id                = aws_vpc.vpc_aula01.id
  cidr_block            = "172.31.0.0/18"
  availability_zone_id     = data.aws_availability_zones.az1a.zone_ids[0]

  tags = {
    Name = "subpriv1a"
  }
}

resource "aws_subnet" "subpriv1b" {
  vpc_id                = aws_vpc.vpc_aula01.id
  cidr_block            = "172.31.64.0/18"
  availability_zone_id     = data.aws_availability_zones.az1b.zone_ids[0]

  tags = {
    Name = "subpriv1b"
  }
}
resource "aws_subnet" "subpub1a" {
  vpc_id                = aws_vpc.vpc_aula01.id
  cidr_block            = "172.31.128.0/18"
  availability_zone_id     = data.aws_availability_zones.az1a.zone_ids[0]

  tags = {
    Name = "subpub1a"
  }
}
resource "aws_subnet" "subpub1b" {
  vpc_id                = aws_vpc.vpc_aula01.id
  cidr_block            = "172.31.192.0/18"
  availability_zone_id     = data.aws_availability_zones.az1b.zone_ids[0]

  tags = {
    Name = "subpub1b"
  }
}

resource "aws_route_table_association" "pub1a_aula01" {
  subnet_id      = aws_subnet.subpub1a.id
  route_table_id = aws_route_table.rtb_pub_aula01.id
}

resource "aws_route_table_association" "pub1b_aula01" {
  subnet_id      = aws_subnet.subpub1b.id
  route_table_id = aws_route_table.rtb_pub_aula01.id
}

resource "aws_route_table_association" "priv1a_aula01" {
  subnet_id      = aws_subnet.subpriv1a.id
  route_table_id = aws_route_table.rtb_priv_aula01.id
}

resource "aws_route_table_association" "priv1b_aula01" {
  subnet_id      = aws_subnet.subpriv1b.id
  route_table_id = aws_route_table.rtb_priv_aula01.id
}