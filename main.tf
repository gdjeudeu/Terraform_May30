provider "aws" {
  region = "us-east-1"
}
//create VPC
resource "aws_vpc" "vpc_may30" {
    cidr_block = "10.0.0.0/16"
    tags = {
      "key" = "vpc_may30"
    }
}
//Create public subnet
resource "aws_subnet" "public_sub_may30" {
  vpc_id = aws_vpc.vpc_may30.id
  cidr_block = "10.0.1.0/24"
  tags = {
    "key" = "public_sub_may30"
  }
}
//Create private subnet
resource "aws_subnet" "private_sub_may30" {
  vpc_id = aws_vpc.vpc_may30.id
  cidr_block = "10.0.2.0/16"
}
//Create internet gateway
resource "aws_internet_gateway" "igw_may30" {
  tags = {
    "key" = "igw_may30"
  }
}

//Create route table
resource "aws_route_table" "rt_may30" {
  vpc_id = aws-vpc.vpc_may30.id
  route = [ {
    cidr_block = "10.0.1.0/24"
    gateway_id = aws_internet_gateway.igw_may30.id

  } ]
}
//Subnet(s) association
resource "aws_route_table_association" "rt_association_may30" {
  subnet_id = aws_subnet.public_sub_may30.id
  route_table_id = aws_route_table.rt_may30.id
}