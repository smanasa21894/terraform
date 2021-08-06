1) install terraform and setup the path
2)install the aws cli and configure the keys
profiles for aws cli : your user home directory .aws
 config/credentials 

arguments(input) / attributes(outputs)

terraform.exe paln --var.files dev.tfvars

we are going to create vpc using terraform
provider : aws
region :
resource : vpc
cide = 10.1.0.0/16
enable dns = true


subnets
pubsubnets = ["10.1.0.0/24","10.1.1.0/24","10.1.2.0/24"]
prisubnets = ["10.1.3.0/24","10.1.4.0/24","10.1.5.0/24"]
datasubnets = ["10.1.6.0/24","10.1.7.0/24","10.1.8.0/24"]

igw =
attach =

eip = 
nat = pubsubnet[0]

route
public route 
private route

associate the pubsubnets with igw in public route
associate the privatesubnets with natgw in private route

terraform init
terraform plan
terraform apply
