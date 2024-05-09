vpc_cidr="10.0.0.0/16"

region="eu-central-1"

machine_details={
    name="bastion",
    type="t2.micro",
    ami="ami144238737",
    public_ip=true
}

subnets_details=[

{
    name="public1",
    cidr="10.0.1.0/24",
    type="public",
    az="eu-central-1a"
},

{
    name="public2",
    cidr="10.0.2.0/24",
    type="public",
    az="eu-central-1b"
},

{
    name="private1",
    cidr="10.0.3.0/24",
    type="private",
    az="eu-central-1a"
},

{
    name="private2",
    cidr="10.0.4.0/24",
    type="private",
    az="eu-central-1b"
}


]

# create_key_file=true