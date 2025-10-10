variable "vpc_cidr" {}
variable "vpc_name" {}
variable "cidr_public_subnet" {}
variable "cidr_private_subnet" {}
variable "availability_zone" {}


output "dev_proj_1_vpc_id" {
  value = aws_vpc.aws_vpc_us_east_1.id
}

output "public_subnet_ids" {
  value = [for s in aws_subnet.aws_public_subnet : s.id]  # list(string)
}



resource aws_vpc "aws_vpc_us_east_1" {
    cidr_block = var.vpc_cidr

    tags= {
        Name = var.vpc_name
    }
}

resource "aws_subnet" "aws_public_subnet" {
    count = length(var.cidr_public_subnet)
    vpc_id = aws_vpc.aws_vpc_us_east_1.id
    cidr_block= element(var.cidr_public_subnet,count.index)
    availability_zone= element(var.availability_zone, count.index)
    tags ={
        Name= "dev_project_public_subnet-${count.index+1}"
    }

}

resource "aws_subnet" "aws_private_subnet" {
    count= length (var.cidr_private_subnet)
    vpc_id= aws_vpc.aws_vpc_us_east_1.id
    cidr_block = element(var.cidr_private_subnet,count.index)
    availability_zone= element(var.availability_zone, count.index)

    tags= {
        Name= "dev_project_private_subnet-${count. index+ 1}"

    }

}

# Internet Gateway for VPC
resource "aws_internet_gateway" "vpc_us_east_1_igw" {
    vpc_id = aws_vpc.aws_vpc_us_east_1.id

    tags = {
        Name= "vpc_us_east_1_igw"
    }
}

# Public route table 

resource "aws_route_table" "dev_proj_public_RT" {
    vpc_id = aws_vpc.aws_vpc_us_east_1.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.vpc_us_east_1_igw.id
    }
    tags = {
        Name = "dev_proj_public_RT"

    }

}

# NAT gateway


# public Route table association

resource "aws_route_table_association" "dev_proj_public_subnet_association"{
    count = length (aws_subnet.aws_public_subnet)
    subnet_id = aws_subnet.aws_public_subnet[count.index].id
    route_table_id = aws_route_table.dev_proj_public_RT.id

}

# Private route table

resource "aws_route_table" "dev_proj_Private_RT" {
    vpc_id =aws_vpc.aws_vpc_us_east_1.id
    #depends_on = [ aws_nat_gateway.nat_gatway ]
    tags={
        Name= "dev_proj_private_RT"
    }
}

# Private RT association
resource "aws_route_table_association" "dev_proj_private_subnet_association"{
    count = length (aws_subnet.aws_private_subnet)
    subnet_id=aws_subnet.aws_private_subnet[count.index].id
    route_table_id = aws_route_table.dev_proj_Private_RT.id
}




