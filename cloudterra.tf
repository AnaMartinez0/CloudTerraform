resource "aws_vpc" "vpc_cloud_ana" {
    cidr_block = "10.0.0.0/16"
    enable_dns_support = true
    enable_dns_hostnames = true

    tags={
        Name = "Cloud_ana_vpc"
    }
    
}

resource "aws_subnet" "public_1" {
    vpc_id = aws_vpc.vpc_cloud_ana.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "us-east-1a"
    map_public_ip_on_launch = true

    tags = {
        Name = "Public1"
    }
}

resource "aws_subnet" "public_2" {
    vpc_id     = aws_vpc.vpc_cloud_ana.id
    cidr_block = "10.0.2.0/24"
    availability_zone = "us-east-1b"
    map_public_ip_on_launch = true

    tags = {
        Name = "Public2"
    }
}
resource "aws_subnet" "private_1" {
    vpc_id     = aws_vpc.vpc_cloud_ana.id
    cidr_block = "10.0.3.0/24"
    availability_zone = "us-east-1c"
    map_public_ip_on_launch = true
    
    tags = {
        Name = "Private1"
    }
}
resource "aws_subnet" "private_2" {
    vpc_id     = aws_vpc.vpc_cloud_ana.id
    cidr_block = "10.0.4.0/24"
    availability_zone = "us-east-1d"
    map_public_ip_on_launch = true
    
    tags = {
        Name = "Private2"
    }
}

resource "aws_internet_gateway" "igw_ana_cloud" {
    vpc_id = aws_vpc.vpc_cloud_ana.id
    
    tags = {
        Name = "Internet_GateWay"
    }
}

resource "aws_route_table" "route_table_ana_public" {
    vpc_id = aws_vpc.vpc_cloud_ana.id
    
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw_ana_cloud.id
        
    }
        
    tags = {
        Name = "Tabla_enrrutmientoPublic_ana"
    }
}

resource "aws_route_table" "route_table_ana_private" {
    vpc_id = aws_vpc.vpc_cloud_ana.id
    
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw_ana_cloud.id
        
    }
        
    tags = {
        Name = "Tabla_enrrutmientoPrivate_ana"
    }
}

resource "aws_route_table_association" "asociacion_publica1" {
    subnet_id = aws_subnet.public_1.id
    route_table_id = aws_route_table.route_table_ana_public.id
}

resource "aws_route_table_association" "asociacion_publica2" {
    subnet_id = aws_subnet.public_2.id
    route_table_id = aws_route_table.route_table_ana_public.id  
}

resource "aws_route_table_association" "asociacion_privada1" {
    subnet_id = aws_subnet.private_1.id
    route_table_id = aws_route_table.route_table_ana_private.id  
}

resource "aws_route_table_association" "asociacion_privada2" {
    subnet_id = aws_subnet.private_2.id
    route_table_id = aws_route_table.route_table_ana_private.id
}