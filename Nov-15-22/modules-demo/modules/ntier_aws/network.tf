resource "aws_vpc" "ntier" {
    cidr_block      = var.network_cidr
    tags            = {
        Name        = "ntier"
    } 
}


resource "aws_subnet" "subnets" {
    count           = length(var.subnet_name_tags)
    cidr_block      = cidrsubnet(var.network_cidr,8,count.index)
    tags            = {
        Name        = var.subnet_name_tags[count.index]
    } 
    availability_zone = format("${var.region}%s", count.index%2==0?"a":"b")
    vpc_id          = aws_vpc.ntier.id 
}






resource "aws_internet_gateway" "ntier_igw" {
    vpc_id          = aws_vpc.ntier.id
    tags            = {
        Name        = "ntier-igw"
    } 

}


resource "aws_s3_bucket" "my_bucket" {
    bucket          = var.bucket_name 

}