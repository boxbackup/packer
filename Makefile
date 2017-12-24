DISTS = centos6 centos7 debian7 debian8 debian9 freebsd103 freebsd111 ubuntu1204 ubuntu1404 ubuntu1604
YML = $(DISTS:=.yml)
JSON = $(DISTS:=.json)

AWS_REGION=eu-west-1
VPC_SUBNET=subnet-f0b17e95
VPC_ID=vpc-ea5fb48f

.SUFFIXES: .yml .json

all: json

json: $(JSON)

.yml.json:
	./yaml2json.py $< > $@
	packer validate $@

build: $(DISTS)

.PHONY: $(DISTS)
$(DISTS):
	env AWS_REGION=$(AWS_REGION) packer build -var subnet_id=$(VPC_SUBNET) -var vpc_id=$(VPC_ID) -var-file $@-vars.json $@.json
